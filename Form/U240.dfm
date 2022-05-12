object frmU240: TfrmU240
  Left = 2026
  Top = 265
  Caption = #47113#51060#46041
  ClientHeight = 875
  ClientWidth = 1918
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDesigned
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_Main: TPanel
    Left = 0
    Top = 0
    Width = 1918
    Height = 875
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvNone
    TabOrder = 0
    OnResize = Pnl_MainResize
    ExplicitWidth = 1888
    ExplicitHeight = 1001
    object btnOrder: TButton
      Left = 760
      Top = 712
      Width = 400
      Height = 150
      Caption = #51060#46041' '#51648#49884
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 80
      Font.Name = #46027#50880
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnOrderClick
    end
    object Panel4: TPanel
      Left = 60
      Top = 118
      Width = 1800
      Height = 570
      BevelInner = bvLowered
      BevelOuter = bvNone
      TabOrder = 1
      object dgInfo: TDBGridEh
        Left = 1
        Top = 1
        Width = 1798
        Height = 568
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
        Font.Height = -20
        Font.Name = #46027#50880
        Font.Style = []
        FooterRowCount = 1
        FooterParams.FillStyle = cfstSolidEh
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
        TitleParams.Font.Height = -20
        TitleParams.Font.Name = #46027#50880
        TitleParams.Font.Style = []
        TitleParams.HorzLineColor = 5592405
        TitleParams.ParentFont = False
        TitleParams.RowHeight = 26
        TitleParams.VertLineColor = 5592405
        OnTitleClick = dgInfoTitleClick
        Columns = <
          item
            Alignment = taCenter
            AutoFitColWidth = False
            Color = 16710378
            DynProps = <>
            EditButtons = <>
            FieldName = 'ID_CODE_DESC'
            Footers = <>
            TextEditing = False
            Title.Caption = #51201#51116#50948#52824
            Width = 100
          end
          item
            Alignment = taCenter
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'ID_STATUS_DESC'
            Footers = <>
            TextEditing = False
            Title.Caption = #49472#49345#53468
            Width = 100
          end
          item
            Alignment = taCenter
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'IN_USED'
            Footers = <>
            TextEditing = False
            Title.Caption = #51077#44256#44552#51648
            Visible = False
            Width = 100
          end
          item
            Alignment = taCenter
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'OT_USED'
            Footers = <>
            TextEditing = False
            Title.Caption = #52636#44256#44552#51648
            Visible = False
            Width = 100
          end
          item
            Alignment = taCenter
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'ITM_CD'
            Footers = <>
            TextEditing = False
            Title.Caption = #44592#51333#53076#46300
            Width = 100
          end
          item
            Alignment = taCenter
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'ITM_NAME'
            Footers = <>
            TextEditing = False
            Title.Caption = #44592#51333#47749
            Width = 100
          end
          item
            Alignment = taCenter
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'RF_LINE_NAME1'
            Footers = <>
            TextEditing = False
            Title.Caption = #46972#51064#47749'1'
            Width = 120
          end
          item
            Alignment = taCenter
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'RF_LINE_NAME2'
            Footers = <>
            TextEditing = False
            Title.Caption = #46972#51064#47749'2'
            Width = 120
          end
          item
            Alignment = taCenter
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'RF_PALLET_NO1'
            Footers = <>
            TextEditing = False
            Title.Caption = #54036#47112#53944#48264#54840'1'
            Width = 120
          end
          item
            Alignment = taCenter
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'RF_PALLET_NO2'
            Footers = <>
            TextEditing = False
            Title.Caption = #54036#47112#53944#48264#54840'2'
            Width = 120
          end
          item
            Alignment = taCenter
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'RF_MODEL_NO1'
            Footers = <>
            TextEditing = False
            Title.Caption = #52264#51333'#1'
            Width = 120
          end
          item
            Alignment = taCenter
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'RF_MODEL_NO2'
            Footers = <>
            TextEditing = False
            Title.Caption = #52264#51333'#2'
            Width = 120
          end
          item
            Alignment = taCenter
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'RF_BMA_NO'
            Footers = <>
            TextEditing = False
            Title.Caption = 'BMA'#49688#47049
            Width = 120
          end
          item
            Alignment = taCenter
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'RF_AREA'
            Footers = <>
            TextEditing = False
            Title.Caption = #49373#49328#51648
            Width = 120
          end
          item
            Alignment = taCenter
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'RF_NEW_BMA'
            Footers = <>
            TextEditing = False
            Title.Caption = #49888#44508'/'#51116#44256
            Width = 120
          end
          item
            Alignment = taCenter
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'ITM_SPEC'
            Footers = <>
            TextEditing = False
            Title.Caption = #44592#51333#49324#50577
            Visible = False
            Width = 200
          end
          item
            Alignment = taCenter
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'STOCK_IN_DT'
            Footers = <>
            TextEditing = False
            Title.Caption = #51077#44256#51068#51088
            Width = 250
          end
          item
            Alignment = taCenter
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'ID_MEMO'
            Footers = <>
            TextEditing = False
            Title.Caption = #52280#44256#49324#54637
            Width = 150
          end
          item
            Alignment = taCenter
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'RF_PALLET_BMA1'
            Footers = <>
            TextEditing = False
            Visible = False
            Width = 150
          end
          item
            Alignment = taCenter
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'RF_PALLET_BMA2'
            Footers = <>
            TextEditing = False
            Visible = False
            Width = 150
          end
          item
            Alignment = taCenter
            AutoFitColWidth = False
            DynProps = <>
            EditButtons = <>
            FieldName = 'RF_PALLET_BMA3'
            Footers = <>
            TextEditing = False
            Visible = False
            Width = 150
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object Panel1: TPanel
      Left = 60
      Top = 12
      Width = 1800
      Height = 100
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 2
      object Pnl_Top: TPanel
        Left = 0
        Top = 0
        Width = 1800
        Height = 100
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object sbtReset: TSpeedButton
          Left = 1620
          Top = 0
          Width = 180
          Height = 100
          Align = alRight
          Caption = #52488#44592#54868
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = 25
          Font.Name = #46027#50880
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
          OnClick = sbtResetClick
          ExplicitLeft = 1632
        end
        object gbCell: TGroupBox
          Left = 345
          Top = 0
          Width = 384
          Height = 100
          Align = alLeft
          Caption = '[ '#51201#51116#50948#52824' ]'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 25
          Font.Name = #46027#50880
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object Label1: TLabel
            Left = 100
            Top = 44
            Width = 25
            Height = 25
            Caption = #50676
          end
          object Label2: TLabel
            Left = 225
            Top = 44
            Width = 25
            Height = 25
            Caption = #50672
          end
          object Label3: TLabel
            Left = 350
            Top = 44
            Width = 25
            Height = 25
            Caption = #45800
          end
          object ComboBoxBank: TComboBox
            Left = 10
            Top = 41
            Width = 80
            Height = 33
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = 25
            Font.Name = #46027#50880
            Font.Style = []
            ImeName = 'Microsoft Office IME 2007'
            ItemIndex = 0
            ParentFont = False
            TabOrder = 0
            Text = #51204#52404
            OnChange = ComboBoxChange
            OnKeyPress = ComboBoxKeyPress
            Items.Strings = (
              #51204#52404
              '1'
              '2')
          end
          object ComboBoxBay: TComboBox
            Left = 135
            Top = 41
            Width = 80
            Height = 33
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = 25
            Font.Name = #46027#50880
            Font.Style = []
            ImeName = 'Microsoft Office IME 2007'
            ParentFont = False
            TabOrder = 1
            Text = #51204#52404
            OnChange = ComboBoxChange
            OnKeyPress = ComboBoxKeyPress
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
              '09')
          end
          object ComboBoxLevel: TComboBox
            Left = 260
            Top = 41
            Width = 80
            Height = 33
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = 25
            Font.Name = #46027#50880
            Font.Style = []
            ImeName = 'Microsoft Office IME 2007'
            ParentFont = False
            TabOrder = 2
            Text = #51204#52404
            OnChange = ComboBoxChange
            OnKeyPress = ComboBoxKeyPress
            Items.Strings = (
              #51204#52404
              '01'
              '02'
              '03'
              '04'
              '05'
              '06')
          end
        end
        object rgEMG: TRadioGroup
          Left = 908
          Top = 0
          Width = 192
          Height = 100
          Align = alLeft
          Caption = '[ '#52636#44256#50976#54805' ]'
          Color = clBtnFace
          Columns = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 25
          Font.Name = #46027#50880
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            #51068#48152
            #44596#44553)
          ParentColor = False
          ParentFont = False
          TabOrder = 1
          Visible = False
        end
        object rgITM_YN: TRadioGroup
          Left = 0
          Top = 0
          Width = 345
          Height = 100
          Align = alLeft
          Caption = '[ '#51333#47448' ]'
          Color = clBtnFace
          Columns = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = 25
          Font.Name = #46027#50880
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            #51204#52404
            #49892#54036#47112#53944
            #44277#54028#47112#53944
            #44592#53440)
          ParentColor = False
          ParentFont = False
          TabOrder = 2
          OnClick = rgITM_YNClick
        end
        object GroupBox2: TGroupBox
          Left = 729
          Top = 0
          Width = 179
          Height = 100
          Align = alLeft
          Caption = '[ '#52264#51333' ]'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -25
          Font.Name = #46027#50880
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          object edtModelNo: TEdit
            Left = 30
            Top = 41
            Width = 121
            Height = 33
            TabOrder = 0
            OnChange = ComboBoxChange
          end
        end
      end
    end
    object GroupBox1: TGroupBox
      Left = 60
      Top = 712
      Width = 400
      Height = 150
      Caption = '[ '#52636#44256#51221#48372' ]'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5066061
      Font.Height = 25
      Font.Name = #46027#50880
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 3
      object Panel2: TPanel
        Left = 16
        Top = 27
        Width = 121
        Height = 33
        BevelOuter = bvNone
        Caption = #52636#44256#44592#51333
        Color = 13624527
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 5066061
        Font.Height = 25
        Font.Name = #46027#50880
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
      end
      object Panel3: TPanel
        Left = 16
        Top = 68
        Width = 121
        Height = 33
        BevelOuter = bvNone
        Caption = #51201#51116#50948#52824
        Color = 13624527
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 5066061
        Font.Height = 25
        Font.Name = #46027#50880
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
      end
      object Panel5: TPanel
        Left = 16
        Top = 109
        Width = 121
        Height = 33
        BevelOuter = bvNone
        Caption = #51077#44256#51068#51088
        Color = 13624527
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 5066061
        Font.Height = 25
        Font.Name = #46027#50880
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
      end
      object edtOutCode: TEdit
        Left = 143
        Top = 27
        Width = 242
        Height = 33
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 25
        Font.Name = #46027#50880
        Font.Style = []
        ImeName = 'Microsoft Office IME 2007'
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
      object edtOutCell: TEdit
        Left = 143
        Top = 68
        Width = 242
        Height = 33
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 25
        Font.Name = #46027#50880
        Font.Style = []
        ImeName = 'Microsoft Office IME 2007'
        ParentFont = False
        ReadOnly = True
        TabOrder = 4
      end
      object edtOutInDate: TEdit
        Left = 143
        Top = 109
        Width = 242
        Height = 33
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = 25
        Font.Name = #46027#50880
        Font.Style = []
        ImeName = 'Microsoft Office IME 2007'
        ParentFont = False
        ReadOnly = True
        TabOrder = 5
      end
    end
    object GroupBox3: TGroupBox
      Left = 1200
      Top = 704
      Width = 393
      Height = 158
      Caption = '[ '#51060#46041#50948#52824' ]'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = 25
      Font.Name = #46027#50880
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      object Label4: TLabel
        Left = 100
        Top = 63
        Width = 25
        Height = 25
        Caption = #50676
      end
      object Label5: TLabel
        Left = 225
        Top = 63
        Width = 25
        Height = 25
        Caption = #50672
      end
      object Label6: TLabel
        Left = 350
        Top = 63
        Width = 25
        Height = 25
        Caption = #45800
      end
      object cbMoveBank: TComboBox
        Left = 10
        Top = 60
        Width = 80
        Height = 33
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = 25
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
      object cbMoveBay: TComboBox
        Left = 135
        Top = 60
        Width = 80
        Height = 33
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = 25
        Font.Name = #46027#50880
        Font.Style = []
        ImeName = 'Microsoft Office IME 2007'
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
          '09')
      end
      object cbMoveLevel: TComboBox
        Left = 260
        Top = 60
        Width = 80
        Height = 33
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = 25
        Font.Name = #46027#50880
        Font.Style = []
        ImeName = 'Microsoft Office IME 2007'
        ParentFont = False
        TabOrder = 2
        Text = #51204#52404
        Items.Strings = (
          #51204#52404
          '01'
          '02'
          '03'
          '04'
          '05'
          '06')
      end
    end
  end
  object dsInfo: TDataSource
    DataSet = qryInfo
    Left = 968
    Top = 6
  end
  object qryInfo: TADOQuery
    Connection = MainDm.MainDB
    CursorType = ctStatic
    Parameters = <>
    Left = 1000
    Top = 6
  end
  object qryTemp: TADOQuery
    Connection = MainDm.MainDB
    CursorType = ctStatic
    Parameters = <>
    Left = 1032
    Top = 6
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
    Left = 1065
    Top = 6
  end
  object PD_GET_JOBNO: TADOStoredProc
    Connection = MainDm.MainDB
    ProcedureName = 'PD_GET_JOBNO'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@i_Type'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@o_JobNo'
        Attributes = [paNullable]
        DataType = ftWideString
        Direction = pdInputOutput
        Size = 10
        Value = Null
      end>
    Left = 1121
    Top = 9
  end
  object qryRackCheck: TADOQuery
    Connection = MainDm.MainDB
    CursorType = ctStatic
    Parameters = <>
    Left = 1096
    Top = 6
  end
end
