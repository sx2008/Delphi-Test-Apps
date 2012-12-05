object VKeyCodesForm: TVKeyCodesForm
  Left = 323
  Top = 230
  Width = 614
  Height = 392
  Caption = 'Virtual Key Code'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ListView1: TListView
    Left = 0
    Top = 0
    Width = 606
    Height = 365
    Align = alClient
    Columns = <
      item
        Caption = 'Scancode'
        Width = 70
      end
      item
        Caption = 'Virtual Key Code'
      end
      item
        Caption = 'Name'
        Width = -2
        WidthType = (
          -2)
      end>
    GridLines = True
    ReadOnly = True
    TabOrder = 0
    ViewStyle = vsReport
  end
end
