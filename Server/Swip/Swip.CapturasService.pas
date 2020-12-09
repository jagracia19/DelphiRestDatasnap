unit Swip.CapturasService;

interface

uses
  System.SysUtils, System.Classes, Server.EntityService, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.IBBase;

type
{$METHODINFO ON}
  TDataModuleCapturas = class(TDataModuleEntity)
  private
  protected
    procedure IniciarEntidad; override;
  public
    function LeerPendiente: TDataSet;
  end;
{$METHODINFO OFF}

var
  DataModuleCapturas: TDataModuleCapturas;

implementation

uses
  SQLUtils.Classes,
  Server.Logger;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModuleCapturas }

procedure TDataModuleCapturas.IniciarEntidad;
begin
  //inherited;
  NombreTabla := 'CAPTURAS';
  ClavePrimaria := 'ID_CAPTURA';
end;

function TDataModuleCapturas.LeerPendiente: TDataSet;
var sql: string;
begin
  Log.Log(ClassName + '.ReadAllPendiente');
  sql := TSQLSelect.Select(Entidad, '(procesada=0)');
  Query.Open(sql);
  Result := Query;
end;

end.
