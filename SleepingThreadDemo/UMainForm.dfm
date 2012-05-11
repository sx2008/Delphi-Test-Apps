object Form1: TForm1
  Left = 486
  Top = 330
  Width = 355
  Height = 218
  Caption = 'Form1'
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
  object Button1: TButton
    Left = 49
    Top = 29
    Width = 75
    Height = 25
    Caption = 'WakeUp'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 21
    Top = 124
    Width = 70
    Height = 32
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Text = 'Edit1'
  end
  object Button2: TButton
    Left = 181
    Top = 115
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Timer1: TTimer
    Interval = 400
    OnTimer = Timer1Timer
    Left = 246
    Top = 37
  end
end
