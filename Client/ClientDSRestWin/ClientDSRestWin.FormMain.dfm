object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'FormMain'
  ClientHeight = 227
  ClientWidth = 417
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
    Width = 417
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
    object ButtonDataSet: TButton
      Left = 89
      Top = 35
      Width = 75
      Height = 25
      Caption = 'DataSet'
      TabOrder = 2
      OnClick = ButtonDataSetClick
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 74
    Width = 417
    Height = 153
    Align = alClient
    TabOrder = 1
  end
end
