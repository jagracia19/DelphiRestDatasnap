unit ClientCustomWin.FormMain;

interface

uses
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  DBXJSON,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Generics.Collections;

type
  TFormMain = class(TForm)
    Memo1: TMemo;
    IdHTTP1: TIdHTTP;
    Panel1: TPanel;
    EditParam: TEdit;
    ButtonManual: TButton;
    ButtonDataSet: TButton;
    ButtonHttpGet: TButton;
    ButtonSwipCapturas: TButton;
    procedure ButtonManualClick(Sender: TObject);
    procedure ButtonDataSetClick(Sender: TObject);
    procedure ButtonHttpGetClick(Sender: TObject);
    procedure ButtonSwipCapturasClick(Sender: TObject);
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
  ClientDSRest.HttpControl,
  Swip.HttpControl,
  ClientCustomWin.JsonParser;

{$R *.dfm}

const
  SERVER_URL        = 'http://172.26.0.19:8080';
  PATH_DS_REST      = '/datasnap/rest';
  METHOD_REVERSE    = '/TServerMethods1/ReverseString/';
  METHOD_CLIENTES   = '/TDataModuleClientes/LeerTodo';
  METHOD_CAPTURAS   = '/TDataModuleCapturas/LeerPendiente';

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

var jsonValue   : TJSONValue;
    stResult    : string;
    stError     : string;
begin
  Memo1.Lines.Add('Clientes:');
  stResult := IdHTTP1.Get(SERVER_URL + PATH_DS_REST + METHOD_CLIENTES);
  Memo1.Lines.Add(stResult);

  jsonValue := nil;
  try
    // string to JSON value
    jsonValue := TClientDSRestHttpControl.ParseJsonResult(stResult, stError);

    // parse JSON
    if jsonValue <> nil then
      ParseLeerTodo(jsonValue, TCliente, TClienteJson);
  finally
    if jsonValue <> nil then
      jsonValue.Free;
  end;
end;

procedure TFormMain.ButtonHttpGetClick(Sender: TObject);
var http      : TClientDSRestHttpControl;
    jsonValue : TJSONValue;
begin
  http := TClientDSRestHttpControl.Create;
  try
    http.URLApi := SERVER_URL + PATH_DS_REST;
    http.Usuario := '2396';
    http.Clave := 'f4stOBfJybmu55U';

    jsonValue := http.LeerEntidad(METHOD_CLIENTES, '', '');
    if jsonValue <> nil then
      try
        Memo1.Lines.Add(jsonValue.ToString);
      finally
        jsonValue.Free;
      end;

    jsonValue := http.LeerEntidad(METHOD_CAPTURAS, '', '');
    if jsonValue <> nil then
      try
        Memo1.Lines.Add(jsonValue.ToString);
      finally
        jsonValue.Free;
      end;
  finally
    http.Free;
  end;
end;

procedure TFormMain.ButtonManualClick(Sender: TObject);
var stParam   : string;
    stResult  : string;
begin
  // Http Get
  stParam := EditParam.Text;
  stResult := IdHTTP1.Get(SERVER_URL + PATH_DS_REST + METHOD_REVERSE + stParam);
  Memo1.Lines.Add(stResult);

  // Parser JSON  ej: {"result":["aloH"]}
  stResult := ParseResultSample(stResult);
  Memo1.Lines.Add(stResult);
end;

procedure TFormMain.ButtonSwipCapturasClick(Sender: TObject);
var http      : TSwipHttpControl;
    capturas  : TList<TCaptura>;
    captura   : TCaptura;
begin
  capturas := TObjectList<TCaptura>.Create;
  try
    http := TSwipHttpControl.Create;
    try
      http.Usuario := '2396';
      http.Clave := 'f4stOBfJybmu55U';

      http.LeerCapturasPendientes(capturas);

      { TODO : marcar capturas como procesadas }

      for captura in capturas do
      Memo1.Lines.Add(captura.ToString);
    finally
      http.Free;
    end;
  finally
    capturas.Free;
  end;
end;

end.
