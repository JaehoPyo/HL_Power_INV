object frmU530: TfrmU530
  Left = 2026
  Top = 0
  Caption = #54532#47196#44536#47016' '#49324#50857#51060#47141
  ClientHeight = 869
  ClientWidth = 1888
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_Top: TPanel
    Left = 0
    Top = 0
    Width = 1888
    Height = 80
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvNone
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 720
      Height = 78
      Align = alLeft
      Caption = '[ '#46321#47197#51068#49884' ]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = #46027#50880
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label31: TLabel
        Left = 355
        Top = 33
        Width = 15
        Height = 20
        Caption = '~'
      end
      object dtDateFr: TDateTimePicker
        Left = 25
        Top = 29
        Width = 150
        Height = 28
        Date = 42691.722841990740000000
        Time = 42691.722841990740000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 20
        Font.Name = #46027#50880
        Font.Style = []
        ImeName = 'Microsoft Office IME 2007'
        ParentFont = False
        TabOrder = 0
        OnKeyPress = DatePickerKeyPress
      end
      object dtTimeFr: TDateTimePicker
        Tag = 1
        Left = 195
        Top = 29
        Width = 150
        Height = 28
        Date = 42691.000000000000000000
        Time = 42691.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 20
        Font.Name = #46027#50880
        Font.Style = []
        ImeName = 'Microsoft Office IME 2007'
        Kind = dtkTime
        ParentFont = False
        TabOrder = 1
        OnKeyPress = DatePickerKeyPress
      end
      object dtDateTo: TDateTimePicker
        Left = 380
        Top = 29
        Width = 150
        Height = 28
        Date = 42691.722841990740000000
        Time = 42691.722841990740000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 20
        Font.Name = #46027#50880
        Font.Style = []
        ImeName = 'Microsoft Office IME 2007'
        ParentFont = False
        TabOrder = 2
        OnKeyPress = DatePickerKeyPress
      end
      object dtTimeTo: TDateTimePicker
        Tag = 1
        Left = 550
        Top = 29
        Width = 150
        Height = 28
        Date = 42691.000000000000000000
        Time = 42691.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 20
        Font.Name = #46027#50880
        Font.Style = []
        ImeName = 'Microsoft Office IME 2007'
        Kind = dtkTime
        ParentFont = False
        TabOrder = 3
        OnKeyPress = DatePickerKeyPress
      end
      object cbDateUse: TCheckBox
        Left = 6
        Top = 33
        Width = 14
        Height = 17
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
    end
    object GroupBox4: TGroupBox
      Left = 1417
      Top = 1
      Width = 232
      Height = 78
      Align = alLeft
      Caption = '[ '#51060#48292#53944#51221#48372' ]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = #46027#50880
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      ExplicitLeft = 1369
      ExplicitTop = 17
      object edtDesc: TEdit
        Left = 20
        Top = 29
        Width = 190
        Height = 28
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 20
        Font.Name = #46027#50880
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnKeyPress = KeyPress
      end
    end
    object GroupBox2: TGroupBox
      Left = 1185
      Top = 1
      Width = 232
      Height = 78
      Align = alLeft
      Caption = '[ '#51060#48292#53944#47749' ]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = #46027#50880
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object edtName: TEdit
        Left = 20
        Top = 29
        Width = 190
        Height = 28
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 20
        Font.Name = #46027#50880
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnKeyPress = KeyPress
      end
    end
    object GroupBox3: TGroupBox
      Left = 953
      Top = 1
      Width = 232
      Height = 78
      Align = alLeft
      Caption = '[ '#51060#48292#53944#53440#51077' ]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = #46027#50880
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object cbType: TComboBox
        Left = 20
        Top = 29
        Width = 190
        Height = 28
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 20
        Font.Name = #46027#50880
        Font.Style = [fsBold]
        ItemIndex = 0
        ParentFont = False
        TabOrder = 0
        Text = #51204#52404
        OnClick = cbTypeClick
        Items.Strings = (
          #51204#52404
          'N:'#51221#49345
          'E:'#50640#47084)
      end
    end
    object GroupBox5: TGroupBox
      Left = 721
      Top = 1
      Width = 232
      Height = 78
      Align = alLeft
      Caption = '[ '#47700#45684#51221#48372' ]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = #46027#50880
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      object edtMenu: TEdit
        Left = 20
        Top = 29
        Width = 190
        Height = 28
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 20
        Font.Name = #46027#50880
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnKeyPress = KeyPress
      end
    end
    object GroupBox6: TGroupBox
      Left = 1649
      Top = 1
      Width = 160
      Height = 78
      Align = alLeft
      Caption = '[ '#54665' '#45458#51060#51312#51208' ]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = #46027#50880
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      object edtRowHeight: TEdit
        Left = 27
        Top = 29
        Width = 93
        Height = 28
        Alignment = taCenter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 20
        Font.Name = #46027#50880
        Font.Style = [fsBold]
        NumbersOnly = True
        ParentFont = False
        TabOrder = 0
        Text = '1'
        OnChange = edtRowHeightChange
        OnKeyPress = KeyPress
      end
      object UpDown1: TUpDown
        Left = 120
        Top = 29
        Width = 16
        Height = 28
        Associate = edtRowHeight
        Min = 1
        Position = 1
        TabOrder = 1
      end
    end
  end
  object Pnl_Main: TPanel
    Left = 0
    Top = 80
    Width = 1888
    Height = 789
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvNone
    TabOrder = 1
    object dgInfo: TDBGridEh
      Left = 1
      Top = 1
      Width = 1886
      Height = 787
      Align = alClient
      ColumnDefValues.Layout = tlCenter
      ColumnDefValues.Title.Alignment = taCenter
      DataGrouping.Font.Charset = GB2312_CHARSET
      DataGrouping.Font.Color = clWindowText
      DataGrouping.Font.Height = -11
      DataGrouping.Font.Name = 'Tahoma'
      DataGrouping.Font.Style = []
      DataGrouping.ParentFont = False
      DataSource = dsInfo
      DrawGraphicData = True
      DynProps = <>
      EditActions = [geaCopyEh]
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = #46027#50880
      Font.Style = []
      FooterParams.FillStyle = cfstSolidEh
      FooterParams.Font.Charset = GB2312_CHARSET
      FooterParams.Font.Color = clWindowText
      FooterParams.Font.Height = -16
      FooterParams.Font.Name = #46027#50880
      FooterParams.Font.Style = []
      FooterParams.ParentFont = False
      ImeName = 'Microsoft Office IME 2007'
      IndicatorOptions = [gioShowRowIndicatorEh, gioShowRecNoEh]
      IndicatorParams.FillStyle = cfstSolidEh
      IndicatorTitle.TitleButton = True
      IndicatorTitle.UseGlobalMenu = False
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
      ParentFont = False
      RowHeight = 10
      RowLines = 1
      TabOrder = 0
      TitleParams.BorderInFillStyle = True
      TitleParams.FillStyle = cfstSolidEh
      TitleParams.Font.Charset = GB2312_CHARSET
      TitleParams.Font.Color = clWindowText
      TitleParams.Font.Height = -16
      TitleParams.Font.Name = #46027#50880
      TitleParams.Font.Style = []
      TitleParams.HorzLineColor = 5592405
      TitleParams.ParentFont = False
      TitleParams.RowHeight = 30
      TitleParams.VertLineColor = 5592405
      OnTitleClick = dgInfoTitleClick
      Columns = <
        item
          Alignment = taCenter
          AutoFitColWidth = False
          Color = 16710378
          DynProps = <>
          EditButtons = <>
          FieldName = 'CRT_DT_DESC'
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = #46027#50880
          Font.Style = []
          Footers = <>
          Title.Caption = #46321#47197#51068#49884
          Title.Font.Charset = GB2312_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -20
          Title.Font.Name = #46027#50880
          Title.Font.Style = []
          Width = 250
        end
        item
          Alignment = taCenter
          AutoFitColWidth = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'MENU_ID'
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = #46027#50880
          Font.Style = []
          Footers = <>
          Title.Caption = #47700#45684#53076#46300
          Title.Font.Charset = GB2312_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -20
          Title.Font.Name = #46027#50880
          Title.Font.Style = []
          Width = 200
        end
        item
          Alignment = taCenter
          AutoFitColWidth = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'MENU_NAME'
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = #46027#50880
          Font.Style = []
          Footers = <>
          Title.Caption = #47700#45684#47749
          Title.Font.Charset = GB2312_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -20
          Title.Font.Name = #46027#50880
          Title.Font.Style = []
          Width = 200
        end
        item
          Alignment = taCenter
          AutoFitColWidth = False
          DynProps = <>
          EditButtons = <>
          FieldName = 'HIST_TYPE'
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = #46027#50880
          Font.Style = []
          Footers = <>
          Title.Caption = #51060#48292#53944#53440#51077
          Title.Font.Charset = GB2312_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -20
          Title.Font.Name = #46027#50880
          Title.Font.Style = []
          Width = 130
        end
        item
          Alignment = taCenter
          DynProps = <>
          EditButtons = <>
          FieldName = 'EVENT_NAME'
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = #46027#50880
          Font.Style = []
          Footers = <>
          ReadOnly = True
          Title.Caption = #51060#48292#53944#47749
          Title.Font.Charset = GB2312_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -20
          Title.Font.Name = #46027#50880
          Title.Font.Style = []
          Width = 130
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'EVENT_DESC'
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = #46027#50880
          Font.Style = []
          Footers = <>
          ReadOnly = True
          Title.Caption = #51060#48292#53944#51221#48372
          Title.Font.Charset = GB2312_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -20
          Title.Font.Name = #46027#50880
          Title.Font.Style = []
          Width = 365
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'ERROR_MSG'
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = #46027#50880
          Font.Style = []
          Footers = <>
          ReadOnly = True
          Title.Caption = #50640#47084#47700#49884#51648
          Title.Font.Charset = GB2312_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -20
          Title.Font.Name = #46027#50880
          Title.Font.Style = []
          Width = 395
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'USER_ID'
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -20
          Font.Name = #46027#50880
          Font.Style = []
          Footers = <>
          ReadOnly = True
          Title.Caption = #52376#47532#44228#51221
          Title.Font.Charset = GB2312_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -20
          Title.Font.Name = #46027#50880
          Title.Font.Style = []
          Width = 165
        end
        item
          DynProps = <>
          EditButtons = <>
          Footers = <>
          Visible = False
          Width = 100
        end
        item
          DynProps = <>
          EditButtons = <>
          Footers = <>
          Visible = False
          Width = 100
        end
        item
          DynProps = <>
          EditButtons = <>
          Footers = <>
          Visible = False
          Width = 100
        end
        item
          DynProps = <>
          EditButtons = <>
          Footers = <>
          Visible = False
          Width = 100
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  object dsInfo: TDataSource
    DataSet = qryInfo
    Left = 1696
    Top = 270
  end
  object qryInfo: TADOQuery
    Connection = MainDm.MainDB
    CursorType = ctStatic
    Parameters = <>
    Left = 1728
    Top = 270
  end
  object qryTemp: TADOQuery
    Connection = MainDm.MainDB
    CursorType = ctStatic
    Parameters = <>
    Left = 1760
    Top = 270
  end
  object EhPrint: TPrintDBGridEh
    Options = []
    PageFooter.Font.Charset = DEFAULT_CHARSET
    PageFooter.Font.Color = clWindowText
    PageFooter.Font.Height = -11
    PageFooter.Font.Name = 'Tahoma'
    PageFooter.Font.Style = []
    PageHeader.Font.Charset = DEFAULT_CHARSET
    PageHeader.Font.Color = clWindowText
    PageHeader.Font.Height = -11
    PageHeader.Font.Name = 'Tahoma'
    PageHeader.Font.Style = []
    Units = MM
    Left = 1793
    Top = 270
  end
end
