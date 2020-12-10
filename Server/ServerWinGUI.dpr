program ServerWinGUI;
{$APPTYPE GUI}

{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  SQLUtils.Classes in '..\Library\SQLUtils\SQLUtils.Classes.pas',
  JSONAuto.Utils in '..\Library\JSONAuto\JSONAuto.Utils.pas',
  Server.Common in 'Server.Common.pas',
  Server.Logger in 'Server.Logger.pas',
  Server.Config in 'Server.Config.pas',
  Server.EntityService in 'Server.EntityService.pas' {DataModuleEntity: TDataModule},
  Swip.ClientesService in 'Swip\Swip.ClientesService.pas' {DataModuleClientes: TDataModule},
  Swip.PuestosService in 'Swip\Swip.PuestosService.pas' {DataModulePuestos: TDataModule},
  Swip.CapturasService in 'Swip\Swip.CapturasService.pas' {DataModuleCapturas: TDataModule},
  ServerMethodsUnit1 in 'ServerMethodsUnit1.pas',
  Server.WebModule in 'Server.WebModule.pas' {WebModule1: TWebModule},
  ServWinGui.FormMain in 'ServWinGui.FormMain.pas' {FormMain};

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
