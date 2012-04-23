object Form1: TForm1
  Left = 365
  Top = 311
  Width = 358
  Height = 324
  Caption = 'Paint Box Demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefaultPosOnly
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 0
    Top = 91
    Width = 350
    Height = 206
    Align = alClient
    Color = clAqua
    ParentColor = False
    OnPaint = PaintBox1Paint
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 350
    Height = 91
    Align = alTop
    TabOrder = 0
    object RgpColor: TRadioGroup
      Left = 11
      Top = 6
      Width = 94
      Height = 76
      Caption = 'Farbe'
      Items.Strings = (
        'Rot'
        'Gelb'
        'Grün'
        'Rot+Gelb')
      TabOrder = 0
      OnClick = RgpColorClick
    end
    object TrackBarHor: TTrackBar
      Left = 125
      Top = 39
      Width = 150
      Height = 31
      Max = 250
      Orientation = trHorizontal
      Frequency = 10
      Position = 10
      SelEnd = 0
      SelStart = 0
      TabOrder = 1
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = TrackBarHorChange
    end
  end
end
