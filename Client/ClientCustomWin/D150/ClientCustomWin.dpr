program ClientCustomWin;

uses
  Forms,
  JSONAuto.Utils in '..\..\..\Library\JSONAuto\JSONAuto.Utils.pas',
  Entity.Classes in '..\..\Entidades\Entity.Classes.pas',
  Entity.Json in '..\..\Entidades\Entity.Json.pas',
  Clientes.Classes in '..\..\Entidades\Clientes\Clientes.Classes.pas',
  Clientes.Json in '..\..\Entidades\Clientes\Clientes.Json.pas',
  Puestos.Classes in '..\..\Entidades\Puestos\Puestos.Classes.pas',
  Puestos.Json in '..\..\Entidades\Puestos\Puestos.Json.pas',
  Capturas.Classes in '..\..\Entidades\Capturas\Capturas.Classes.pas',
  Capturas.Json in '..\..\Entidades\Capturas\Capturas.Json.pas',
  ClientDSRest.HttpControl in '..\HTTP\ClientDSRest.HttpControl.pas',
  JSON.Helper in 'JSON\JSON.Helper.pas',
  ClientCustomWin.JsonParser in '..\JSON\ClientCustomWin.JsonParser.pas',
  ClientCustomWin.FormMain in 'ClientCustomWin.FormMain.pas' {FormMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
