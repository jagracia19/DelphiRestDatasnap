unit Server.Logger;

interface

uses
  System.SysUtils, System.IOUtils;

type
  TFileSystemLogger = class
  protected
    class procedure WriteRaw(const FileName, Text: string);
    class procedure WriteTime(const FileName, Text: string);
    class procedure ClipFile(const FileName: string; MaxSize: Cardinal);
  end;

  TCustomLogger = class
  private
    FEnabled: Boolean;
    FDirectory: string;
    FFileName: string;
    procedure SetEnabled(Value: Boolean);
    procedure SetDirectory(const Value: string);
    procedure SetFileName(const Value: string);
  public
    class function GetDirectorioLog: string;
    procedure Log(const Text: string);
    procedure Clip;
    constructor Create;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property Directorty: string read FDirectory write SetDirectory;
    property FileName: string read FFileName write SetFileName;
  end;

var Log: TCustomLogger;

implementation

uses
  Server.Common;

{ TFileSystemLogger }

class procedure TFileSystemLogger.ClipFile(const FileName: string; MaxSize: Cardinal);
const BufferSize = 1024;
var F, FTmp : file of byte;
    size    : Cardinal;
    cnt     : Integer;
    nmTmp   : string;
    buffer  : PChar;
begin
  cnt := 0; // evitar  warning
  if FileExists(FileName) then
  begin
    // comprobar tama?o del fichero
    AssignFile(F, FileName);
    Reset(F);
    size := FileSize(F);
    if size > MaxSize then
    begin
      buffer := PChar(AllocMem(BufferSize));
      try
        // copiar mitad del fichero en fichero temporal
        nmTmp := FileName + '.$$$';
        AssignFile(FTmp, nmTmp);
        Rewrite(FTmp);                  // crear fichero temporal
        Seek(F, size div 2);            // posicionar a mitad del fichero
        while not Eof(F) do
        begin
          BlockRead(F, buffer^, BufferSize, cnt);
          BlockWrite(FTmp, buffer^, cnt);
        end;
        CloseFile(FTmp);
      finally
        FreeMem(buffer);
      end;
    end;
    CloseFile(F);

    if size > MaxSize then
    begin
      // reemplazar fichero logger por el temporal
      TFile.Delete(FileName);
      TFile.Move(nmTmp, FileName);
    end;
  end;
end;

class procedure TFileSystemLogger.WriteRaw(const FileName, Text: string);
var F : TextFile;
begin
  AssignFile(F, FileName);
  if not FileExists(FileName) then
    Rewrite(F)
  else Append(F);
  Writeln(F, Text);
  Flush(F);
  CloseFile(F);
end;

class procedure TFileSystemLogger.WriteTime(const FileName, Text: string);
var st: string;
begin
  st := FormatDateTime('dd/mm/yy hh:nn:ss', Now) + ' ' + Text;
  WriteRaw(FileName, st);
end;

{ TCustomLogger }

procedure TCustomLogger.Clip;
const
  LogSizeMax = 5*1024*1024;
begin
  if FileExists(FileName) then
    TFileSystemLogger.ClipFile(FileName, LogSizeMax);
end;

constructor TCustomLogger.Create;
begin
  inherited;
end;

class function TCustomLogger.GetDirectorioLog: string;
var dir : string;
    st  : string;
begin
  st := NOMBRE_SERVIDOR;
  dir := TPath.Combine(TPath.GetDocumentsPath, st);
  {$IFDEF LINUX}
    {$IFDEF MODULE}
    dir := TPath.DirectorySeparatorChar + st;
    {$ENDIF}
  {$ENDIF}
  Result := TPath.Combine(dir, 'log');
end;

procedure TCustomLogger.Log(const Text: string);
begin
  if Enabled then
    TFileSystemLogger.WriteTime(FileName, Text);
end;

procedure TCustomLogger.SetDirectory(const Value: string);
begin
  FDirectory := Value;
end;

procedure TCustomLogger.SetEnabled(Value: Boolean);
begin
  FEnabled := Value;
end;

procedure TCustomLogger.SetFileName(const Value: string);
begin
  FFileName := Value;
end;

initialization
  Log := TCustomLogger.Create;
  Log.Enabled := False;
  try
    Log.Directorty := TCustomLogger.GetDirectorioLog;
    Log.FileName := TPath.Combine(Log.Directorty,
        TPath.ChangeExtension(NOMBRE_SERVIDOR, '.log'));
    if TFile.Exists(Log.FileName) then
      Log.Enabled := True;
  except
    // do nothing
  end;

finalization
  FreeAndNil(Log)
end.
