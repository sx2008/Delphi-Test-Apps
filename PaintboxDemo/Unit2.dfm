object Form1: TForm1
  Left = 302
  Top = 318
  Width = 501
  Height = 333
  Caption = 'Farbverlauf Demo - Delphi Praxis'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 0
    Top = 41
    Width = 493
    Height = 265
    Align = alClient
    OnPaint = PaintBox1Paint
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 493
    Height = 41
    Align = alTop
    TabOrder = 0
    object Button1: TButton
      Left = 142
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Color Dialog'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object ColorDialog1: TColorDialog
    Ctl3D = True
    Color = clLime
    Left = 55
    Top = 6
  end
end
