object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'FormMain'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 74
    Align = alTop
    TabOrder = 0
    object EditParam: TEdit
      Left = 8
      Top = 8
      Width = 385
      Height = 21
      TabOrder = 0
      Text = 'Hola mundo!'
    end
    object ButtonManual: TButton
      Left = 8
      Top = 35
      Width = 75
      Height = 25
      Caption = 'Manual'
      TabOrder = 1
      OnClick = ButtonManualClick
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 74
    Width = 635
    Height = 225
    Align = alClient
    TabOrder = 1
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 216
    Top = 144
  end
end
