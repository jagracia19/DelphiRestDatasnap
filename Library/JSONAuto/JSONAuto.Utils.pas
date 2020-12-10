unit JSONAuto.Utils;

interface

uses
  {$IF CompilerVersion < 33.0}
  XSBuiltIns,
  DBXJSON, Db,
  SysUtils, DateUtils, Generics.Collections;
  {$ELSE}
  Soap.XSBuiltIns,
  Data.DBXJSON, Data.DB,
  System.SysUtils, System.JSON, System.DateUtils, System.Generics.Collections;
  {$IFEND}

type
  TJSONDateUtils = class
    const DateFormat = 'yyyy-mm-dd';
    const TimeFormat = 'hh:nn:ss.zzz';
    class function DateToStr(ADate: TDate): string; static;
    class function StrToDate(const S: string): TDate; static;
    class function TimeToStr(ATime: TTime): string; static;
    class function StrToTime(const S: string): TTime; static;
    class function DateTimeToStr(ADateTime: TDateTime): string; static;
    class function StrToDateTime(const S: string): TDateTime; static;
  end;

  TJSONRealNumberUtils = class
    const DecimalSeparator = '.';
    const ThousandSeparator = #0;
    class function FloatToStr(AValue: Double): string; static;
    class function StrToFloat(AValue: string): Double; static;
    class function ExtendedToStr(AValue: Extended): string; static;
    class function StrToExtended(AValue: string): Extended; static;
  end;

  TJSONDataSet = class
  public
    class function ReadField(AField: TField): TJSONValue; static;
    class function ReadRow(ADataSet: TDataSet): TJSONObject; static;
    class function ReadAllRows(ADataSet: TDataSet): TJSONArray; static;
//    class procedure ReadRow(AQuery: TpFIBQuery; AJSONObject: TJSONObject); overload; static;
//    class function ReadRow(AQuery: TpFIBQuery): string; overload; static;
//    class procedure ReadRows(AQuery: TpFIBQuery; AJSONArray: TJSONArray); overload; static;
//    class function ReadRows(AQuery: TpFIBQuery): string; overload; static;
  end;

{$IF CompilerVersion >= 33.0}

  TJSONList<T: class, constructor> = class
  public
    class procedure ParseJson(AJsonObject: TJSONObject; AItem: T); overload; virtual;
    class procedure ParseJson(AJsonArray: TJSONArray; ALista: TList<T>); overload; virtual;
    class procedure ParseJson(const AJson: string; ALista: TList<T>); overload;
  end;

{$IFEND}

implementation

{ TJSONDateUtils }

class function TJSONDateUtils.DateTimeToStr(ADateTime: TDateTime): string;
begin
  with TXSDateTime.Create do
  try
    AsDateTime := ADateTime;
    Result := NativeToXS;
  finally
    Free;
  end;
end;

class function TJSONDateUtils.DateToStr(ADate: TDate): string;
begin
//  with TXSDate.Create do
//  try
//    AsDate := ADate;
//    Result := NativeToXS;
//  finally
//    Free;
//  end;
  Result := FormatDateTime(DateFormat, ADate);
end;

class function TJSONDateUtils.StrToDate(const S: string): TDate;
var fs: TFormatSettings;
begin
  fs := TFormatSettings.Create; // init record
  fs.DateSeparator := '-';
  fs.ShortDateFormat := DateFormat;
  {$IF CompilerVersion < 33.0}
  Result := SysUtils.StrToDate(S, fs);
  {$ELSE}
  Result := System.SysUtils.StrToDate(S, fs);
  {$IFEND}
end;

class function TJSONDateUtils.StrToDateTime(const S: string): TDateTime;
begin
  with TXSDateTime.Create do
  try
    XSToNative(S);
    Result := AsDateTime;
  finally
    Free;
  end;
end;

class function TJSONDateUtils.StrToTime(const S: string): TTime;
var fs: TFormatSettings;
begin
  fs := TFormatSettings.Create; // init record
  fs.TimeSeparator := ':';
  fs.ShortTimeFormat := TimeFormat;
  fs.LongTimeFormat := TimeFormat;
  fs.DecimalSeparator := '.';
  {$IF CompilerVersion < 33.0}
  Result := SysUtils.StrToTime(S, fs);
  {$ELSE}
  Result := System.SysUtils.StrToTime(S, fs);
  {$IFEND}
