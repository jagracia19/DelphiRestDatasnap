unit Capturas.Classes;

interface

uses
  Entity.Classes,
  {$IF CompilerVersion < 33.0}
  SysUtils;
  {$ELSE}
  System.SysUtils;
  {$IFEND}

type
  TCaptura = class(TDatabaseEntity)
  private
    FIdCaptura: Integer;
    FIdPuesto: Integer;
    FIdCliente: Integer;
    FFechaHora: TDateTime;
    FCaptura: string;
    FProcesada: Boolean;
  public
    function ToString: string; override;
    property IdCaptura: Integer read FIdCaptura write FIdCaptura;
    property IdPuesto: Integer read FIdPuesto write FIdPuesto;
    property IdCliente: Integer read FIdCliente write FIdCliente;
    property FechaHora: TDateTime read FFechaHora write FFechaHora;
    property Captura: string read FCaptura write FCaptura;
    property Procesada: Boolean read FProcesada write FProcesada;
  end;

implementation

{ TCaptura }

function TCaptura.ToString: string;
begin
  Result := IntToStr(IdCaptura) + ':' +
            IntToStr(IdPuesto) + ':' +
            IntToStr(IdCliente) + ':' +
            DateTimeToStr(FechaHora) + ':' +
            Captura + ':' +
            BoolToStr(Procesada, True);
end;

end.
