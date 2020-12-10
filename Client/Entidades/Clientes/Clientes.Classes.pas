unit Clientes.Classes;

interface

uses
  Entity.Classes,
  {$IF CompilerVersion < 33.0}
  SysUtils;
  {$ELSE}
  System.SysUtils;
  {$IFEND}

type
  TCliente = class(TDatabaseEntity)
  private
    FIdCliente: Integer;
    FNombre: string;
    FApiKey: string;
  public
    function ToString: string; override;
    property IdCliente: Integer read FIdCliente write FIdCliente;
    property Nombre: string read FNombre write FNombre;
    property ApiKey: string read FApiKey write FApiKey;
  end;

implementation

{ TCliente }

function TCliente.ToString: string;
begin
  Result := IntToStr(IdCliente) + ':' +
            Nombre + ':' +
            ApiKey;
end;

end.