end;

class function TJSONDateUtils.TimeToStr(ATime: TTime): string;
begin
//  with TXSTime.Create do
//  begin
//    AsTime := ATime;
//    Result := NativeToXS;
//  end
  Result := FormatDateTime(TimeFormat, ATime)
end;

{ TJSONRealNumberUtils }

class function TJSONRealNumberUtils.ExtendedToStr(AValue: Extended): string;
var fs: TFormatSettings;
begin
  fs := TFormatSettings.Create; // init record
  fs.DecimalSeparator := TJSONRealNumberUtils.DecimalSeparator;
  fs.ThousandSeparator := TJSONRealNumberUtils.ThousandSeparator;
  {$IF CompilerVersion < 33.0}
  Result := SysUtils.FloatToStr(AValue, fs);
  {$ELSE}
  Result := System.SysUtils.FloatToStr(AValue, fs);
  {$IFEND}
end;

class function TJSONRealNumberUtils.FloatToStr(AValue: Double): string;
var fs: TFormatSettings;
begin
  fs := TFormatSettings.Create; // init record
  fs.DecimalSeparator := TJSONRealNumberUtils.DecimalSeparator;
  fs.ThousandSeparator := TJSONRealNumberUtils.ThousandSeparator;
  {$IF CompilerVersion < 33.0}
  Result := SysUtils.FloatToStr(AValue, fs);
  {$ELSE}
  Result := System.SysUtils.FloatToStr(AValue, fs);
  {$IFEND}
end;

class function TJSONRealNumberUtils.StrToExtended(AValue: string): Extended;
var fs: TFormatSettings;
begin
  fs := TFormatSettings.Create; // init record
  fs.DecimalSeparator := TJSONRealNumberUtils.DecimalSeparator;
  fs.ThousandSeparator := TJSONRealNumberUtils.ThousandSeparator;
  {$IF CompilerVersion < 33.0}
  Result := SysUtils.StrToFloat(AValue, fs);
  {$ELSE}
  Result := System.SysUtils.StrToFloat(AValue, fs);
  {$IFEND}
end;

class  function TJSONRealNumberUtils.StrToFloat(AValue: string): Double;
var fs: TFormatSettings;
begin
  fs := TFormatSettings.Create; // init record
  fs.DecimalSeparator := TJSONRealNumberUtils.DecimalSeparator;
  fs.ThousandSeparator := TJSONRealNumberUtils.ThousandSeparator;
  {$IF CompilerVersion < 33.0}
  Result := SysUtils.StrToFloat(AValue, fs);
  {$ELSE}
  Result := System.SysUtils.StrToFloat(AValue, fs);
  {$IFEND}
end;

{ TJSONUtil }

//class procedure TJSONUtil.ReadRow(AQuery: TpFIBQuery; AJSONObject: TJSONObject);
//var I     : Integer;
//    field : TFIBXSQLVAR;
//    val   : TJSONValue;
//    st    : string;
//begin
//  for I := 0 to AQuery.FieldCount-1 do
//  begin
//    field := AQuery.Fields[I];
//    if field.IsNull then
//      val := TJSONNull.Create
//    else
//    begin
//      if field.IsNumericType(field.SQLType) then
//        val := TJSONNumber.Create(field.AsInt64)
//      else if field.IsRealType(field.SQLType) then
//        val := TJSONNumber.Create(field.AsFloat)
//      else if field.IsDateTimeType(field.SQLType) then
//      begin
//        if field.SQLType = SQL_TYPE_DATE then
//          val := TJSONString.Create(TJSONDateUtils.DateToStr(Field.AsDate))
//        else if field.SQLType = SQL_TYPE_TIME then
//          val := TJSONString.Create(TJSONDateUtils.TimeToStr(Field.AsTime))
//        else
//          val := TJSONString.Create(TJSONDateUtils.DateTimeToStr(Field.AsDateTime));
//      end
//      else
//        val := TJSONString.Create(field.AsString);
//    end;
//    AJSONObject.AddPair(field.Name, val);
//  end;
//end;
//
//class function TJSONUtil.ReadRow(AQuery: TpFIBQuery): string;
//var jsonObject: TJSONObject;
//begin
//  jsonObject := TJSONObject.Create;
//  try
//    TJSONUtil.ReadRow(AQuery, jsonObject);
//    Result := jsonObject.ToString;
//  finally
//    jsonObject.Free;
//  end;
//end;
//
//class function TJSONUtil.ReadRows(AQuery: TpFIBQuery): string;
//var jsonArray: TJSONArray;
//begin
//  jsonArray := TJSONArray.Create;
//  try
//    TJSONUtil.ReadRows(AQuery, jsonArray);
//    Result := jsonArray.ToString;
//  finally
//    jsonArray.Free;
//  end;
//end;
//
//class procedure TJSONUtil.ReadRows(AQuery: TpFIBQuery; AJSONArray: TJSONArray);
//var jsonObject: TJSONObject;
//begin
//  while not AQuery.Eof do
//  begin
//    jsonObject := TJSONObject.Create;
//    try
//      ReadRow(AQuery, jsonObject);
//      AJSONArray.Add(jsonObject);
//    except
//      jsonObject.Free;
//      raise;
//    end;
//    AQuery.Next;
//  end;
//end;

