unit ClientDSRestWin.FormMain;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.Db;

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
  ClientModuleUnit1;

{$R *.dfm}

procedure TFormMain.ButtonDataSetClick(Sender: TObject);
var dataset: TDataSet;
begin
  dataset := ClientModule1.DataModuleClientesClient.LeerTodo;
  dataset.Active := True;
  dataset.First;
  while not dataset.Eof do
  begin
    Memo1.Lines.Add(Format('%d: %s',
        [dataset.FieldByName('id_cliente').AsInteger,
         dataset.FieldByName('nombre').AsString]));
    dataset.Next;
  end;
  dataset.Active := False;
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
