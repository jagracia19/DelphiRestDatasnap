program ClientCustomWin;

uses
  Vcl.Forms,
  ClientCustomWin.FormMain in 'ClientCustomWin.FormMain.pas' {FormMain},
  ClientCustomWin.JsonParser in '..\JSON\ClientCustomWin.JsonParser.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
