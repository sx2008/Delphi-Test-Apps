object FrmWaehrung: TFrmWaehrung
  Left = 216
  Top = 123
  Width = 739
  Height = 474
  HelpContext = 8
  Caption = 'Währung'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  HelpFile = 'help\pss.chm'
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 731
    Height = 97
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object UrlLabel1: TUrlLabel
      Left = 8
      Top = 41
      Width = 136
      Height = 16
      Cursor = 5
      Caption = 'Deutsche Bundesbank'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
      Protocol = ptWWW
      Url = 
        'http://www.bundesbank.de/statistik/statistik_devisen_tabellen.ph' +
        'p'
    end
    object UrlLabel2: TUrlLabel
      Left = 8
      Top = 57
      Width = 150
      Height = 16
      Cursor = 5
      Caption = 'Europäische Zentralbank'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
      Protocol = ptWWW
      Url = 'http://www.ecb.int/stats/eurofxref'
    end
    object UrlLabel3: TUrlLabel
      Left = 8
      Top = 73
      Width = 96
      Height = 16
      Cursor = 5
      Caption = 'ISO 4217 Codes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
      Protocol = ptWWW
      Url = 'http://de.wikipedia.org/wiki/ISO_4217'
    end
    object Label2: TLabel
      Left = 9
      Top = 10
      Width = 278
      Height = 26
      Caption = 
        'Informationen zu aktuellen Wechselkursen sowie zu den'#13#10'Währungsc' +
        'odes nach ISO 4217 sind im Internet verfügbar.'
    end
    object Label1: TLabel
      Left = 421
      Top = 10
      Width = 279
      Height = 39
      Caption = 
        'Aktuelle Umrechnungsraten können aus dem Internet'#13#10'(Europäische ' +
        'Zentralbank) heruntergeladen werden.'#13#10'Sie werden dann automatisc' +
        'h in diese Tabelle eingetragen.'
    end
    object BtnInternetUpdate: TBitBtn
      Left = 424
      Top = 53
      Width = 135
      Height = 25
      Caption = 'Internet &Update'
      TabOrder = 0
      OnClick = BtnInternetUpdateClick
      Glyph.Data = {
        FA030000424DFA03000000000000FA0200002800000010000000100000000100
        08000000000000010000120B0000120B0000B1000000B100000000000000FFFF
        FF0051505300D6D5D8009B999E009F9CA200B5B4B600A8A5A900FF00FF009996
        99005352530043424300A8A3A700827D8000636061006A666700928D8D003A39
        39009E4A1D00B3ACA8008D4A20009D521E006F4F3300976A3C00C56F1000C36C
        1100D7BFA400F6870300FF900B00FF981900FFB3580085613500A5815700FFCB
        9000FFD7A900D4C1AB00C4BBB000EC870400E5820500F4900900F7950F00F898
        1500F7971A00FF9F2100FA9E2100F7A02B00F7A23000FFAC4400FCAA4300FBB9
        6500E09F4400F6B35600ECC79000F8B03F00FCCC7E00FFB83800F8B33800FFB9
        3B00FFBA4100EAD3AA00F7C05500E6C07300847B6900FFCA5C00FFCF6B00F3C5
        6600FFD16D00D0BD9400CC9B2600FFD87A00796A4400E4C78400A0998800F9DB
        8700FFDF8C00FFE29200FFE48C00FFF0A800BBB6A000FFF09E00B8A62E00AFAC
        9400CDC57500FFFBB6008C96260082A02000939A830095B74900AAC5720082AC
        340099A48C0097C2670067AB29008EC063008F9C880081C2650060BE420058C0
        48003EA2310047B339004DB8440061AC5C0032A43E001EB5370020BB3A001FB8
        390020B6390021B63A0022B83B002C7939001EB73B001EB63A001EB538001FB6
        3A001FB5390012B435001AB73B0015B6390025AC47004F72590017A2460036A0
        600050725E001A965600129358000D965900217A520049575200115D79007684
        890033698800156CA0001461900013649B001774BA002072B1003AABFD00256E
        A3003F739A003D7096000562B1000A60A4001C7ED000299EFF00278CE0002684
        D4002B93E600319EF300277BC0002981C6003498E6000869C3000867BC00096A
        C4000A6ECA000A64B4001164AE001163AD001B93FE00146BB8001468B2001E8B
        EC001A75C5001C6AB3001B62A0000B6DCA00295F96007392B300838590005051
        58009B9B9F00B0B0B200707071006060600057575700525252004D4D4D000808
        080808080808080808080808080808080808080808080808ACACACAF08080808
        080808151214160B0306070C0F080808081919187A626DAA04AB090D0E080808
        26251B548D8C8B241305A8A90808082728292A4484A5979C5636341A100A082C
        2E323E82A0A19E9A9B37393A35AD2D2F1E81A39188938F995E42403F38AE3057
        6587929694958E9D494B4A453CB033647DA290857C80985A4F534D4C410B3152
        799F867B687EA648514E43473D1108213B898367696620171F46777F0208085D
        22A7A478726C61602B557308080808085F238A76706B75631D5C080808080808
        085B586F6A716E501C080808080808080808086B6B745908080808080808}
    end
  end
  inline FrameNavForm1: TFrameNavForm
    Top = 403
    Width = 731
    Align = alBottom
    TabOrder = 1
    inherited BtnOK: TBitBtn
      Left = 539
    end
    inherited BtnCancel: TBitBtn
      Left = 635
    end
    inherited BtnHelp: TBitBtn
      Left = 440
      Visible = False
    end
    inherited NavNavigator: TDBNavigator
      Hints.Strings = ()
    end
  end
  object dxDBGrid1: TdxDBGrid
    Left = 0
    Top = 97
    Width = 731
    Height = 306
    Bands = <
      item
      end>
    DefaultLayout = False
    HeaderPanelRowCount = 1
    KeyField = 'IdCurrencyUnit'
    SummaryGroups = <>
    SummarySeparator = ', '
    Align = alClient
    TabOrder = 2
    DataSource = DsWaehrung
    Filter.Criteria = {00000000}
    object dxDBGrid1IdCurrencyUnit: TdxDBGridMaskColumn
      BandIndex = 0
      RowIndex = 0
      FieldName = 'IdCurrencyUnit'
    end
    object dxDBGrid1CurrencyUnit2: TdxDBGridMaskColumn
      BandIndex = 0
      RowIndex = 0
      FieldName = 'CurrencyUnit2'
    end
    object dxDBGrid1Waehrung: TdxDBGridMaskColumn
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Waehrung'
    end
    object dxDBGrid1EuroConvRate: TdxDBGridMaskColumn
      BandIndex = 0
      RowIndex = 0
      FieldName = 'EuroConvRate'
    end
    object dxDBGrid1LastUpdate: TdxDBGridDateColumn
      DisableEditor = True
      ReadOnly = True
      BandIndex = 0
      RowIndex = 0
      FieldName = 'LastUpdate'
    end
    object dxDBGrid1Countries: TdxDBGridButtonColumn
      BandIndex = 0
      RowIndex = 0
      HeaderMaxLineCount = 0
      FieldName = 'Countries'
      ShowButtonStyle = sbAlways
      Buttons = <
        item
          Default = True
        end>
      OnButtonClick = dxDBGrid1CountriesButtonClick
      DisableFilter = True
    end
  end
  object TblWaehrung: TADOTable
    Connection = DMcvs.__CVSMain
    BeforePost = TblWaehrungBeforePost
    TableName = 'WaehrungsKz'
    Left = 168
    Top = 152
    object TblWaehrungIdCurrencyUnit: TStringField
      FieldName = 'IdCurrencyUnit'
      Size = 3
    end
    object TblWaehrungWaehrung: TStringField
      FieldName = 'Waehrung'
      Size = 42
    end
    object TblWaehrungCurrencyUnit2: TStringField
      FieldName = 'CurrencyUnit2'
      Size = 3
    end
    object TblWaehrungEuroConvRate: TFloatField
      FieldName = 'EuroConvRate'
    end
    object TblWaehrungLastUpdate: TDateTimeField
      FieldName = 'LastUpdate'
    end
    object TblWaehrungCountries: TMemoField
      FieldName = 'Countries'
      BlobType = ftMemo
    end
  end
  object DsWaehrung: TDataSource
    DataSet = TblWaehrung
    Left = 264
    Top = 144
  end
end
