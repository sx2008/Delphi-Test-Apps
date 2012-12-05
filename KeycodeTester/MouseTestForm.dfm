object FrmMouseTest: TFrmMouseTest
  Left = 312
  Top = 406
  Width = 678
  Height = 411
  Caption = 'Mouse Tester'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 53
    Width = 670
    Height = 331
    Align = alClient
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 670
    Height = 53
    Align = alTop
    TabOrder = 1
    object Edit1: TEdit
      Left = 474
      Top = 16
      Width = 121
      Height = 21
      TabOrder = 0
      Text = 'Test Imput Field'
    end
    object CboCapture: TCheckBox
      Left = 18
      Top = 18
      Width = 97
      Height = 17
      Caption = 'Capture'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = CboCaptureClick
    end
  end
end
