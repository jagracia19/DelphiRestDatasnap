unit ClientDSRestWin.FormMain;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFormMain = class(TForm)
    Panel1: TPanel;
    EditParam: TEdit;
    ButtonManual: TButton;
    Memo1: TMemo;
    procedure ButtonManualClick(Sender: TObject);
  private
  public
  end;

var
  FormMain: TFormMain;

implementation

uses
  ClientModuleUnit1;

{$R *.dfm}

procedure TFormMain.ButtonManualClick(Sender: TObject);
var stParam : string;
    stResult: string;
begin
  stParam := EditParam.Text;
  stResult := ClientModule1.ServerMethods1Client.ReverseString(stParam);
  Memo1.Lines.Add(stResult);
end;

end.
