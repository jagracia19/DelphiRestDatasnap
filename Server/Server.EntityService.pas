unit Server.EntityService;

interface

uses
  SQLUtils.Classes,
  System.JSON,
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.IBBase;

type
{$METHODINFO ON}
  TDataModuleEntity = class(TDataModule)
    Connection: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    Query: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FEntidad: TSQLEntity;
    function GetNombreTabla: string;
    procedure SetNombreTabla(const Value: string);
    function GetClavePrimaria: string;
    procedure SetClavePrimaria(const Value: string);
  protected
    procedure ConfigurarBasedatos;
    procedure IniciarEntidad; virtual; abstract;
    property Entidad: TSQLEntity read FEntidad;
  public
    function LeerTodo: TJSONValue;
    property NombreTabla: string read GetNombreTabla write SetNombreTabla;
    property ClavePrimaria: string read GetClavePrimaria write SetClavePrimaria;
  end;
{$METHODINFO OFF}

var
  DataModuleEntity: TDataModuleEntity;

implementation

uses
  JSONAuto.Utils,
  Server.Logger,
  Server.Config;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModuleEntity }

procedure TDataModuleEntity.ConfigurarBasedatos;
begin
  Connection.Params.Values['Server'] := Config.BasedatosServidor;
  Connection.Params.Values['Database'] := Config.BasedatosNombre;
end;

procedure TDataModuleEntity.DataModuleCreate(Sender: TObject);
begin
  Log.Log('TDataModuleEntity.DataModuleCreate');

  FEntidad := TSQLEntity.Create(nil);
  IniciarEntidad;

  ConfigurarBaseDatos;
  Connection.Connected := True;
end;

procedure TDataModuleEntity.DataModuleDestroy(Sender: TObject);
begin
  Connection.Connected := False;
  FreeAndNil(FEntidad);
  Log.Log('TDataModuleEntity.DataModuleDestroy');
end;

function TDataModuleEntity.GetClavePrimaria: string;
begin
  Result := Entidad.PKName;
end;

function TDataModuleEntity.GetNombreTabla: string;
begin
  Result := Entidad.TableName;
end;

function TDataModuleEntity.LeerTodo: TJSONValue;
var sql: string;
begin
  Log.Log(ClassName + '.ReadAll');
  sql := TSQLSelect.Select(Entidad);
  Query.Open(sql);
  Result := TJSONDataSet.ReadAllRows(Query);
end;

procedure TDataModuleEntity.SetClavePrimaria(const Value: string);
begin
  Entidad.PKName := Value;
end;

procedure TDataModuleEntity.SetNombreTabla(const Value: string);
begin
  Entidad.TableName := Value;
end;

end.
