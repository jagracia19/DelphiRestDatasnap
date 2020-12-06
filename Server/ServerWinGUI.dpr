program ServerWinGUI;
{$APPTYPE GUI}

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  ServWinGui.FormMain in 'ServWinGui.FormMain.pas' {Form1},
  ServerMethodsUnit1 in 'ServerMethodsUnit1.pas',
  Server.WebModule in 'Server.WebModule.pas' {WebModule1: TWebModule};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
