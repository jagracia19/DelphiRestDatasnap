unit JSON.Helper;

interface

uses
  DBXJSON;

type
  TJSONObjectHelper = class helper for TJSONObject
  private
    function GetCount: Integer;
    function GetPair(const Index: Integer): TJSONPair;
  public
    function GetValue(const AName: string): TJSONValue;
    property Count: Integer read GetCount;
    property Pairs[const Index: Integer]: TJSONPair read GetPair;
  end;

  TJSONArrayHelper = class helper for TJSONArray
  private
    function GetCount: Integer;
    function GetItem(const Index: Integer): TJSONValue;
  public
    property Count: Integer read GetCount;
    property Items[const Index: Integer]: TJSONValue read GetItem;
  end;

implementation

{ TJSONObjectHelper }

function TJSONObjectHelper.GetCount: Integer;
begin
  Result := Size;
end;

function TJSONObjectHelper.GetPair(const Index: Integer): TJSONPair;
begin
  Result := Get(Index);
end;

function TJSONObjectHelper.GetValue(const AName: string): TJSONValue;
var jsonPair : TJSONPair;
begin
  jsonPair := Get(AName);
  if jsonPair = nil then
    Result := nil
  else Result := jsonPair.JsonValue;
end;

{ TJSONArrayHelper }

function TJSONArrayHelper.GetCount: Integer;
begin
  Result := Size;
end;

function TJSONArrayHelper.GetItem(const Index: Integer): TJSONValue;
begin
  Result := Get(Index);
end;

end.
