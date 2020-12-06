program ClientCustomWin;

uses
  Vcl.Forms,
  ClientCustomWin.FormMain in 'ClientCustomWin.FormMain.pas' {FormMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
