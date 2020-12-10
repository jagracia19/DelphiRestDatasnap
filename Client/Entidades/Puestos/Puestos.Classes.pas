unit Puestos.Classes;

interface

uses
  Entity.Classes,
  System.SysUtils;

type
  TPuesto = class(TDatabaseEntity)
  private
    FIdPuesto: Integer;
    FIdCliente: Integer;
    FNombre: string;
    FApiKey: string;
    FIp: string;
    FPuerto: Integer;
  public
    function ToString: string; override;
    property IdPuesto: Integer read FIdPuesto write FIdPuesto;
    property IdCliente: Integer read FIdCliente write FIdCliente;
    property Nombre: string read FNombre write FNombre;
    property ApiKey: string read FApiKey write FApiKey;
    property Ip: string read FIp write FIp;
    property Puerto: Integer read FPuerto write FPuerto;
  end;

implementation

{ TPuesto }

function TPuesto.ToString: string;
begin
  Result := IntToStr(IdPuesto) + ':' +
            IntToStr(IdCliente) + ':' +
            Nombre + ':' +
            ApiKey + ':' +
            Ip + ':' +
            IntToStr(Puerto);
end;

end.
