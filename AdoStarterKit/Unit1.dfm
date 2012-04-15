object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'ADO Starter Kit (a Delphi Demo)'
  ClientHeight = 254
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 480
    Height = 229
    Align = alClient
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 0
    Top = 229
    Width = 480
    Height = 25
    DataSource = DataSource1
    Align = alBottom
    TabOrder = 1
    ExplicitLeft = 32
    ExplicitTop = 221
    ExplicitWidth = 240
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=BeispielDB.mdb;Pers' +
      'ist Security Info=False;'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 16
    Top = 24
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM KomponentenTabelle')
    Left = 96
    Top = 24
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 136
    Top = 24
  end
end
