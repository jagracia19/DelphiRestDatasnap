object DataModuleEntity: TDataModuleEntity
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 340
  Width = 506
  object Connection: TFDConnection
    Params.Strings = (
      'Database=D:\DATABASE\WorkDir\Swip\SWIP.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=172.26.0.30'
      'CharacterSet=UTF8'
      'ExtendedMetadata=True'
      'DriverID=FB')
    Left = 48
    Top = 40
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 48
    Top = 160
  end
  object Query: TFDQuery
    Connection = Connection
    Left = 160
    Top = 40
  end
end
