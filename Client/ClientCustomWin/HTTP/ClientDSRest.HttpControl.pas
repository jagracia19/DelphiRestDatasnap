unit ClientDSRest.HttpControl;

interface

uses
  {$IF CompilerVersion < 33.0}
  Generics.Collections, DBXJSON;
  {$ELSE}
  System.Generics.Collections, System.JSON;
  {$IFEND}

type
  TClientDSRestHttpControl = class
  public
    class function ParseJsonResult(const JSONString: string;
      out Error: string): TJSONValue;
  end;

implementation

{$IF CompilerVersion < 33.0}
uses
  JSON.Helper;
{$IFEND}

{ TClientDSRestHttpControl }

class function TClientDSRestHttpControl.ParseJsonResult(const JSONString: string;
  out Error: string): TJSONValue;
var jsonRoot  : TJSONValue;
    jsonValue : TJSONValue;
    root      : TJSONObject;
    res       : TJSONArray;
    item      : TJSONValue;
begin
  Result := nil;
  Error := '';
  jsonRoot := TJSONObject.ParseJSONValue(JSONString);
  if jsonRoot <> nil then
    try
      if jsonRoot is TJSONObject then
      begin
        root := TJSONObject(jsonRoot);

        // {"error": "mensaje de error"}
        jsonValue := root.GetValue('error');
        if jsonValue <> nil then
        begin
          Error := jsonValue.Value;
          Result := nil;
        end
        else
        begin
          // {"result": [ ... ]}
          jsonValue := root.GetValue('result');
          if jsonValue is TJSONArray then
          begin
            res := TJSONArray(jsonValue);
            //item := {$IF CompilerVersion < 33.0}res.Get(0){$ELSE}res.Items[0]{$IFEND};
            item := res.Items[0];
            Result := TJSONValue(item.Clone);
          end;
        end;
      end;
    finally
      jsonRoot.Free;
    end;
end;

end.
