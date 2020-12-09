unit Server.Config;

interface

uses
  System.SysUtils, System.IOUtils, System.IniFiles;

type
  TConfig = class
  private
    // SERVICIO
    FServicioPuerto: Integer;
    // BASE DATOS
    FBasedatosServidor: string;
    FBasedatosNombre: string;
  public
    constructor Create;
    class function GetFicheroConfig: string;
    procedure LeerDesdeFichero(const AFichero: string);
    procedure EscribirEnFichero(const AFichero: string);
    // SERVICIO
    property ServicioPuerto: Integer read FServicioPuerto write FServicioPuerto;
    // BASE DATOS
    property BasedatosServidor: string read FBasedatosServidor
      write FBasedatosServidor;
    property BasedatosNombre: string read FBasedatosNombre
      write FBasedatosNombre;
  end;

var Config: TConfig;

implementation

uses
  Server.Common,
  Server.Logger;

const
  SecServicio   = 'SERVICIO';
    IdPuerto    = 'Puerto';
  SecBasedatos  = 'BASEDATOS';
    IdServidor  = 'Servidor';
    IdNombre    = 'Nombre';

{ TConfig }

constructor TConfig.Create;
begin
  inherited;
  // SERVICIO
  FServicioPuerto := 8080;
  // BASE DATOS
  FBasedatosServidor := '127.0.0.1';
  FBasedatosNombre := 'DATABASE.FDB';
end;

procedure TConfig.EscribirEnFichero(const AFichero: string);
var F: TIniFile;
begin
  F := TIniFile.Create(AFichero);
  with F do
  try
    // SERVICIO
    WriteInteger(SecServicio, IdPuerto, FServicioPuerto);
    // BASE DATOS
    WriteString(SecBasedatos, IdServidor, FBasedatosServidor);
    WriteString(SecBasedatos, IdNombre, FBasedatosNombre);
  finally
    Free;
  end;
end;

class function TConfig.GetFicheroConfig: string;
var dir: string;
    st : string;
begin
  st := NOMBRE_SERVIDOR;
  dir := TPath.Combine(TPath.GetDocumentsPath, st);
  {$IFDEF LINUX}
    {$IFDEF MODULE}
    dir := TPath.DirectorySeparatorChar + st;
    {$ENDIF}
  {$ENDIF}
  TDirectory.CreateDirectory(dir);
  Result := TPath.Combine(dir, TPath.ChangeExtension(st, '.ini'));
end;

procedure TConfig.LeerDesdeFichero(const AFichero: string);
var F: TIniFile;
begin
  F := TIniFile.Create(AFichero);
  with F do
  try
    // SERVICIO
    FServicioPuerto := ReadInteger(SecServicio, IdPuerto, FServicioPuerto);
    // BASE DATOS
    FBasedatosServidor := ReadString(SecBasedatos, IdServidor, FBasedatosServidor);
    FBasedatosNombre := ReadString(SecBasedatos, IdNombre, FBasedatosNombre);
  finally
    Free;
  end;
end;

initialization
  Config := TConfig.Create;
  if not TFile.Exists(Config.GetFicheroConfig) then
    Config.EscribirEnFichero(Config.GetFicheroConfig);
  config.LeerDesdeFichero(Config.GetFicheroConfig);
  Log.Log('Config file "' + Config.GetFicheroConfig + '"');

finalization
  FreeAndNil(Config);
end.
