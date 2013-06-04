object Form1: TForm1
  Left = 300
  Top = 322
  Width = 624
  Height = 336
  Caption = 'Windows Handle Stress Test'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 616
    Height = 46
    Align = alTop
    TabOrder = 0
    object Edit1: TEdit
      Left = 31
      Top = 15
      Width = 65
      Height = 21
      TabOrder = 0
      Text = '4000'
    end
    object BtnStart: TButton
      Left = 120
      Top = 14
      Width = 75
      Height = 25
      Caption = '&Start'
      TabOrder = 1
      OnClick = BtnStartClick
    end
  end
  object Output: TGroupBox
    Left = 0
    Top = 46
    Width = 616
    Height = 263
    Align = alClient
    Caption = 'Output'
    TabOrder = 1
  end
end
