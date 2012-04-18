object MainForm: TMainForm
  Left = 349
  Top = 215
  Width = 243
  Height = 301
  Caption = 'WinSock Demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 235
    Height = 255
    ActivePage = GetIPByNameTabSheet
    Align = alClient
    TabOrder = 0
    object GetIPByNameTabSheet: TTabSheet
      Caption = '&Name -> IP'
      object NameComboBox: TComboBox
        Left = 0
        Top = 0
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        Items.Strings = (
          'www.borland.com'
          'www.torry.net'
          'msdn.microsoft.com'
          'localhost')
      end
      object NameToIPButton: TButton
        Left = 152
        Top = -1
        Width = 75
        Height = 25
        Caption = '&Resolve'
        Default = True
        TabOrder = 1
        OnClick = NameToIPButtonClick
      end
      object AddressListBox: TListBox
        Left = 0
        Top = 32
        Width = 225
        Height = 193
        ItemHeight = 13
        TabOrder = 2
      end
    end
    object IPToNameTabSheet: TTabSheet
      Caption = '&IP -> Name'
      ImageIndex = 1
      object AddressComboBox: TComboBox
        Left = 0
        Top = 0
        Width = 145
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 13
        TabOrder = 0
        Items.Strings = (
          '64.176.74.101'
          '127.0.0.1'
          '207.105.83.56'
          '207.105.83.51')
      end
      object IPToNameButton: TButton
        Left = 152
        Top = 0
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = '&Resolve'
        Default = True
        TabOrder = 1
        OnClick = IPToNameButtonClick
      end
      object NameListBox: TListBox
        Left = 0
        Top = 32
        Width = 225
        Height = 193
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 13
        TabOrder = 2
      end
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 255
    Width = 235
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    SimplePanel = False
    OnResize = StatusBarResize
  end
end
