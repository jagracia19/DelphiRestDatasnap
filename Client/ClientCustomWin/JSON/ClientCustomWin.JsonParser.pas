unit ClientCustomWin.JsonParser;

interface

uses
  {$IF CompilerVersion < 33.0}
  SysUtils, DBXJSON;
  {$ELSE}
  System.SysUtils, System.JSON, System.Generics.Collections;
  {$IFEND}

// Parser JSON  ej: {"result":["aloH"]}
function ParseResultSample(const AJSONResult: string): string;

implementation

{$IF CompilerVersion < 33.0}
uses
  JSON.Helper;
{$IFEND}

function ParseResultSample(const AJSONResult: string): string;
var jsonValue : TJSONValue;
    jsonObject: TJSONObject;
    jsonPair  : TJSONPair;
    jsonArray : TJSONArray;
begin
  jsonValue := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(AJSONResult), 0);
  try
    jsonObject := jsonValue as TJSONObject;
    jsonPair := jsonObject.Pairs[0];
    jsonArray := jsonPair.JsonValue as TJSONArray;
    Result := jsonArray.Items[0].Value;
  finally
    jsonValue.Free;
  end;
end;

end.
