unit ClientCustomWin.FormMain;

interface

uses
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  DBXJSON,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFormMain = class(TForm)
    Memo1: TMemo;
    IdHTTP1: TIdHTTP;
    Panel1: TPanel;
    EditParam: TEdit;
    ButtonManual: TButton;
    procedure ButtonManualClick(Sender: TObject);
  private
  public
  end;

var
  FormMain: TFormMain;

implementation

uses
  ClientCustomWin.JsonParser;

{$R *.dfm}

const
  SERVER_URL = 'http://172.26.0.19:8080';
  METHOD_URL = '/datasnap/rest/TServerMethods1/ReverseString/';

procedure TFormMain.ButtonManualClick(Sender: TObject);
var stParam   : string;
    stResult  : string;
begin
  // Http Get
  stParam := EditParam.Text;

  stResult := IdHTTP1.Get(SERVER_URL + METHOD_URL + stParam);
  Memo1.Lines.Add(stResult);

  // Parser JSON  ej: {"result":["aloH"]}
  stResult := ParseResultSample(stResult);
  Memo1.Lines.Add(stResult);
end;

end.
