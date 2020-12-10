unit Entity.Json;

interface

uses
  Entity.Classes,
  {$IF CompilerVersion < 33.0}
  SysUtils, Variants, Generics.Collections, DBXJSON;
  {$ELSE}
  System.SysUtils, System.Variants, System.Generics.Collections, System.JSON;
  {$IFEND}

type
  TDatabaseEntityJsonClass = class of TDatabaseEntityJson;

  TDatabaseEntityJson = class
  protected
    class function CreateItem: TDatabaseEntity; virtual; abstract;
  public
    class procedure ToJson(JSONObject: TJSONObject; Item: TDatabaseEntity); overload; virtual; abstract;
    class function ToJson(Item: TDatabaseEntity): string; overload;
    class function ParseId(JSONObject: TJSONObject; const IdField: string): Integer;
    class procedure Parse(JSONObject: TJSONObject; Item: TDatabaseEntity); overload; virtual; abstract;
    class procedure Parse(JSONArray: TJSONArray; Lista: TList<TDatabaseEntity>); overload;
  end;

implementation

{$IF CompilerVersion < 33.0}
uses
  Json.Helper;
{$IFEND}

{ TDatabaseEntityJson }

class procedure TDatabaseEntityJson.Parse(JSONArray: TJSONArray;
  Lista: TList<TDatabaseEntity>);
var I         : Integer;
    jsonValue : TJSONValue;
    item      : TDatabaseEntity;
begin
  for I := 0 to JSONArray.Count-1 do
  begin
    jsonValue := JSONArray.Items[I];
    item := CreateItem;
    try
      Parse(TJSONObject(jsonValue), item);
      Lista.Add(item);
    except
      item.Free;
      raise;
    end;
  end;
end;

class function TDatabaseEntityJson.ParseId(JSONObject: TJSONObject;
  const IdField: string): Integer;
var jsonValue: TJSONValue;
begin
  jsonValue := JSONObject.GetValue(IdField);
  if jsonValue is TJSONNull then
    Result := 0
  else Result := TJSONNumber(jsonValue).AsInt;
end;

class function TDatabaseEntityJson.ToJson(Item: TDatabaseEntity): string;
var jsonObject: TJSONObject;
begin
  jsonObject := TJSONObject.Create;
  try
    ToJson(jsonObject, Item);
    Result := jsonObject.ToString;
  finally
    jsonObject.Free;
  end;
end;

end.
