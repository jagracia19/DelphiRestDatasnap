unit Swip.PuestosService;

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
  TDataModulePuestos = class(TDataModuleEntity)
  private
  protected
    procedure IniciarEntidad; override;
  public
  end;
{$METHODINFO OFF}

var
  DataModulePuestos: TDataModulePuestos;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModulePuestos }

procedure TDataModulePuestos.IniciarEntidad;
begin
  //inherited;
  NombreTabla := 'PUESTOS';
  ClavePrimaria := 'ID_PUESTO';
end;

end.
