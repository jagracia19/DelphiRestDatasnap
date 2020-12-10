unit Swip.HttpControl;

interface

uses
  Capturas.Classes,
  ClientDSRest.HttpControl,
  {$IF CompilerVersion < 33.0}
  //Classes, StrUtils,
  Generics.Collections, DBXJSON;
  {$ELSE}
  //System.Classes, System.StrUtils,
  System.Generics.Collections, System.JSON;
  {$IFEND}

type
  TSwipHttpControl = class(TClientDSRestHttpControl)
  public
    constructor Create;
    procedure LeerCapturasPendientes(ACapturas: TList<TCaptura>);
  end;

implementation

uses
  Entity.Classes,
  Capturas.Json;

const
  SERVER_URL        = 'http://172.26.0.19:8080';
  PATH_DS_REST      = '/datasnap/rest';
  METHOD_REVERSE    = '/TServerMethods1/ReverseString/';
  METHOD_CLIENTES   = '/TDataModuleClientes/LeerTodo';
  METHOD_CAPTURAS   = '/TDataModuleCapturas/LeerPendiente';

{ TSwipHttpControl }

constructor TSwipHttpControl.Create;
begin
  inherited;
  URLApi := SERVER_URL + PATH_DS_REST;
end;

procedure TSwipHttpControl.LeerCapturasPendientes(ACapturas: TList<TCaptura>);
var jsonValue : TJSONValue;
    list      : TList<TDatabaseEntity>;
    item      : TDatabaseEntity;
begin
  // obtener lista de capturas
  jsonValue := LeerEntidad(METHOD_CAPTURAS, '', '');
  if jsonValue <> nil then
    try
      if jsonValue is TJSONArray then
      begin
        list := TObjectList<TDatabaseEntity>.Create;
        try
          TCapturaJson.Parse(TJSONArray(jsonValue), list);
          while list.Count <> 0 do
          begin
            item := list.Extract(list.First);
            if item is TCaptura then  // always happen
              ACapturas.Add(TCaptura(item))
            else item.Free;
          end;
        finally
          list.Free;
        end;
      end;
    finally
      jsonValue.Free;
    end;
end;

end.
