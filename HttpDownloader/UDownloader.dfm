object Form1: TForm1
  Left = 393
  Top = 282
  Width = 483
  Height = 405
  Caption = 'HTTP Downloader'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 87
    Width = 475
    Height = 291
    Align = alClient
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 475
    Height = 87
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 9
      Top = 6
      Width = 22
      Height = 13
      Caption = 'URL'
    end
    object CboURL: TComboBox
      Left = 4
      Top = 20
      Width = 467
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = 'http://www.delphipraxis.net/'
    end
    object BtnGet: TButton
      Left = 6
      Top = 56
      Width = 75
      Height = 25
      Caption = 'GET'
      TabOrder = 1
      OnClick = BtnGetClick
    end
    object BtnHead: TButton
      Left = 109
      Top = 56
      Width = 75
      Height = 25
      Caption = 'HEAD'
      TabOrder = 2
      OnClick = BtnHeadClick
    end
  end
end
