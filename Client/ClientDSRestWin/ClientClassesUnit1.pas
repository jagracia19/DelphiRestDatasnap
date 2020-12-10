//
// Created by the DataSnap proxy generator.
// 10/12/2020 8:06:32
//

unit ClientClassesUnit1;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TServerMethods1Client = class(TDSAdminRestClient)
  private
    FEchoStringCommand: TDSRestCommand;
    FReverseStringCommand: TDSRestCommand;
    FAddIntCommand: TDSRestCommand;
    FAddDoubleCommand: TDSRestCommand;
    FIsOkCommand: TDSRestCommand;
    FGetLargeStringCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string; const ARequestFilter: string = ''): string;
    function ReverseString(Value: string; const ARequestFilter: string = ''): string;
    function AddInt(A: Integer; B: Integer; const ARequestFilter: string = ''): Integer;
    function AddDouble(A: Double; B: Double; const ARequestFilter: string = ''): Double;
    function IsOk(const ARequestFilter: string = ''): Boolean;
    function GetLargeString(Count: Integer; const ARequestFilter: string = ''): string;
  end;

  TDataModuleEntityClient = class(TDSAdminRestClient)
  private
    FDataModuleCreateCommand: TDSRestCommand;
    FDataModuleDestroyCommand: TDSRestCommand;
    FLeerTodoCommand: TDSRestCommand;
    FLeerTodoCommand_Cache: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    function LeerTodo(const ARequestFilter: string = ''): TJSONValue;
    function LeerTodo_Cache(const ARequestFilter: string = ''): IDSRestCachedJSONValue;
  end;

  TDataModuleClientesClient = class(TDSAdminRestClient)
  private
    FDataModuleCreateCommand: TDSRestCommand;
    FDataModuleDestroyCommand: TDSRestCommand;
    FLeerTodoCommand: TDSRestCommand;
    FLeerTodoCommand_Cache: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    function LeerTodo(const ARequestFilter: string = ''): TJSONValue;
    function LeerTodo_Cache(const ARequestFilter: string = ''): IDSRestCachedJSONValue;
  end;

  TDataModulePuestosClient = class(TDSAdminRestClient)
  private
    FDataModuleCreateCommand: TDSRestCommand;
    FDataModuleDestroyCommand: TDSRestCommand;
    FLeerTodoCommand: TDSRestCommand;
    FLeerTodoCommand_Cache: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    function LeerTodo(const ARequestFilter: string = ''): TJSONValue;
    function LeerTodo_Cache(const ARequestFilter: string = ''): IDSRestCachedJSONValue;
  end;

  TDataModuleCapturasClient = class(TDSAdminRestClient)
  private
    FLeerPendienteCommand: TDSRestCommand;
    FLeerPendienteCommand_Cache: TDSRestCommand;
    FDataModuleCreateCommand: TDSRestCommand;
    FDataModuleDestroyCommand: TDSRestCommand;
    FLeerTodoCommand: TDSRestCommand;
    FLeerTodoCommand_Cache: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function LeerPendiente(const ARequestFilter: string = ''): TJSONValue;
    function LeerPendiente_Cache(const ARequestFilter: string = ''): IDSRestCachedJSONValue;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    function LeerTodo(const ARequestFilter: string = ''): TJSONValue;
    function LeerTodo_Cache(const ARequestFilter: string = ''): IDSRestCachedJSONValue;
  end;

const
  TServerMethods1_EchoString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_ReverseString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_AddInt: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'A'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'B'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 6; TypeName: 'Integer')
  );

  TServerMethods1_AddDouble: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'A'; Direction: 1; DBXType: 7; TypeName: 'Double'),
    (Name: 'B'; Direction: 1; DBXType: 7; TypeName: 'Double'),
    (Name: ''; Direction: 4; DBXType: 7; TypeName: 'Double')
  );

  TServerMethods1_IsOk: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 4; TypeName: 'Boolean')
  );

  TServerMethods1_GetLargeString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Count'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TDataModuleEntity_DataModuleCreate: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Sender'; Direction: 1; DBXType: 37; TypeName: 'TObject')
  );

  TDataModuleEntity_DataModuleDestroy: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Sender'; Direction: 1; DBXType: 37; TypeName: 'TObject')
  );

  TDataModuleEntity_LeerTodo: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONValue')
  );

  TDataModuleEntity_LeerTodo_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDataModuleClientes_DataModuleCreate: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Sender'; Direction: 1; DBXType: 37; TypeName: 'TObject')
  );

  TDataModuleClientes_DataModuleDestroy: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Sender'; Direction: 1; DBXType: 37; TypeName: 'TObject')
  );

  TDataModuleClientes_LeerTodo: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONValue')
  );

  TDataModuleClientes_LeerTodo_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDataModulePuestos_DataModuleCreate: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Sender'; Direction: 1; DBXType: 37; TypeName: 'TObject')
  );

  TDataModulePuestos_DataModuleDestroy: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Sender'; Direction: 1; DBXType: 37; TypeName: 'TObject')
  );

  TDataModulePuestos_LeerTodo: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONValue')
  );

  TDataModulePuestos_LeerTodo_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDataModuleCapturas_LeerPendiente: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONValue')
  );

  TDataModuleCapturas_LeerPendiente_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TDataModuleCapturas_DataModuleCreate: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Sender'; Direction: 1; DBXType: 37; TypeName: 'TObject')
  );

  TDataModuleCapturas_DataModuleDestroy: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Sender'; Direction: 1; DBXType: 37; TypeName: 'TObject')
  );

  TDataModuleCapturas_LeerTodo: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONValue')
  );

  TDataModuleCapturas_LeerTodo_Cache: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

