unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth;

type
{$METHODINFO ON}
  TServerMethods1 = class(TComponent)
  private
  public
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function AddInt(A, B: Integer): Integer;
    function AddDouble(A, B: Double): Double;
    function IsOk: Boolean;
    function GetLargeString(Count: Integer): string;
  end;
{$METHODINFO OFF}

implementation


uses System.StrUtils;

function TServerMethods1.AddDouble(A, B: Double): Double;
begin
  Result := A + B;
end;

function TServerMethods1.AddInt(A, B: Integer): Integer;
begin
  Result := A + B;
end;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.GetLargeString(Count: Integer): string;
begin
  Result := '';
  while Length(Result) < Count do
    if (Length(Result) mod 10) = 0 then
      Result := Result + 'x'
    else Result := Result + 'o'
end;

function TServerMethods1.IsOk: Boolean;
begin
  Result := True;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;
end.

