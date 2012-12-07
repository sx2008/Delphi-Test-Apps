object Form1: TForm1
  Left = 307
  Top = 138
  Width = 382
  Height = 267
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
  object MonthCalendar1: TMonthCalendar
    Left = 29
    Top = 48
    Width = 191
    Height = 154
    Date = 41250
    TabOrder = 0
    OnDblClick = MonthCalendar1DblClick
    OnGetMonthInfo = MonthCalendar1GetMonthInfo
  end
end
