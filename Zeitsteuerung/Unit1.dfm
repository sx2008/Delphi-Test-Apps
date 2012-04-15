object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Zeitsteuerung mit Timer'
  ClientHeight = 254
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object BtnStart: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = '&Start'
    TabOrder = 0
    OnClick = BtnStartClick
  end
  object BtnStop: TButton
    Left = 120
    Top = 8
    Width = 75
    Height = 25
    Caption = 'S&top'
    TabOrder = 1
    OnClick = BtnStopClick
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 88
    Top = 40
  end
end
