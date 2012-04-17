object Form1: TForm1
  Left = 318
  Top = 271
  Width = 269
  Height = 96
  Caption = 'Autostart Demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Gauge1: TGauge
    Left = 0
    Top = 41
    Width = 261
    Height = 28
    Align = alClient
    Progress = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 261
    Height = 41
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 0
    OnClick = Panel1Click
  end
end
