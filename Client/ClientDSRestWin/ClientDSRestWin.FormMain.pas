unit ClientDSRestWin.FormMain;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.JSON, System.Generics.Collections;

type
  TFormMain = class(TForm)
    Panel1: TPanel;
    EditParam: TEdit;
    ButtonManual: TButton;
    Memo1: TMemo;
    ButtonDataSet: TButton;
    procedure ButtonManualClick(Sender: TObject);
    procedure ButtonDataSetClick(Sender: TObject);
  private
  public
  end;

var
  FormMain: TFormMain;

implementation

uses
  Clientes.Classes,
  Clientes.Json,
  Puestos.Classes,
  Puestos.Json,
  Capturas.Classes,
  Capturas.Json,
  Entity.Classes,
  Entity.Json,
  ClientModuleUnit1;

{$R *.dfm}

procedure TFormMain.ButtonDataSetClick(Sender: TObject);

  procedure ParseLeerTodo(AJsonValue: TJSONValue;
    AEntityClass: TDatabaseEntityClass; AJsonClass: TDatabaseEntityJsonClass);
  var list: TList<TDatabaseEntity>;
      item: TDatabaseEntity;
  begin
    list := TObjectList<TDatabaseEntity>.Create;
    try
      if AJsonValue is TJSONArray then
        AJsonClass.Parse(TJSONArray(AJsonValue), list);
      for item in list do
        Memo1.Lines.Add(item.ToString);
    finally
      list.Free;
    end;
  end;

var jsonValue : TJSONValue;
begin
  Memo1.Lines.Add('Clientes:');
  jsonValue := ClientModule1.DataModuleClientesClient.LeerTodo;
  Memo1.Lines.Add(jsonValue.ToString);
  ParseLeerTodo(jsonValue, TCliente, TClienteJson);

  Memo1.Lines.Add('Puestos:');
  jsonValue := ClientModule1.DataModulePuestosClient.LeerTodo;
  Memo1.Lines.Add(jsonValue.ToString);
  ParseLeerTodo(jsonValue, TPuesto, TPuestoJson);

  Memo1.Lines.Add('Capturas:');
  jsonValue := ClientModule1.DataModuleCapturasClient.LeerTodo;
  Memo1.Lines.Add(jsonValue.ToString);
  ParseLeerTodo(jsonValue, TCaptura, TCapturaJson);
end;

procedure TFormMain.ButtonManualClick(Sender: TObject);
var stParam : string;
    stResult: string;
begin
  stParam := EditParam.Text;
  stResult := ClientModule1.ServerMethods1Client.ReverseString(stParam);
  Memo1.Lines.Add(stResult);
end;

end.
