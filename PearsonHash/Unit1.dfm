object Form1: TForm1
  Left = 307
  Top = 138
  Width = 1049
  Height = 636
  Caption = 'Pearson Hash Code Generator (Monte Carlo Method)'
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
  object Memo1: TMemo
    Left = 28
    Top = 39
    Width = 229
    Height = 479
    Lines.Strings = (
      '12345'
      'Abstand'
      'Aktien'
      'anfall'
      'Arm'
      'Arrogant'
      'at least'
      'Auto'
      'Bauarbeiter'
      'Bier'
      'Bildschirm'
      'Bitburger'
      'blau'
      'Blei'
      'Bleibtreu'
      'Blitzkrieg'
      'Blut'
      'Computer'
      'Datenbank'
      'Delphi'
      'Delphi-Praxis'
      'Dreck'
      'Dumm'
      'Dummkopf'
      'Elefant'
      'Ende'
      'Fahrrad'
      'Feile'
      'fertig'
      'Fischer'
      'For-Schleife'
      'fort'
      'Frank'
      'Geheim'
      'Gehirn'
      'Geld'
      'Gleichung'
      'Gold'
      'hässlich'
      'Hallo'
      'Hand'
      'Hashing'
      'Held'
      'Herbert'
      'Herz'
      'Heuboden'
      'Hilfe'
      'http://www.embacadero.com'
      'Idiot'
      'Kaliber'
      'Kampf'
      'Katze'
      'keine'
      'Knie'
      'Krank'
      'langsam'
      'Langweilig'
      'Leber'
      'Lunge'
      'Maria'
      'Maus'
      'Monitor'
      'Nicht Gut'
      'obst'
      'Ohne'
      'Ohr'
      'OOP'
      'Organisch'
      'Passwort'
      'Paul'
      'Paulaner'
      'Pause'
      'Pearson'
      'Pech'
      'Perfekt'
      'Peter'
      'Plastik'
      'poppen'
      'Power'
      'Prärie'
      'Praxis'
      'Programmieren'
      'Prolog'
      'Python'
      'Salat'
      'saufen'
      'Schön'
      'Schüssel'
      'Schicksal'
      'schlafen'
      'schnackeln'
      'Schnake'
      'schnell'
      'Schwefel'
      'Schwein'
      'Silber'
      'Sofort'
      'Stier'
      'Tasche'
      'Tasse'
      'Tasten'
      'Team Foundation Server sucks'
      'The art of coding'
      'Tor'
      'Trank'
      'Treibgut'
      'trinken'
      'Trottel'
      'Unfall'
      'VW'
      'Wanda'
      'Was soll das?'
      'Wer andern eine Grube gräbt'
      'Windows'
      'Xenia'
      'Zange'
      'Zeilen')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object ButtonStart: TButton
    Left = 306
    Top = 500
    Width = 75
    Height = 41
    Caption = 'Start'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = ButtonStartClick
  end
  object Button2: TButton
    Left = 30
    Top = 533
    Width = 160
    Height = 25
    Caption = 'Add 100 Random Strings'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button1: TButton
    Left = 286
    Top = 572
    Width = 144
    Height = 25
    Caption = 'Make Pascal Code'
    TabOrder = 3
    OnClick = Button1Click
  end
  object BtnOpenFile: TButton
    Left = 30
    Top = 12
    Width = 117
    Height = 25
    Caption = 'Load Text file...'
    TabOrder = 4
    OnClick = BtnOpenFileClick
  end
  object PageControl1: TPageControl
    Left = 276
    Top = 21
    Width = 486
    Height = 450
    ActivePage = TabSheet1
    TabOrder = 5
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'Results'
      object MemoBest: TMemo
        Left = 0
        Top = 0
        Width = 478
        Height = 422
        Align = alClient
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Pearson Hast Table'
      ImageIndex = 1
      object Memo3: TMemo
        Left = 0
        Top = 0
        Width = 478
        Height = 422
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -9
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Source Code'
      ImageIndex = 2
      object Memo4: TMemo
        Left = 0
        Top = 0
        Width = 478
        Height = 422
        Align = alClient
        ScrollBars = ssBoth
        TabOrder = 0
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 145
    Top = 13
  end
end
