unit ClientModuleUnit1;

interface

uses
  System.SysUtils, System.Classes, ClientClassesUnit1, Datasnap.DSClientRest;

type
  TClientModule1 = class(TDataModule)
    DSRestConnection1: TDSRestConnection;
  private
    FInstanceOwner: Boolean;
    FServerMethods1Client: TServerMethods1Client;
    FDataModuleClientesClient: TDataModuleClientesClient;
    function GetServerMethods1Client: TServerMethods1Client;
    function GetDataModuleClientesClient: TDataModuleClientesClient;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property InstanceOwner: Boolean read FInstanceOwner write FInstanceOwner;
    property ServerMethods1Client: TServerMethods1Client read GetServerMethods1Client
      write FServerMethods1Client;
    property DataModuleClientesClient: TDataModuleClientesClient
      read GetDataModuleClientesClient write FDataModuleClientesClient;
  end;

var
  ClientModule1: TClientModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

constructor TClientModule1.Create(AOwner: TComponent);
begin
  inherited;
  FInstanceOwner := True;
end;

destructor TClientModule1.Destroy;
begin
  if FServerMethods1Client <> nil then
    FServerMethods1Client.Free;
  if FDataModuleClientesClient <> nil then
    FDataModuleClientesClient.Free;
  inherited;
end;

function TClientModule1.GetDataModuleClientesClient: TDataModuleClientesClient;
begin
  if FDataModuleClientesClient = nil then
    FDataModuleClientesClient := TDataModuleClientesClient.Create(DSRestConnection1, FInstanceOwner);
  Result := FDataModuleClientesClient;
end;

function TClientModule1.GetServerMethods1Client: TServerMethods1Client;
begin
  if FServerMethods1Client = nil then
    FServerMethods1Client:= TServerMethods1Client.Create(DSRestConnection1, FInstanceOwner);
  Result := FServerMethods1Client;
end;

end.
