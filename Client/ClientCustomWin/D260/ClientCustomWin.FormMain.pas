unit ClientCustomWin.FormMain;

interface

uses
  System.JSON,
  System.Generics.Collections,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFormMain = class(TForm)
    Panel1: TPanel;
    EditParam: TEdit;
    ButtonManual: TButton;
    Memo1: TMemo;
    IdHTTP1: TIdHTTP;
    procedure ButtonManualClick(Sender: TObject);
  private
  public
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

const
  SERVER_URL = 'http://172.26.0.19:8080';
  METHOD_URL = '/datasnap/rest/TServerMethods1/ReverseString/';

procedure TFormMain.ButtonManualClick(Sender: TObject);
var stParam   : string;
    stResult  : string;
    jsonValue : TJSONValue;
    jsonObject: TJSONObject;
    jsonPair  : TJSONPair;
    jsonArray : TJSONArray;
begin
  // Http Get
  stParam := EditParam.Text;
  stResult := IdHTTP1.Get(SERVER_URL + METHOD_URL + stParam);
  Memo1.Lines.Add(stResult);

  // Parser JSON  ej: {"result":["aloH"]}
  jsonValue := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(stResult), 0);
  try
    jsonObject := jsonValue as TJSONObject;
    //XE jsonPair := jsonObject.Get(0);
    jsonPair := jsonObject.Pairs[0];
    jsonArray := jsonPair.JsonValue as TJSONArray;
    //XE stResult := jsonArray.Get(0).Value;
    stResult := jsonArray.Items[0].Value;
    Memo1.Lines.Add(stResult);
  finally
    jsonValue.Free;
  end;
end;

end.
