object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Zahnrad '#220'bersetzungsliste'
  ClientHeight = 254
  ClientWidth = 303
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 113
    Width = 303
    Height = 141
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    ExplicitTop = 90
    ExplicitHeight = 164
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 303
    Height = 113
    Align = alTop
    TabOrder = 1
    ExplicitTop = -6
    object Label1: TLabel
      Left = 100
      Top = 2
      Width = 122
      Height = 13
      Alignment = taRightJustify
      Caption = 'Mindestanzahl (Z'#228'hne)'
    end
    object Label2: TLabel
      Left = 100
      Top = 27
      Width = 122
      Height = 13
      Alignment = taRightJustify
      Caption = 'Maximalanzahl (Z'#228'hne)'
    end
    object Label3: TLabel
      Left = 100
      Top = 56
      Width = 122
      Height = 13
      Alignment = taRightJustify
      Caption = 'kleinstes '#220'-Verh'#228'ltnis'
    end
    object Label4: TLabel
      Left = 100
      Top = 83
      Width = 122
      Height = 13
      Alignment = taRightJustify
      Caption = 'gr'#246'sstes '#220'-Verh'#228'ltnis'
    end
    object Button1: TButton
      Left = 8
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Start'
      TabOrder = 0
      OnClick = Button1Click
    end
    object EditMinZ: TEdit
      Left = 232
      Top = -1
      Width = 41
      Height = 21
      TabOrder = 1
      Text = '14'
    end
    object EditMaxZ: TEdit
      Left = 232
      Top = 26
      Width = 41
      Height = 21
      TabOrder = 2
      Text = '40'
    end
    object EditMinV: TEdit
      Left = 232
      Top = 53
      Width = 41
      Height = 21
      TabOrder = 3
    end
    object EditMaxV: TEdit
      Left = 232
      Top = 80
      Width = 41
      Height = 21
      TabOrder = 4
    end
  end
end
