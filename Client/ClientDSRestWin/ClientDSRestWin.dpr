program ClientDSRestWin;

uses
  Vcl.Forms,
  ClientDSRestWin.FormMain in 'ClientDSRestWin.FormMain.pas' {FormMain},
  ClientClassesUnit1 in 'ClientClassesUnit1.pas',
  ClientModuleUnit1 in 'ClientModuleUnit1.pas' {ClientModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TClientModule1, ClientModule1);
  Application.Run;
end.
