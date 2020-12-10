unit SQLUtils.Classes;

interface

uses
  System.SysUtils, System.StrUtils, System.Classes, System.Generics.Collections;

type
  TSQLSelect = class;

  ///  --- Settings ---

  TSQLSettings = class
  public
    const SpaceSeparator: char = ' ';
    const EntityFieldSeparator: char = '.';
    const ParameterPrefix: char = ':';
    const FieldSeparator: char = ',';
    class function FormatSettings: TFormatSettings;
  end;

  ///  --- Field ---

//  TSQLFieldList = class(TStringList)
//  private
//    function GetAsString: string;
//    procedure SetAsString(const Value: string);
//  public
//    property AsString: string read GetAsString write SetAsString;
//  end;

  ///  --- Entity ---

  TSQLEntity = class(TComponent)
  private
    FTableName: string;
    FPKName: string;
    procedure SetTableName(const Value: string);
    procedure SetPKName(const Value: string);
  public
    property TableName: string read FTableName write SetTableName;
    property PKName: string read FPKName write SetPKName;
  end;

  ///  --- Query ---

  TSQLQuery = class(TComponent)
  private
    FEntity: TSQLEntity;
    procedure SetEntity(const Value: TSQLEntity);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetWhereStrings(AStrings: TStrings; const AOperator: string): string;
    function GetWherePK: string;
    function GetPKAsString: string;
  public
    constructor Create(AOwner: TComponent; AEntity: TSQLEntity); reintroduce; overload; virtual;
    property Entity: TSQLEntity read FEntity write SetEntity;
    function GetQuery: string; virtual;
  end;

  ///  --- Select ---

  TSQLSelect = class(TSQLQuery)
  protected
    function GetOrderByPK: string;
  public
    function GetQuery: string; override;
    function GetSelect: string;
    function GetSelectAll: string;
    function GetSelectPK: string;
    function GetSelectWhere(const AWhere: string): string;
    class function Select(AEntity: TSQLEntity; const AWhere: string = '';
      const AOrderBy: string = ''): string;
  end;

  ///  --- Delete ---

  TSQLDelete = class(TSQLQuery)
  public
    function GetQuery: string; override;
    function GetDelete: string;
    function GetDeleteAll: string;
    function GetDeletePK: string;
    function GetDeleteWhere(const AWhere: string): string;
  end;

  ///  --- Insert ---

  TSQLInsert = class(TSQLQuery)
  private
    FParams: TStrings;
    function GetParams: TStrings;
  public
    destructor Destroy; override;
    function GetQuery: string; override;
    function GetInsert: string;
    property Params: TStrings read GetParams;
  end;

  ///  --- Update ---

  TSQLUpdate = class(TSQLQuery)
  private
    FParams: TStrings;
    FWhereFields: TStrings;
    function GetParams: TStrings;
    function GetWhereFields: TStrings;
  public
    destructor Destroy; override;
    function GetQuery: string; override;
    function GetUpdate: string;
    property Params: TStrings read GetParams;
    property WhereFields: TStrings read GetWhereFields;
  end;

implementation

function ConcatNotEmpty(const S: string; const Prefix: string = ''): string;
begin
  if not S.IsEmpty then
    Result := Prefix + S
  else Result := S;
end;

{ TStringsHelper }

type
  TStringsHelper = class helper for TStrings
  public
    function GetAsString(const Separator: string): string;
    procedure SetAsString(const Value, Separator: string);
  end;

function TStringsHelper.GetAsString(const Separator: string): string;
var st: string;
begin
  Result := '';
  for st in Self do
  begin
    if not Result.IsEmpty then
      Result := Result + Separator;
    Result := Result + st;
  end;
end;

procedure TStringsHelper.SetAsString(const Value, Separator: string);
var st: string;
    lst: TArray<string>;
begin
  lst := st.Split(Separator);
  for st in lst do
    Add(st);
end;

{ TSQLSettings }

class function TSQLSettings.FormatSettings: TFormatSettings;
begin
  Result.DecimalSeparator := '.';
end;

{ TSQLFieldList }

//function TSQLFieldList.GetAsString: string;
//var lst   : TStrings;
//    field : string;
//begin
//  lst := TStringList.Create;
//  try
//    for field in Self do
//      lst.Add(field);
//    lst.Delimiter := TSQLSettings.FieldSeparator;
//    Result := lst.DelimitedText;
//  finally
//    lst.Free;
//  end;
//end;
//
//procedure TSQLFieldList.SetAsString(const Value: string);
//var lst   : TStrings;
//    field : string;
//begin
//  Clear;
//  lst := TStringList.Create;
//  try
//    lst.Delimiter := TSQLSettings.FieldSeparator;
//    lst.DelimitedText := Value;
//    for field in lst do
//      Add(field);
//  finally
//    lst.Free;
//  end;
//end;

{ TSQLEntity }

procedure TSQLEntity.SetPKName(const Value: string);
begin
  FPKName := Value;
end;

procedure TSQLEntity.SetTableName(const Value: string);
begin
  FTableName := Value;
end;

{ TSQLQuery }

constructor TSQLQuery.Create(AOwner: TComponent; AEntity: TSQLEntity);
begin
  inherited Create(AOwner);
  Entity := AEntity;
end;

function TSQLQuery.GetPKAsString: string;
begin
  if (Entity <> nil) and not Entity.PKName.IsEmpty then
    Result := Entity.PKName
  else Result := '';
end;

function TSQLQuery.GetQuery: string;
begin
  // implement in descendant
  Result := '';
