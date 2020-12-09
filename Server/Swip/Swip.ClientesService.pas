unit Swip.ClientesService;

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
  TDataModuleClientes = class(TDataModuleEntity)
  private
  protected
    procedure IniciarEntidad; override;
  public
  end;
{$METHODINFO OFF}

var
  DataModuleClientes: TDataModuleClientes;

implementation

uses
  Server.Logger;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModuleClientes }

procedure TDataModuleClientes.IniciarEntidad;
begin
  //inherited;
  NombreTabla := 'CLIENTES';
  ClavePrimaria := 'ID_CLIENTE';
end;

end.
