unit ClientDSRest.HttpControl;

interface

uses
  IdGlobal, IdCoderMIME, IdHTTP,
  {$IF CompilerVersion < 33.0}
  Classes, StrUtils, Generics.Collections, DBXJSON;
  {$ELSE}
  System.Classes, System.StrUtils, System.Generics.Collections, System.JSON;
  {$IFEND}

type
  TClientDSRestHttpControl = class
  private
    FURLApi: string;    // URL servicio REST
    FUsuario: string;   // Usuario autentificacion HTTP
    FClave: string;     // Clave autentificacion HTTP
    FSesion: string;    // Session HTTP
    procedure InyectarAutentificacion(Http: TIdHttp);
    procedure ExtraerSesion(Http: TIdHttp);
  protected
    function CodificarClave(const AClave: string): string; virtual;
    function GetEntity(Http: TIdHttp; const APath: string): string;
  public
    class function ParseJsonResult(const JSONString: string;
      out Error: string): TJSONValue;
    function LeerEntidad(const APath, AFiltro, AInclusion: string): TJSONValue;
    property URLApi: string read FURLApi write FURLApi;
    property Usuario: string read FUsuario write FUsuario;
    property Clave: string read FClave write FClave;
    property Sesion: string read FSesion;
  end;

implementation

{$IF CompilerVersion < 33.0}
uses
  JSON.Helper;
{$IFEND}

const
  DSSession = 'dssession';

{ TClientDSRestHttpControl }

function TClientDSRestHttpControl.CodificarClave(const AClave: string): string;
begin
  Result := AClave;
end;

procedure TClientDSRestHttpControl.ExtraerSesion(Http: TIdHttp);
var pragma  : string;
    session : string;
    ix      : Integer;
begin
  //pragma := http.Response.RawHeaders.Values['Pragma'];
  pragma := http.Response.Pragma;
  Assert(StartsText(DSSession + '=', pragma));

  session := pragma;
  Delete(session, 1, Length(DSSession + '='));
  ix := Pos(',', session);
  if ix <> -1 then
    session := Copy(session, 1, ix-1);
  FSesion := session;
end;

function TClientDSRestHttpControl.GetEntity(Http: TIdHttp;
  const APath: string): string;
var resStream: TStringStream;
begin
  resStream := TStringStream.Create;
  try
    http.Get(URLApi + APath, resStream);
    resStream.Position := 0;
    Result := resStream.ReadString(resStream.Size);
  finally
    resStream.Free;
  end;
end;

procedure TClientDSRestHttpControl.InyectarAutentificacion(Http: TIdHttp);
var authen: string;
    hash  : string;
begin
  if Sesion <> '' then
    //Http.Request.RawHeaders.Add('Pragma:' + pragma);
    Http.Request.Pragma := DSSession + '=' + Sesion
  else if Usuario <> '' then
  begin
    // hash de la clave
    hash := CodificarClave(clave);
    // Basic <Base64 encoded username and password>
    authen := Usuario + ':' + hash;
    authen := TIdEncoderMIME.EncodeString(authen,
        {$IF CompilerVersion < 33.0}TIdTextEncoding.UTF8{$ELSE}IndyTextEncoding_UTF8{$IFEND});
    //http.Request.CustomHeaders.FoldLines := False;
    http.Request.CustomHeaders.Add('Authorization:Basic ' + authen);
  end;
end;

function TClientDSRestHttpControl.LeerEntidad(const APath, AFiltro,
  AInclusion: string): TJSONValue;
var http    : TIdHttp;
    stResult: string;
    stError : string;
begin
  http := TIdHttp.Create(nil);
  try
    InyectarAutentificacion(http);
    if AFiltro <> '' then
      http.Request.CustomHeaders.Add('Filter: ' + AFiltro);
    if AInclusion <> '' then
      http.Request.CustomHeaders.Add('Include: ' + AInclusion);
    stResult := GetEntity(http, APath);
    ExtraerSesion(http);
    Result := ParseJsonResult(stResult, stError);
  finally
    http.Free;
  end;
end;

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
