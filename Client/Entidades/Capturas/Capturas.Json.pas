unit Capturas.Json;

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
  TCapturaJson = class(TDatabaseEntityJson)
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
  JSONAuto.Utils,
  Capturas.Classes;

{ TCapturaJson }

class function TCapturaJson.CreateItem: TDatabaseEntity;
begin
  Result := TCaptura.Create;
end;

class procedure TCapturaJson.Parse(JSONObject: TJSONObject;
  Item: TDatabaseEntity);
var I       : Integer;
    jsonPair: TJSONPair;
    stField : string;
    captura : TCaptura;
begin
  //inherited;
  captura := TCaptura(Item);
  for I := 0 to JSONObject.Count-1 do
  begin
    jsonPair := JSONObject.Pairs[I];
    stField := jsonPair.JsonString.Value;
    if SameText(stField, 'ID_CAPTURA') then
      captura.IdCaptura := TJSONNumber(jsonPair.JsonValue).AsInt
    else if SameText(stField, 'ID_PUESTO') then
    begin
      if jsonPair.JsonValue is TJSONNull then
        captura.IdPuesto := 0
      else captura.IdPuesto := TJSONNumber(jsonPair.JsonValue).AsInt
    end
    else if SameText(stField, 'ID_CLIENTE') then
    begin
      if jsonPair.JsonValue is TJSONNull then
        captura.IdCliente := 0
      else captura.IdCliente := TJSONNumber(jsonPair.JsonValue).AsInt
    end
    else if SameText(stField, 'FECHA_HORA') then
    begin
      if jsonPair.JsonValue is TJSONNull then
        captura.FechaHora := 0
      else captura.FechaHora := TJSONDateUtils.StrToDateTime(TJSONString(jsonPair.JsonValue).Value)
    end
    else if SameText(stField, 'CAPTURA') then
    begin
      if jsonPair.JsonValue is TJSONNull then
        captura.Captura := ''
      else captura.Captura := TJSONString(jsonPair.JsonValue).Value
    end
    else if SameText(stField, 'PROCESADA') then
    begin
      {$IF CompilerVersion < 33.0}
      captura.Procesada := jsonPair.JsonValue is TJSONTrue;
      {$ELSE}
      captura.Procesada := TJSONBool(jsonPair.JsonValue).AsBoolean;
      {$IFEND}
    end
  end;
end;

class procedure TCapturaJson.ToJson(JSONObject: TJSONObject;
  Item: TDatabaseEntity);
var jsonValue : TJSONValue;
    captura   : TCaptura;
begin
  //inherited;
  captura := TCaptura(Item);

  if captura.IdCaptura = 0 then
    jsonValue := TJSONNull.Create
  else jsonValue := TJSONNumber.Create(captura.IdCaptura);
  JSONObject.AddPair('ID_CAPTURA', jsonValue);

  if captura.IdPuesto = 0 then
    jsonValue := TJSONNull.Create
  else jsonValue := TJSONNumber.Create(captura.IdPuesto);
  JSONObject.AddPair('ID_PUESTO', jsonValue);

  if captura.IdCliente = 0 then
    jsonValue := TJSONNull.Create
  else jsonValue := TJSONNumber.Create(captura.IdCliente);
  JSONObject.AddPair('ID_CLIENTE', jsonValue);

  if captura.FechaHora = 0 then
    jsonValue := TJSONNull.Create
  else jsonValue := TJSONString.Create(TJSONDateUtils.DateToStr(captura.FechaHora));
  JSONObject.AddPair('FECHA_HORA', jsonValue);

  {$IF CompilerVersion < 33.0}
  if captura.Procesada then
    jsonValue := TJSONTrue.Create
  else jsonValue := TJSONFalse.Create;
  {$ELSE}
  jsonValue := TJSONBool.Create(captura.Procesada);
  {$IFEND}
  JSONObject.AddPair('PROCESADA', jsonValue);
end;

end.
