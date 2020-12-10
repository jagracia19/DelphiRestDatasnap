unit Puestos.Json;

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
  TPuestoJson = class(TDatabaseEntityJson)
  protected
    class function CreateItem: TDatabaseEntity; override;
  public
    class procedure ToJson(JSONObject: TJSONObject; Item: TDatabaseEntity); override;
    class procedure Parse(JSONObject: TJSONObject; Item: TDatabaseEntity); override;
  end;

implementation

uses
  Puestos.Classes;

{ TPuestoJson }

class function TPuestoJson.CreateItem: TDatabaseEntity;
begin
  Result := TPuesto.Create;
end;

class procedure TPuestoJson.Parse(JSONObject: TJSONObject;
  Item: TDatabaseEntity);
var I       : Integer;
    jsonPair: TJSONPair;
    stField : string;
    Puesto : TPuesto;
begin
  //inherited;
  Puesto := TPuesto(Item);
  for I := 0 to JSONObject.Count-1 do
  begin
    jsonPair := JSONObject.Pairs[I];
    stField := jsonPair.JsonString.Value;
    if SameText(stField, 'ID_PUESTO') then
      Puesto.IdPuesto := TJSONNumber(jsonPair.JsonValue).AsInt
    else if SameText(stField, 'ID_CLIENTE') then
    begin
      if jsonPair.JsonValue is TJSONNull then
        Puesto.IdCliente := 0
      else Puesto.IdCliente := TJSONNumber(jsonPair.JsonValue).AsInt
    end
    else if SameText(stField, 'NOMBRE') then
    begin
      if jsonPair.JsonValue is TJSONNull then
        Puesto.Nombre := ''
      else Puesto.Nombre := TJSONString(jsonPair.JsonValue).Value
    end
    else if SameText(stField, 'API_KEY') then
    begin
      if jsonPair.JsonValue is TJSONNull then
        Puesto.ApiKey := ''
      else Puesto.ApiKey := TJSONString(jsonPair.JsonValue).Value
    end
    else if SameText(stField, 'IP') then
    begin
      if jsonPair.JsonValue is TJSONNull then
        Puesto.Ip := ''
      else Puesto.Ip := TJSONString(jsonPair.JsonValue).Value
    end
    else if SameText(stField, 'PUERTO') then
    begin
      if jsonPair.JsonValue is TJSONNull then
        Puesto.Puerto := 0
      else Puesto.Puerto := TJSONNumber(jsonPair.JsonValue).AsInt
    end
  end;
end;

class procedure TPuestoJson.ToJson(JSONObject: TJSONObject;
  Item: TDatabaseEntity);
var jsonValue : TJSONValue;
    Puesto   : TPuesto;
begin
  //inherited;
  Puesto := TPuesto(Item);

  if Puesto.IdPuesto = 0 then
    jsonValue := TJSONNull.Create
  else jsonValue := TJSONNumber.Create(Puesto.IdPuesto);
  JSONObject.AddPair('ID_PUESTO', jsonValue);

  if Puesto.IdCliente = 0 then
    jsonValue := TJSONNull.Create
  else jsonValue := TJSONNumber.Create(Puesto.IdCliente);
  JSONObject.AddPair('ID_CLIENTE', jsonValue);

  JSONObject.AddPair('NOMBRE', TJSONString.Create(Puesto.Nombre));
  JSONObject.AddPair('API_KEY', TJSONString.Create(Puesto.ApiKey));

  JSONObject.AddPair('IP', TJSONString.Create(Puesto.Ip));
  JSONObject.AddPair('PUERTO', TJSONNumber.Create(Puesto.Puerto));
end;

end.