implementation

function TServerMethods1Client.EchoString(Value: string; const ARequestFilter: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FConnection.CreateCommand;
    FEchoStringCommand.RequestType := 'GET';
    FEchoStringCommand.Text := 'TServerMethods1.EchoString';
    FEchoStringCommand.Prepare(TServerMethods1_EchoString);
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.Execute(ARequestFilter);
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.ReverseString(Value: string; const ARequestFilter: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FConnection.CreateCommand;
    FReverseStringCommand.RequestType := 'GET';
    FReverseStringCommand.Text := 'TServerMethods1.ReverseString';
    FReverseStringCommand.Prepare(TServerMethods1_ReverseString);
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.Execute(ARequestFilter);
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.AddInt(A: Integer; B: Integer; const ARequestFilter: string): Integer;
begin
  if FAddIntCommand = nil then
  begin
    FAddIntCommand := FConnection.CreateCommand;
    FAddIntCommand.RequestType := 'GET';
    FAddIntCommand.Text := 'TServerMethods1.AddInt';
    FAddIntCommand.Prepare(TServerMethods1_AddInt);
  end;
  FAddIntCommand.Parameters[0].Value.SetInt32(A);
  FAddIntCommand.Parameters[1].Value.SetInt32(B);
  FAddIntCommand.Execute(ARequestFilter);
  Result := FAddIntCommand.Parameters[2].Value.GetInt32;
end;

function TServerMethods1Client.AddDouble(A: Double; B: Double; const ARequestFilter: string): Double;
begin
  if FAddDoubleCommand = nil then
  begin
    FAddDoubleCommand := FConnection.CreateCommand;
    FAddDoubleCommand.RequestType := 'GET';
    FAddDoubleCommand.Text := 'TServerMethods1.AddDouble';
    FAddDoubleCommand.Prepare(TServerMethods1_AddDouble);
  end;
  FAddDoubleCommand.Parameters[0].Value.SetDouble(A);
  FAddDoubleCommand.Parameters[1].Value.SetDouble(B);
  FAddDoubleCommand.Execute(ARequestFilter);
  Result := FAddDoubleCommand.Parameters[2].Value.GetDouble;
end;

function TServerMethods1Client.IsOk(const ARequestFilter: string): Boolean;
begin
  if FIsOkCommand = nil then
  begin
    FIsOkCommand := FConnection.CreateCommand;
    FIsOkCommand.RequestType := 'GET';
    FIsOkCommand.Text := 'TServerMethods1.IsOk';
    FIsOkCommand.Prepare(TServerMethods1_IsOk);
  end;
  FIsOkCommand.Execute(ARequestFilter);
  Result := FIsOkCommand.Parameters[0].Value.GetBoolean;
end;

function TServerMethods1Client.GetLargeString(Count: Integer; const ARequestFilter: string): string;
begin
  if FGetLargeStringCommand = nil then
  begin
    FGetLargeStringCommand := FConnection.CreateCommand;
    FGetLargeStringCommand.RequestType := 'GET';
    FGetLargeStringCommand.Text := 'TServerMethods1.GetLargeString';
    FGetLargeStringCommand.Prepare(TServerMethods1_GetLargeString);
  end;
  FGetLargeStringCommand.Parameters[0].Value.SetInt32(Count);
  FGetLargeStringCommand.Execute(ARequestFilter);
  Result := FGetLargeStringCommand.Parameters[1].Value.GetWideString;
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TServerMethods1Client.Destroy;
begin
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FAddIntCommand.DisposeOf;
  FAddDoubleCommand.DisposeOf;
  FIsOkCommand.DisposeOf;
  FGetLargeStringCommand.DisposeOf;
  inherited;
end;

procedure TDataModuleEntityClient.DataModuleCreate(Sender: TObject);
begin
  if FDataModuleCreateCommand = nil then
  begin
    FDataModuleCreateCommand := FConnection.CreateCommand;
    FDataModuleCreateCommand.RequestType := 'POST';
    FDataModuleCreateCommand.Text := 'TDataModuleEntity."DataModuleCreate"';
    FDataModuleCreateCommand.Prepare(TDataModuleEntity_DataModuleCreate);
  end;
  if not Assigned(Sender) then
    FDataModuleCreateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDataModuleCreateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDataModuleCreateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDataModuleCreateCommand.Execute;
end;

procedure TDataModuleEntityClient.DataModuleDestroy(Sender: TObject);
begin
  if FDataModuleDestroyCommand = nil then
  begin
    FDataModuleDestroyCommand := FConnection.CreateCommand;
    FDataModuleDestroyCommand.RequestType := 'POST';
    FDataModuleDestroyCommand.Text := 'TDataModuleEntity."DataModuleDestroy"';
    FDataModuleDestroyCommand.Prepare(TDataModuleEntity_DataModuleDestroy);
  end;
  if not Assigned(Sender) then
    FDataModuleDestroyCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDataModuleDestroyCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDataModuleDestroyCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDataModuleDestroyCommand.Execute;
end;

function TDataModuleEntityClient.LeerTodo(const ARequestFilter: string): TJSONValue;
begin
  if FLeerTodoCommand = nil then
  begin
    FLeerTodoCommand := FConnection.CreateCommand;
    FLeerTodoCommand.RequestType := 'GET';
    FLeerTodoCommand.Text := 'TDataModuleEntity.LeerTodo';
    FLeerTodoCommand.Prepare(TDataModuleEntity_LeerTodo);
  end;
  FLeerTodoCommand.Execute(ARequestFilter);
  Result := TJSONValue(FLeerTodoCommand.Parameters[0].Value.GetJSONValue(FInstanceOwner));
end;

function TDataModuleEntityClient.LeerTodo_Cache(const ARequestFilter: string): IDSRestCachedJSONValue;
begin
  if FLeerTodoCommand_Cache = nil then
  begin
    FLeerTodoCommand_Cache := FConnection.CreateCommand;
    FLeerTodoCommand_Cache.RequestType := 'GET';
    FLeerTodoCommand_Cache.Text := 'TDataModuleEntity.LeerTodo';
    FLeerTodoCommand_Cache.Prepare(TDataModuleEntity_LeerTodo_Cache);
  end;
  FLeerTodoCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONValue.Create(FLeerTodoCommand_Cache.Parameters[0].Value.GetString);
end;

constructor TDataModuleEntityClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TDataModuleEntityClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TDataModuleEntityClient.Destroy;
begin
  FDataModuleCreateCommand.DisposeOf;
  FDataModuleDestroyCommand.DisposeOf;
  FLeerTodoCommand.DisposeOf;
  FLeerTodoCommand_Cache.DisposeOf;
  inherited;
end;

procedure TDataModuleClientesClient.DataModuleCreate(Sender: TObject);
begin
  if FDataModuleCreateCommand = nil then
  begin
    FDataModuleCreateCommand := FConnection.CreateCommand;
    FDataModuleCreateCommand.RequestType := 'POST';
    FDataModuleCreateCommand.Text := 'TDataModuleClientes."DataModuleCreate"';
    FDataModuleCreateCommand.Prepare(TDataModuleClientes_DataModuleCreate);
  end;
  if not Assigned(Sender) then
    FDataModuleCreateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDataModuleCreateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDataModuleCreateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDataModuleCreateCommand.Execute;
end;

procedure TDataModuleClientesClient.DataModuleDestroy(Sender: TObject);
begin
  if FDataModuleDestroyCommand = nil then
  begin
    FDataModuleDestroyCommand := FConnection.CreateCommand;
    FDataModuleDestroyCommand.RequestType := 'POST';
    FDataModuleDestroyCommand.Text := 'TDataModuleClientes."DataModuleDestroy"';
    FDataModuleDestroyCommand.Prepare(TDataModuleClientes_DataModuleDestroy);
  end;
  if not Assigned(Sender) then
    FDataModuleDestroyCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDataModuleDestroyCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDataModuleDestroyCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDataModuleDestroyCommand.Execute;
end;

function TDataModuleClientesClient.LeerTodo(const ARequestFilter: string): TJSONValue;
begin
  if FLeerTodoCommand = nil then
  begin
    FLeerTodoCommand := FConnection.CreateCommand;
    FLeerTodoCommand.RequestType := 'GET';
    FLeerTodoCommand.Text := 'TDataModuleClientes.LeerTodo';
    FLeerTodoCommand.Prepare(TDataModuleClientes_LeerTodo);
  end;
  FLeerTodoCommand.Execute(ARequestFilter);
  Result := TJSONValue(FLeerTodoCommand.Parameters[0].Value.GetJSONValue(FInstanceOwner));
end;

function TDataModuleClientesClient.LeerTodo_Cache(const ARequestFilter: string): IDSRestCachedJSONValue;
begin
  if FLeerTodoCommand_Cache = nil then
  begin
    FLeerTodoCommand_Cache := FConnection.CreateCommand;
    FLeerTodoCommand_Cache.RequestType := 'GET';
    FLeerTodoCommand_Cache.Text := 'TDataModuleClientes.LeerTodo';
    FLeerTodoCommand_Cache.Prepare(TDataModuleClientes_LeerTodo_Cache);
  end;
  FLeerTodoCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONValue.Create(FLeerTodoCommand_Cache.Parameters[0].Value.GetString);
end;

constructor TDataModuleClientesClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TDataModuleClientesClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TDataModuleClientesClient.Destroy;
begin
  FDataModuleCreateCommand.DisposeOf;
  FDataModuleDestroyCommand.DisposeOf;
  FLeerTodoCommand.DisposeOf;
  FLeerTodoCommand_Cache.DisposeOf;
  inherited;
end;

procedure TDataModulePuestosClient.DataModuleCreate(Sender: TObject);
begin
  if FDataModuleCreateCommand = nil then
  begin
    FDataModuleCreateCommand := FConnection.CreateCommand;
    FDataModuleCreateCommand.RequestType := 'POST';
    FDataModuleCreateCommand.Text := 'TDataModulePuestos."DataModuleCreate"';
    FDataModuleCreateCommand.Prepare(TDataModulePuestos_DataModuleCreate);
  end;
  if not Assigned(Sender) then
    FDataModuleCreateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDataModuleCreateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDataModuleCreateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDataModuleCreateCommand.Execute;
end;

procedure TDataModulePuestosClient.DataModuleDestroy(Sender: TObject);
begin
  if FDataModuleDestroyCommand = nil then
  begin
    FDataModuleDestroyCommand := FConnection.CreateCommand;
    FDataModuleDestroyCommand.RequestType := 'POST';
    FDataModuleDestroyCommand.Text := 'TDataModulePuestos."DataModuleDestroy"';
    FDataModuleDestroyCommand.Prepare(TDataModulePuestos_DataModuleDestroy);
  end;
  if not Assigned(Sender) then
    FDataModuleDestroyCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDataModuleDestroyCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDataModuleDestroyCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDataModuleDestroyCommand.Execute;
end;

function TDataModulePuestosClient.LeerTodo(const ARequestFilter: string): TJSONValue;
begin
  if FLeerTodoCommand = nil then
  begin
    FLeerTodoCommand := FConnection.CreateCommand;
    FLeerTodoCommand.RequestType := 'GET';
    FLeerTodoCommand.Text := 'TDataModulePuestos.LeerTodo';
    FLeerTodoCommand.Prepare(TDataModulePuestos_LeerTodo);
  end;
  FLeerTodoCommand.Execute(ARequestFilter);
  Result := TJSONValue(FLeerTodoCommand.Parameters[0].Value.GetJSONValue(FInstanceOwner));
end;

function TDataModulePuestosClient.LeerTodo_Cache(const ARequestFilter: string): IDSRestCachedJSONValue;
begin
  if FLeerTodoCommand_Cache = nil then
  begin
    FLeerTodoCommand_Cache := FConnection.CreateCommand;
    FLeerTodoCommand_Cache.RequestType := 'GET';
    FLeerTodoCommand_Cache.Text := 'TDataModulePuestos.LeerTodo';
    FLeerTodoCommand_Cache.Prepare(TDataModulePuestos_LeerTodo_Cache);
  end;
  FLeerTodoCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONValue.Create(FLeerTodoCommand_Cache.Parameters[0].Value.GetString);
end;

constructor TDataModulePuestosClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TDataModulePuestosClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TDataModulePuestosClient.Destroy;
begin
  FDataModuleCreateCommand.DisposeOf;
  FDataModuleDestroyCommand.DisposeOf;
  FLeerTodoCommand.DisposeOf;
  FLeerTodoCommand_Cache.DisposeOf;
  inherited;
end;

function TDataModuleCapturasClient.LeerPendiente(const ARequestFilter: string): TJSONValue;
begin
  if FLeerPendienteCommand = nil then
  begin
    FLeerPendienteCommand := FConnection.CreateCommand;
    FLeerPendienteCommand.RequestType := 'GET';
    FLeerPendienteCommand.Text := 'TDataModuleCapturas.LeerPendiente';
    FLeerPendienteCommand.Prepare(TDataModuleCapturas_LeerPendiente);
  end;
  FLeerPendienteCommand.Execute(ARequestFilter);
  Result := TJSONValue(FLeerPendienteCommand.Parameters[0].Value.GetJSONValue(FInstanceOwner));
end;

function TDataModuleCapturasClient.LeerPendiente_Cache(const ARequestFilter: string): IDSRestCachedJSONValue;
begin
  if FLeerPendienteCommand_Cache = nil then
  begin
    FLeerPendienteCommand_Cache := FConnection.CreateCommand;
    FLeerPendienteCommand_Cache.RequestType := 'GET';
    FLeerPendienteCommand_Cache.Text := 'TDataModuleCapturas.LeerPendiente';
    FLeerPendienteCommand_Cache.Prepare(TDataModuleCapturas_LeerPendiente_Cache);
  end;
  FLeerPendienteCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONValue.Create(FLeerPendienteCommand_Cache.Parameters[0].Value.GetString);
end;

procedure TDataModuleCapturasClient.DataModuleCreate(Sender: TObject);
begin
  if FDataModuleCreateCommand = nil then
  begin
    FDataModuleCreateCommand := FConnection.CreateCommand;
    FDataModuleCreateCommand.RequestType := 'POST';
    FDataModuleCreateCommand.Text := 'TDataModuleCapturas."DataModuleCreate"';
    FDataModuleCreateCommand.Prepare(TDataModuleCapturas_DataModuleCreate);
  end;
  if not Assigned(Sender) then
    FDataModuleCreateCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDataModuleCreateCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDataModuleCreateCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDataModuleCreateCommand.Execute;
end;

procedure TDataModuleCapturasClient.DataModuleDestroy(Sender: TObject);
begin
  if FDataModuleDestroyCommand = nil then
  begin
    FDataModuleDestroyCommand := FConnection.CreateCommand;
    FDataModuleDestroyCommand.RequestType := 'POST';
    FDataModuleDestroyCommand.Text := 'TDataModuleCapturas."DataModuleDestroy"';
    FDataModuleDestroyCommand.Prepare(TDataModuleCapturas_DataModuleDestroy);
  end;
  if not Assigned(Sender) then
    FDataModuleDestroyCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FDataModuleDestroyCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FDataModuleDestroyCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FDataModuleDestroyCommand.Execute;
end;

function TDataModuleCapturasClient.LeerTodo(const ARequestFilter: string): TJSONValue;
begin
  if FLeerTodoCommand = nil then
  begin
    FLeerTodoCommand := FConnection.CreateCommand;
    FLeerTodoCommand.RequestType := 'GET';
    FLeerTodoCommand.Text := 'TDataModuleCapturas.LeerTodo';
    FLeerTodoCommand.Prepare(TDataModuleCapturas_LeerTodo);
  end;
  FLeerTodoCommand.Execute(ARequestFilter);
  Result := TJSONValue(FLeerTodoCommand.Parameters[0].Value.GetJSONValue(FInstanceOwner));
end;

function TDataModuleCapturasClient.LeerTodo_Cache(const ARequestFilter: string): IDSRestCachedJSONValue;
begin
  if FLeerTodoCommand_Cache = nil then
  begin
    FLeerTodoCommand_Cache := FConnection.CreateCommand;
    FLeerTodoCommand_Cache.RequestType := 'GET';
    FLeerTodoCommand_Cache.Text := 'TDataModuleCapturas.LeerTodo';
    FLeerTodoCommand_Cache.Prepare(TDataModuleCapturas_LeerTodo_Cache);
  end;
  FLeerTodoCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONValue.Create(FLeerTodoCommand_Cache.Parameters[0].Value.GetString);
end;

constructor TDataModuleCapturasClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TDataModuleCapturasClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TDataModuleCapturasClient.Destroy;
begin
  FLeerPendienteCommand.DisposeOf;
  FLeerPendienteCommand_Cache.DisposeOf;
  FDataModuleCreateCommand.DisposeOf;
  FDataModuleDestroyCommand.DisposeOf;
  FLeerTodoCommand.DisposeOf;
  FLeerTodoCommand_Cache.DisposeOf;
  inherited;
end;

end.