{ TJSONDataSet }

class function TJSONDataSet.ReadAllRows(ADataSet: TDataSet): TJSONArray;
begin
  Result := TJSONArray.Create;
  try
    ADataSet.First;
    while not ADataSet.Eof do
    begin
      Result.Add(ReadRow(ADataSet));
      ADataSet.Next;
    end;
  except
    Result.Free;
    //Result := nil;
    raise;
  end;
end;

class function TJSONDataSet.ReadField(AField: TField): TJSONValue;
begin
  if AField.IsNull then
    Result := TJSONNull.Create
  else
    case AField.DataType of
      ftSmallint, ftInteger, ftWord, ftLargeint, ftLongWord, ftShortint,
      ftByte, ftAutoInc:
        Result := TJSONNumber.Create(AField.AsLargeInt);

      ftExtended, ftSingle, ftFloat:
        Result := TJSONString.Create(TJSONRealNumberUtils.FloatToStr(AField.AsFloat));

      ftBCD, ftCurrency, ftFMTBcd:
        Result := TJSONNumber.Create(AField.AsFloat);

      ftDateTime, ftTimeStamp:
        Result := TJSONString.Create(TJSONDateUtils.DateTimeToStr(AField.AsDateTime));

      ftTime:
        Result := TJSONString.Create(TJSONDateUtils.TimeToStr(AField.AsDateTime));

      ftDate:
        Result := TJSONString.Create(TJSONDateUtils.DateToStr(AField.AsDateTime));

      ftBoolean:
        if AField.AsBoolean then
          Result := TJSONTrue.Create
        else
          Result := TJSONFalse.Create;
    else
      Result := TJSONString.Create(AField.AsString);
    end;
end;

class function TJSONDataSet.ReadRow(ADataSet: TDataSet): TJSONObject;
var field: TField;
    data : TJSONValue;
begin
  Result := TJSONObject.Create;
  try
    for field in ADataSet.Fields do
    begin
      data := ReadField(field);
      Result.AddPair(field.FieldName, data);
    end;
  except
    Result.Free;
    //Result := nil;
    raise;
  end;
end;

{$IF CompilerVersion >= 33.0}

{ TJSONList<T> }

class procedure TJSONList<T>.ParseJson(AJsonArray: TJSONArray;
  ALista: TList<T>);
var jsonValue: TJSONValue;
    item     : T;
begin
  for jsonValue in AJsonArray do
    if jsonValue is TJSONObject then
    begin
      item := T.Create;
      ALista.Add(item);
      ParseJson(TJSONObject(jsonValue), item);
    end;
end;

class procedure TJSONList<T>.ParseJson(const AJson: string; ALista: TList<T>);
var jsonValue: TJSONValue;
begin
  jsonValue := nil;
  try
    jsonValue := TJSONObject.ParseJSONValue(AJson);
    if jsonValue is TJSONArray then
      ParseJson(TJSONArray(jsonValue), ALista);
  finally
    if jsonValue <> nil then
      jsonValue.Free;
  end;
end;

class procedure TJSONList<T>.ParseJson(AJsonObject: TJSONObject; AItem: T);
begin
  // implementar en descendiente
end;

{$IFEND}

end.
