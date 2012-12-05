object Form1: TForm1
  Left = 270
  Top = 107
  Width = 613
  Height = 549
  ActiveControl = Memo1
  Caption = 'Keycode Tester'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefaultPosOnly
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 48
    Height = 13
    Caption = 'Text Input'
  end
  object Label2: TLabel
    Left = 8
    Top = 67
    Width = 54
    Height = 13
    Caption = 'Key Events'
  end
  object Label3: TLabel
    Left = 472
    Top = 128
    Width = 90
    Height = 13
    Caption = 'erkannte Barcodes'
  end
  object BtnClear: TBitBtn
    Left = 472
    Top = 40
    Width = 75
    Height = 25
    Caption = '&Clear'
    TabOrder = 0
    OnClick = BtnClearClick
  end
  object Edit2: TEdit
    Left = 472
    Top = 144
    Width = 65
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object BtnShowVKeyCodes: TButton
    Left = 472
    Top = 207
    Width = 129
    Height = 25
    Caption = 'Show Virtual Key Codes'
    TabOrder = 2
    OnClick = BtnShowVKeyCodesClick
  end
  object ListView1: TListView
    Left = 3
    Top = 81
    Width = 447
    Height = 434
    Columns = <
      item
        Caption = 'Scancode'
        Width = 100
      end
      item
        Caption = 'Mode'
      end
      item
        Caption = 'Key'
        Width = 150
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    GridLines = True
    ParentFont = False
    TabOrder = 3
    ViewStyle = vsReport
  end
  object ChkDown: TCheckBox
    Left = 464
    Top = 311
    Width = 97
    Height = 17
    Caption = '&Down'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object ChkPress: TCheckBox
    Left = 464
    Top = 331
    Width = 97
    Height = 17
    Caption = '&Press'
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
  object ChkUp: TCheckBox
    Left = 465
    Top = 352
    Width = 97
    Height = 17
    Caption = '&Up'
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object Button1: TButton
    Left = 470
    Top = 239
    Width = 75
    Height = 25
    Caption = 'Mouse Tester'
    TabOrder = 7
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 6
    Top = 22
    Width = 444
    Height = 37
    TabOrder = 8
  end
end
