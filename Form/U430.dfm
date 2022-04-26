object frmU430: TfrmU430
  Left = 2026
  Top = 265
  Caption = #47001#51060#46041' '#51060#47141' '#51312#54924
  ClientHeight = 869
  ClientWidth = 1888
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDesigned
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
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
      Caption = '[ '#51060#46041#51068#51088' ]'
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
        Font.Height = -20
        Font.Name = #46027#50880
        Font.Style = []
        ImeName = 'Microsoft Office IME 2007'
        ParentFont = False
        TabOrder = 0
      end
      object dtTimeFr: TDateTimePicker
        Left = 195
        Top = 29
        Width = 150
        Height = 28
        Date = 42691.000000000000000000
        Time = 42691.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = #46027#50880
        Font.Style = []
        ImeName = 'Microsoft Office IME 2007'
        Kind = dtkTime
        ParentFont = False
        TabOrder = 1
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
        Font.Height = -20
        Font.Name = #46027#50880
        Font.Style = []
        ImeName = 'Microsoft Office IME 2007'
        ParentFont = False
        TabOrder = 2
      end
      object dtTimeTo: TDateTimePicker
        Left = 550
        Top = 29
        Width = 150
        Height = 28
        Date = 42691.000000000000000000
        Time = 42691.000000000000000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = #46027#50880
        Font.Style = []
        ImeName = 'Microsoft Office IME 2007'
        Kind = dtkTime
        ParentFont = False
        TabOrder = 3
      end
      object cbDateUse: TCheckBox
        Left = 6
        Top = 33
        Width = 14
        Height = 17
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 50
        Font.Name = #46027#50880
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 4
      end
    end
    object gbCode: TGroupBox
      Left = 721
      Top = 1
      Width = 190
      Height = 78
      Align = alLeft
      Caption = '[ '#51060#46041#44592#51333' ]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = #46027#50880
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object cbCode: TComboBox
        Left = 10
        Top = 29
        Width = 170
        Height = 28
        ImeName = 'Microsoft Office IME 2007'
        ItemIndex = 0
        TabOrder = 0
        Text = #51204#52404
        Items.Strings = (
          #51204#52404)
      end
    end
    object gbCell: TGroupBox
      Left = 911
      Top = 1
      Width = 340
      Height = 78
      Align = alLeft
      Caption = '[ '#51060#46041#50948#52824' ]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 20
      Font.Name = #46027#50880
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object Label1: TLabel
        Left = 90
        Top = 29
        Width = 20
        Height = 20
        Caption = #50676
      end
      object Label2: TLabel
        Left = 200
        Top = 33
        Width = 20
        Height = 20
        Caption = #50672
      end
      object Label3: TLabel
        Left = 310
        Top = 33
        Width = 20
        Height = 20
        Caption = #45800
      end
      object ComboBoxBank: TComboBox
        Left = 10
        Top = 29
        Width = 70
        Height = 28
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = 20
        Font.Name = #46027#50880
        Font.Style = []
        ImeName = 'Microsoft Office IME 2007'
        ItemIndex = 0
        ParentFont = False
        TabOrder = 0
        Text = #51204#52404
        Items.Strings = (
          #51204#52404
          '1'
          '2')
      end
      object ComboBoxBay: TComboBox
        Left = 120
        Top = 29
        Width = 70
        Height = 28
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = 20
        Font.Name = #46027#50880
        Font.Style = []
        ImeName = 'Microsoft Office IME 2007'
        ItemIndex = 0
        ParentFont = False
        TabOrder = 1
        Text = #51204#52404
        Items.Strings = (
          #51204#52404
          '01'
          '02'
          '03'
          '04'
          '05'
          '06'
          '07'
          '08'
          '09'
          '10'
          '11')
      end
      object ComboBoxLevel: TComboBox
        Left = 230
        Top = 29
        Width = 70
        Height = 28
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = 20
        Font.Name = #46027#50880
        Font.Style = []
        ImeName = 'Microsoft Office IME 2007'
        ItemIndex = 0
        ParentFont = False
        TabOrder = 2
        Text = #51204#52404
        Items.Strings = (
          #51204#52404
          '01'
          '02'
          '03')
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
  end
  object dgInfo: TDBGridEh
    Left = 0
    Top = 80
    Width = 1888
    Height = 789
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
    Font.Height = 20
    Font.Name = #46027#50880
    Font.Style = []
    FooterRowCount = 1
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
    EmptyDataInfo.Font.Charset = GB2312_CHARSET
    EmptyDataInfo.Font.Color = clGray
    EmptyDataInfo.Font.Height = 20
    EmptyDataInfo.Font.Name = #46027#50880
    EmptyDataInfo.Font.Style = []
    EmptyDataInfo.ParentFont = False
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
    ParentFont = False
    RowHeight = 10
    RowLines = 1
    TabOrder = 2
    TitleParams.BorderInFillStyle = True
    TitleParams.FillStyle = cfstSolidEh
    TitleParams.Font.Charset = GB2312_CHARSET
    TitleParams.Font.Color = clWindowText
    TitleParams.Font.Height = 20
    TitleParams.Font.Name = #46027#50880
    TitleParams.Font.Style = []
    TitleParams.HorzLineColor = 5592405
    TitleParams.ParentFont = False
    TitleParams.RowHeight = 30
    TitleParams.VertLineColor = 5592405
    Columns = <
      item
        Alignment = taCenter
        AutoFitColWidth = False
        Color = 16710378
        DynProps = <>
        EditButtons = <>
        FieldName = 'JOBD_DESC'
        Footers = <>
        Title.Caption = #51089#50629#50976#54805
        Width = 160
      end
      item
        Alignment = taCenter
        AutoFitColWidth = False
        DynProps = <>
        EditButtons = <>
        FieldName = 'ITM_CD'
        Footers = <>
        Title.Caption = #44592#51333#53076#46300
        Width = 160
      end
      item
        Alignment = taCenter
        AutoFitColWidth = False
        DynProps = <>
        EditButtons = <>
        FieldName = 'LUGG'
        Footers = <>
        Title.Caption = #51089#50629#48264#54840
        Width = 160
      end
      item
        Alignment = taCenter
        DynProps = <>
        EditButtons = <>
        FieldName = 'OD_CODE'
        Footers = <>
        Title.Caption = #54616#50669#50948#52824
        Width = 200
      end
      item
        Alignment = taCenter
        AutoFitColWidth = False
        DynProps = <>
        EditButtons = <>
        FieldName = 'ID_CODE'
        Footers = <>
        Title.Caption = #51201#51116#50948#52824
        Width = 200
      end
      item
        Alignment = taCenter
        AutoFitColWidth = False
        DynProps = <>
        EditButtons = <>
        FieldName = 'NOWMC_DESC'
        Footers = <>
        Title.Caption = #51652#54665#49345#53468
        Width = 220
      end
      item
        Alignment = taCenter
        AutoFitColWidth = False
        DynProps = <>
        EditButtons = <>
        FieldName = 'JOBERRORC_DESC'
        Footers = <>
        Title.Caption = #50640#47084#49345#53468
        Width = 200
      end
      item
        Alignment = taCenter
        AutoFitColWidth = False
        DynProps = <>
        EditButtons = <>
        FieldName = 'JOBERRORD_DESC'
        Footers = <>
        Title.Caption = #50640#47084#53076#46300
        Width = 200
      end
      item
        Alignment = taCenter
        AutoFitColWidth = False
        DynProps = <>
        EditButtons = <>
        FieldName = 'REG_TIME_DESC'
        Footers = <>
        Title.Caption = #51089#50629#51068#51088
        Width = 405
      end
      item
        Alignment = taCenter
        DynProps = <>
        EditButtons = <>
        FieldName = 'RF_LINE_NAME1'
        Footers = <>
        Title.Caption = #49885#48324#51088#51060#47492'1'
        Width = 200
      end
      item
        Alignment = taCenter
        DynProps = <>
        EditButtons = <>
        FieldName = 'RF_LINE_NAME2'
        Footers = <>
        Title.Caption = #49885#48324#51088#51060#47492'2'
        Width = 200
      end
      item
        Alignment = taCenter
        DynProps = <>
        EditButtons = <>
        FieldName = 'RF_PALLET_NO1'
        Footers = <>
        Title.Caption = #49885#48324#48264#54840'1'
        Width = 200
      end
      item
        Alignment = taCenter
        DynProps = <>
        EditButtons = <>
        FieldName = 'RF_PALLET_NO2'
        Footers = <>
        Title.Caption = #49885#48324#48264#54840'2'
        Width = 200
      end
      item
        Alignment = taCenter
        DynProps = <>
        EditButtons = <>
        FieldName = 'RF_MODEL_NO1'
        Footers = <>
        Title.Caption = #47784#45944'1'
        Width = 200
      end
      item
        Alignment = taCenter
        DynProps = <>
        EditButtons = <>
        FieldName = 'RF_MODEL_NO2'
        Footers = <>
        Title.Caption = #47784#45944'2'
        Width = 200
      end
      item
        Alignment = taCenter
        DynProps = <>
        EditButtons = <>
        FieldName = 'RF_BMA_NO'
        Footers = <>
        Title.Caption = #49688#47049
        Width = 200
      end
      item
        Alignment = taCenter
        DynProps = <>
        EditButtons = <>
        FieldName = 'RF_AREA '
        Footers = <>
        Title.Caption = #49373#49328#51648
        Width = 200
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object dsInfo: TDataSource
    DataSet = qryInfo
    Left = 840
    Top = 118
  end
  object qryInfo: TADOQuery
    Connection = MainDm.MainDB
    CursorType = ctStatic
    Parameters = <>
    Left = 872
    Top = 118
  end
  object qryTemp: TADOQuery
    Connection = MainDm.MainDB
    CursorType = ctStatic
    Parameters = <>
    Left = 904
    Top = 118
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
    Left = 937
    Top = 118
  end
end
