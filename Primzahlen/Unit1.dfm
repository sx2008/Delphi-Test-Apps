object Form1: TForm1
  Left = 310
  Top = 116
  Width = 326
  Height = 291
  Caption = 'Primzahl Generator'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 71
    Width = 318
    Height = 174
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 318
    Height = 71
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 33
      Top = 16
      Width = 32
      Height = 13
      Caption = 'Anzahl'
    end
    object Edit1: TEdit
      Left = 32
      Top = 31
      Width = 69
      Height = 28
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = '2000'
    end
    object BtnStart: TButton
      Left = 178
      Top = 19
      Width = 75
      Height = 25
      Caption = '&Start'
      TabOrder = 1
      OnClick = BtnStartClick
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 245
    Width = 318
    Height = 19
    Panels = <>
    SimplePanel = True
  end
end
