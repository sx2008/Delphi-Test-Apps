object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'DP - Test Zufallszahlen ohne zur'#252'cklegen'
  ClientHeight = 254
  ClientWidth = 368
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 129
    Top = 0
    Width = 239
    Height = 254
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 0
    ExplicitLeft = 272
    ExplicitTop = 80
    ExplicitWidth = 208
    ExplicitHeight = 174
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 129
    Height = 254
    Align = alLeft
    TabOrder = 1
    object Label1: TLabel
      Left = 3
      Top = 16
      Width = 24
      Height = 13
      Caption = 'Start'
    end
    object Label2: TLabel
      Left = 3
      Top = 35
      Width = 24
      Height = 13
      Caption = 'Ende'
    end
    object Edit1: TEdit
      Left = 40
      Top = 8
      Width = 65
      Height = 21
      TabOrder = 0
      Text = '1'
    end
    object Edit2: TEdit
      Left = 40
      Top = 35
      Width = 65
      Height = 21
      TabOrder = 1
      Text = '49'
    end
    object Button1: TButton
      Left = 30
      Top = 78
      Width = 75
      Height = 25
      Caption = '&Start'
      TabOrder = 2
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 30
      Top = 109
      Width = 75
      Height = 25
      Caption = 'Ziehe Zahl'
      Enabled = False
      TabOrder = 3
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 30
      Top = 160
      Width = 75
      Height = 25
      Caption = 'Alle Zahlen'
      Enabled = False
      TabOrder = 4
      OnClick = Button3Click
    end
  end
end
