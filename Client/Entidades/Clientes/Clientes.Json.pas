unit Clientes.Json;

interface

uses
  Entity.Classes,
  Entity.Json,
  {$IF CompilerVersion < 33.0}
  SysUtils, Variants, Generics.Collections, DBXJSON;
  {$ELSE}
  System.SysUtils, System.Variants, System.Generics.Collections, System.JSON;
  {$IFEND}

type
  TClienteJson = class(TDatabaseEntityJson)
  protected
    class function CreateItem: TDatabaseEntity; override;
  public
    class procedure ToJson(JSONObject: TJSONObject; Item: TDatabaseEntity); override;
    class procedure Parse(JSONObject: TJSONObject; Item: TDatabaseEntity); override;
  end;

implementation

uses
  {$IF CompilerVersion < 33.0}
  JSON.Helper,
  {$IFEND}
  Clientes.Classes;

{ TClienteJson }

class function TClienteJson.CreateItem: TDatabaseEntity;
begin
  Result := TCliente.Create;
end;

class procedure TClienteJson.Parse(JSONObject: TJSONObject;
  Item: TDatabaseEntity);
var I       : Integer;
    jsonPair: TJSONPair;
    stField : string;
    cliente : TCliente;
begin
  //inherited;
  cliente := TCliente(Item);
  for I := 0 to JSONObject.Count-1 do
  begin
    jsonPair := JSONObject.Pairs[I];
    stField := jsonPair.JsonString.Value;
    if SameText(stField, 'ID_CLIENTE') then
      cliente.IdCliente := TJSONNumber(jsonPair.JsonValue).AsInt
    else if SameText(stField, 'NOMBRE') then
    begin
      if jsonPair.JsonValue is TJSONNull then
        cliente.Nombre := ''
      else cliente.Nombre := TJSONString(jsonPair.JsonValue).Value
    end
    else if SameText(stField, 'API_KEY') then
    begin
      if jsonPair.JsonValue is TJSONNull then
        cliente.ApiKey := ''
      else cliente.ApiKey := TJSONString(jsonPair.JsonValue).Value
    end
  end;
end;

class procedure TClienteJson.ToJson(JSONObject: TJSONObject;
  Item: TDatabaseEntity);
var jsonValue : TJSONValue;
    cliente   : TCliente;
begin
  //inherited;
  cliente := TCliente(Item);
  if cliente.IdCliente = 0 then
    jsonValue := TJSONNull.Create
  else jsonValue := TJSONNumber.Create(cliente.IdCliente);
  JSONObject.AddPair('ID_CLIENTE', jsonValue);

  JSONObject.AddPair('NOMBRE', TJSONString.Create(cliente.Nombre));
  JSONObject.AddPair('API_KEY', TJSONString.Create(cliente.ApiKey));
end;

end.
