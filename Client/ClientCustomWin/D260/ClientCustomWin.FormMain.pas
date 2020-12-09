unit ClientCustomWin.FormMain;

interface

uses
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
  ClientCustomWin.JsonParser;

{$R *.dfm}

const
  SERVER_URL        = 'http://172.26.0.19:8080';
  PATH_DS_REST      = '/datasnap/rest';
  METHOD_REVERSE    = '/TServerMethods1/ReverseString/';
  METHOD_CLIENTES   = '/TDataModuleClientes/LeerTodo';

procedure TFormMain.ButtonDataSetClick(Sender: TObject);
var stResult: string;
begin
  // Http Get
  stResult := IdHTTP1.Get(SERVER_URL + PATH_DS_REST + METHOD_CLIENTES);
  Memo1.Lines.Add(stResult);

  // Parser JSON  ej: {"result":["aloH"]}
  stResult := ParseResultSample(stResult);
  Memo1.Lines.Add(stResult);
end;

procedure TFormMain.ButtonManualClick(Sender: TObject);
var stParam : string;
    stResult: string;
begin
  // Http Get
  stParam := EditParam.Text;
  stResult := IdHTTP1.Get(SERVER_URL + PATH_DS_REST + METHOD_REVERSE + stParam);
  Memo1.Lines.Add(stResult);

  // Parser JSON  ej: {"result":["aloH"]}
  stResult := ParseResultSample(stResult);
  Memo1.Lines.Add(stResult);
end;

end.
