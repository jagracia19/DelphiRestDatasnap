object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'FormMain'
  ClientHeight = 216
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 74
    Width = 418
    Height = 142
    Align = alClient
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 418
    Height = 74
    Align = alTop
    TabOrder = 1
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
    object ButtonDataSet: TButton
      Left = 89
      Top = 35
      Width = 75
      Height = 25
      Caption = 'DataSet'
      TabOrder = 2
      OnClick = ButtonDataSetClick
    end
    object ButtonHttpGet: TButton
      Left = 170
      Top = 35
      Width = 75
      Height = 25
      Caption = 'Http Get'
      TabOrder = 3
      OnClick = ButtonHttpGetClick
    end
    object ButtonSwipCapturas: TButton
      Left = 251
      Top = 35
      Width = 75
      Height = 25
      Caption = 'Swip Capturas'
      TabOrder = 4
      OnClick = ButtonSwipCapturasClick
    end
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 128
    Top = 112
  end
end
