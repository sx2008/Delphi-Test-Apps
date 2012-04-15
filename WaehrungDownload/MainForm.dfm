object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Umrechnungskurse der Europ'#228'ischen Zentralbank'
  ClientHeight = 366
  ClientWidth = 526
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 161
    Height = 25
    Caption = 'Download Umrechnungskurse'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 56
    Width = 513
    Height = 305
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Button2: TButton
    Left = 208
    Top = 8
    Width = 145
    Height = 25
    Caption = 'Laden aus Datei'
    TabOrder = 2
    OnClick = Button2Click
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.xml'
    InitialDir = '.'
    Options = [ofHideReadOnly, ofExtensionDifferent, ofFileMustExist, ofEnableSizing]
    Left = 424
    Top = 8
  end
end
