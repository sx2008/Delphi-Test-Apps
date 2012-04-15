object FeedbackForm: TFeedbackForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'FeedbackForm'
  ClientHeight = 153
  ClientWidth = 443
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 137
    Width = 443
    Height = 16
    Align = alBottom
    TabOrder = 0
    ExplicitLeft = 48
    ExplicitTop = 128
    ExplicitWidth = 150
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 443
    Height = 137
    Align = alClient
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
    ExplicitLeft = 136
    ExplicitTop = 40
    ExplicitWidth = 185
    ExplicitHeight = 89
  end
end
