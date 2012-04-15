object Form1: TForm1
  Left = 417
  Top = 222
  BorderStyle = bsSingle
  Caption = 'Matti'#39's DTMF -Tongenerator'
  ClientHeight = 302
  ClientWidth = 276
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = -10
    Top = 248
    Width = 297
    Height = 9
    Shape = bsTopLine
  end
  object Label1: TLabel
    Left = 12
    Top = 260
    Width = 125
    Height = 29
    Alignment = taCenter
    AutoSize = False
    Caption = 'by turboPASCAL for www.delphipraxis.net'
    Enabled = False
    Layout = tlCenter
    WordWrap = True
  end
  object btnClose: TButton
    Left = 176
    Top = 264
    Width = 87
    Height = 25
    Caption = 'Close'
    TabOrder = 0
    OnClick = btnCloseClick
  end
  object GroupBox1: TGroupBox
    Left = 20
    Top = 16
    Width = 153
    Height = 185
    TabOrder = 1
    object Button9: TButton
      Left = 24
      Top = 24
      Width = 32
      Height = 32
      Caption = '7'
      TabOrder = 0
      OnClick = NumBtnClick
    end
    object Button5: TButton
      Left = 24
      Top = 60
      Width = 32
      Height = 32
      Caption = '4'
      TabOrder = 1
      OnClick = NumBtnClick
    end
    object Button2: TButton
      Left = 24
      Top = 95
      Width = 32
      Height = 32
      Caption = '1'
      TabOrder = 2
      OnClick = NumBtnClick
    end
    object Button12: TButton
      Left = 24
      Top = 132
      Width = 32
      Height = 32
      Caption = '*'
      TabOrder = 3
      OnClick = NumBtnClick
    end
    object Button1: TButton
      Left = 60
      Top = 132
      Width = 32
      Height = 32
      Caption = '0'
      TabOrder = 4
      OnClick = NumBtnClick
    end
    object Button13: TButton
      Left = 96
      Top = 132
      Width = 32
      Height = 32
      Caption = '#'
      TabOrder = 5
      OnClick = NumBtnClick
    end
    object Button4: TButton
      Left = 96
      Top = 95
      Width = 32
      Height = 32
      Caption = '3'
      TabOrder = 6
      OnClick = NumBtnClick
    end
    object Button3: TButton
      Left = 60
      Top = 95
      Width = 32
      Height = 32
      Caption = '2'
      TabOrder = 7
      OnClick = NumBtnClick
    end
    object Button7: TButton
      Left = 60
      Top = 60
      Width = 32
      Height = 32
      Caption = '5'
      TabOrder = 8
      OnClick = NumBtnClick
    end
    object Button8: TButton
      Left = 96
      Top = 60
      Width = 32
      Height = 32
      Caption = '6'
      TabOrder = 9
      OnClick = NumBtnClick
    end
    object Button11: TButton
      Left = 96
      Top = 24
      Width = 32
      Height = 32
      Caption = '9'
      TabOrder = 10
      OnClick = NumBtnClick
    end
    object Button10: TButton
      Left = 60
      Top = 24
      Width = 32
      Height = 32
      Caption = '8'
      TabOrder = 11
      OnClick = NumBtnClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 184
    Top = 16
    Width = 65
    Height = 185
    TabOrder = 2
    object Button6: TButton
      Left = 16
      Top = 24
      Width = 32
      Height = 32
      Caption = 'A'
      TabOrder = 0
      OnClick = NumBtnClick
    end
    object Button14: TButton
      Left = 16
      Top = 60
      Width = 32
      Height = 32
      Caption = 'B'
      TabOrder = 1
      OnClick = NumBtnClick
    end
    object Button15: TButton
      Left = 16
      Top = 95
      Width = 32
      Height = 32
      Caption = 'C'
      TabOrder = 2
      OnClick = NumBtnClick
    end
    object Button16: TButton
      Left = 16
      Top = 132
      Width = 32
      Height = 32
      Caption = 'D'
      TabOrder = 3
      OnClick = NumBtnClick
    end
  end
  object Button17: TButton
    Left = 20
    Top = 212
    Width = 153
    Height = 25
    Caption = 'Telekom Zeitansage (01191) '
    TabOrder = 3
    OnClick = Button17Click
  end
  object Button18: TButton
    Left = 184
    Top = 212
    Width = 65
    Height = 25
    Caption = 'Fun'
    TabOrder = 4
    OnClick = Button18Click
  end
end
