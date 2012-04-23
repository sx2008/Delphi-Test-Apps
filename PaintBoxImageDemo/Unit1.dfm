object Form1: TForm1
  Left = 293
  Top = 204
  Width = 377
  Height = 426
  Caption = 'Flaggen Demo'
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
  object Label1: TLabel
    Left = 8
    Top = 17
    Width = 42
    Height = 13
    Caption = 'PaintBox'
  end
  object Label2: TLabel
    Left = 260
    Top = 4
    Width = 29
    Height = 13
    Caption = 'Image'
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 369
    Height = 203
    Align = alTop
    Caption = 'Image'
    TabOrder = 0
    object Image1: TImage
      Left = 42
      Top = 12
      Width = 281
      Height = 185
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 203
    Width = 369
    Height = 196
    Align = alClient
    Caption = 'Paintbox'
    TabOrder = 1
    object PaintBox1: TPaintBox
      Left = 2
      Top = 15
      Width = 365
      Height = 179
      Align = alClient
      OnPaint = PaintBox1Paint
    end
  end
  object Timer1: TTimer
    Interval = 1500
    OnTimer = Timer1Timer
    Left = 66
    Top = 162
  end
end
