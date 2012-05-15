object Form1: TForm1
  Left = 486
  Top = 330
  Width = 239
  Height = 220
  Caption = 'Sleeping Thread Demo'
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
    Left = 19
    Top = 17
    Width = 75
    Height = 25
    Caption = 'WakeUp #1'
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
    Left = 19
    Top = 52
    Width = 75
    Height = 25
    Caption = 'Terminate #1'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 131
    Top = 18
    Width = 75
    Height = 25
    Caption = 'WakeUp #2'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Edit2: TEdit
    Left = 132
    Top = 121
    Width = 70
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    Text = 'Edit1'
  end
  object Button4: TButton
    Left = 130
    Top = 53
    Width = 75
    Height = 25
    Caption = 'Terminate #2'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Timer1: TTimer
    Interval = 400
    OnTimer = Timer1Timer
    Left = 19
    Top = 84
  end
end
