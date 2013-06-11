object Form1: TForm1
  Left = 307
  Top = 138
  Width = 684
  Height = 248
  Caption = 'Multicolor Text Demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 50
    Top = 21
    Width = 589
    Height = 156
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 16
    Items.Strings = (
      'Das Paragrafenzeichen §§'
      ''
      
        'Das ist §+Bfett§-B. und hier geht'#39's weiter mit §+Ikursivem§-ITex' +
        't'
      'das ist ein §TC00FF0000blauer Text auf §BC0000FFFFgelbem Grund'
      ''
      '§+Uhier wird unterstrichen§-U aber hier nicht mehr')
    ParentFont = False
    Style = lbOwnerDrawFixed
    TabOrder = 0
    OnDrawItem = ListBox1DrawItem
  end
end