end;

function TSQLQuery.GetWherePK: string;
begin
  if (Entity <> nil) and not Entity.PKName.IsEmpty then
    Result := Entity.PKName + '=' + TSQLSettings.ParameterPrefix + Entity.PKName
  else Result := '';
end;

function TSQLQuery.GetWhereStrings(AStrings: TStrings; const AOperator: string): string;
var st: string;
begin
  Result := '';
  for st in AStrings do
  begin
    if not Result.IsEmpty then Result := Result + ' ' + AOperator + ' ';
    Result := Result + Format('(%s=%s)', [st, TSQLSettings.ParameterPrefix + st]);
  end;
end;

procedure TSQLQuery.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FEntity then
      FEntity := nil;
  end;
end;

procedure TSQLQuery.SetEntity(const Value: TSQLEntity);
begin
  if FEntity <> nil then
    FEntity.RemoveFreeNotification(Self);
  FEntity := Value;
  if FEntity <> nil then
    FEntity.FreeNotification(Self);
end;

{ TSQLSelect }

function TSQLSelect.GetOrderByPK: string;
begin
  Result := ConcatNotEmpty(GetPKAsString, ' order by ');
end;

function TSQLSelect.GetQuery: string;
begin
  Result := GetSelect;
end;

function TSQLSelect.GetSelect: string;
begin
  if Entity = nil then
    raise Exception.Create('Entity is not assigned');
  Result := 'select * from ' + Entity.TableName;
end;

function TSQLSelect.GetSelectAll: string;
begin
  Result := GetSelect;
  Result := Result + GetOrderByPK;
end;

function TSQLSelect.GetSelectPK: string;
begin
  Result := GetSelect;
  Result := Result + ConcatNotEmpty(GetWherePK, ' where ');
end;

function TSQLSelect.GetSelectWhere(const AWhere: string): string;
begin
  Result := GetSelect;
  Result := Result + ConcatNotEmpty(AWhere, ' where ');
  Result := Result + GetOrderByPK;
end;

class function TSQLSelect.Select(AEntity: TSQLEntity; const AWhere,
  AOrderBy: string): string;
begin
  with TSQLSelect.Create(nil, AEntity) do
  try
    Result := GetSelect;
    Result := Result + ConcatNotEmpty(AWhere, ' where ');
    if AOrderBy <> '' then
      Result := Result + ConcatNotEmpty(AOrderBy, ' order by ')
    else Result := Result + GetOrderByPK;
  finally
    Free;
  end;
end;

{ TSQLDelete }

function TSQLDelete.GetDelete: string;
begin
  if Entity = nil then
    raise Exception.Create('Entity is not assigned');
  Result := 'delete from ' + Entity.TableName;
end;

function TSQLDelete.GetDeleteAll: string;
begin
  Result := GetDelete;
end;

function TSQLDelete.GetDeletePK: string;
begin
  Result := GetDelete;
  Result := Result + ConcatNotEmpty(GetWherePK, ' where ');
end;

function TSQLDelete.GetDeleteWhere(const AWhere: string): string;
begin
  Result := GetDelete;
  Result := Result + ConcatNotEmpty(AWhere, ' where ');
end;

function TSQLDelete.GetQuery: string;
begin
  Result := GetDelete;
end;

{ TSQLInsert }

destructor TSQLInsert.Destroy;
begin
  FreeAndNil(FParams);
  inherited;
end;

function TSQLInsert.GetInsert: string;
var lst : TStrings;
    st  : string;
    columns: string;
    values : string;
begin
  if Entity = nil then
    raise Exception.Create('Entity is not assigned');
  columns := Params.GetAsString(',');
  lst := TStringList.Create;
  try
    for st in Params do
      lst.Add(TSQLSettings.ParameterPrefix + st);
    values := lst.GetAsString(',');
  finally
    lst.Free;
  end;
  Result := Format('insert into %s (%s) values (%s)',
        [Entity.TableName, columns, values]);
  Result := Result + ConcatNotEmpty(GetPKAsString, ' returning ');
end;

function TSQLInsert.GetParams: TStrings;
begin
  if FParams = nil then
    FParams := TStringList.Create;
  Result := FParams;
end;

function TSQLInsert.GetQuery: string;
begin
  Result := GetInsert;
end;

{ TSQLUpdate }

destructor TSQLUpdate.Destroy;
begin
  FreeAndNil(FParams);
  FreeAndNil(FWhereFields);
  inherited;
end;

function TSQLUpdate.GetParams: TStrings;
begin
  if FParams = nil then
    FParams := TStringList.Create;
  Result := FParams;
end;

function TSQLUpdate.GetQuery: string;
begin
  Result := GetUpdate;
end;

function TSQLUpdate.GetUpdate: string;
var st    : string;
    sets  : string;
    where : string;
begin
  if Entity = nil then
    raise Exception.Create('Entity is not assigned');

  sets := '';
  for st in Params do
  begin
    if not sets.IsEmpty then sets := sets + ', ';
    sets := sets + st + '=' + TSQLSettings.ParameterPrefix + st;
  end;

  where := GetWhereStrings(WhereFields, 'and');

  Result := Format('update %s set %s',
        [Entity.TableName, sets]);
  Result := Result + ConcatNotEmpty(where, ' where ');
end;

function TSQLUpdate.GetWhereFields: TStrings;
begin
  if FWhereFields = nil then
    FWhereFields := TStringList.Create;
  Result := FWhereFields;
end;

end.
