object frmPopup_Update: TfrmPopup_Update
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 552
  ClientWidth = 375
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_Main: TPanel
    Left = 0
    Top = 0
    Width = 375
    Height = 552
    Align = alClient
    BevelInner = bvRaised
    Color = clBlue
    ParentBackground = False
    TabOrder = 0
    ExplicitHeight = 523
    object Pnl_Sub: TPanel
      Left = 4
      Top = 67
      Width = 367
      Height = 481
      ParentCustomHint = False
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      BiDiMode = bdLeftToRight
      Ctl3D = True
      DoubleBuffered = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBiDiMode = False
      ParentBackground = False
      ParentCtl3D = False
      ParentDoubleBuffered = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      ExplicitHeight = 452
      object Label1: TLabel
        Left = 841
        Top = 77
        Width = 82
        Height = 16
        Caption = 'T/M Group (1)'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
      end
      object Label2: TLabel
        Left = 840
        Top = 102
        Width = 82
        Height = 16
        Caption = 'T/M Group (2)'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
      end
      object Label3: TLabel
        Left = 830
        Top = 128
        Width = 76
        Height = 16
        Caption = 'Item/Tray No'
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
      end
      object Panel18: TPanel
        Left = 2
        Top = 2
        Width = 363
        Height = 477
        Align = alClient
        BevelInner = bvLowered
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        ExplicitHeight = 448
        object Panel19: TPanel
          Left = 10
          Top = 10
          Width = 100
          Height = 24
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #51201#51116#50948#52824
          Color = 9365209
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
        end
        object Panel16: TPanel
          Left = 10
          Top = 64
          Width = 100
          Height = 24
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #44592#51333#53076#46300
          Color = 9365209
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
        end
        object Panel23: TPanel
          Left = 10
          Top = 118
          Width = 100
          Height = 24
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #44592#51333#49324#50577
          Color = 9365209
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 2
        end
        object Panel1: TPanel
          Left = 10
          Top = 145
          Width = 100
          Height = 24
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #49688#47049
          Color = 9365209
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 3
        end
        object Panel26: TPanel
          Left = 10
          Top = 37
          Width = 100
          Height = 24
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #49472' '#49345#53468
          Color = 9365209
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 4
        end
        object Panel27: TPanel
          Left = 10
          Top = 172
          Width = 100
          Height = 24
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #51077#44256#51068#49884
          Color = 9365209
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 5
        end
        object Panel30: TPanel
          Left = 10
          Top = 91
          Width = 100
          Height = 24
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #44592#51333#47749
          Color = 9365209
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 6
        end
        object Panel31: TPanel
          Left = 10
          Top = 226
          Width = 100
          Height = 24
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #51077#44256#44552#51648
          Color = 9365209
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 7
        end
        object Panel32: TPanel
          Left = 170
          Top = 229
          Width = 100
          Height = 24
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #52636#44256#44552#51648
          Color = 9365209
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 8
        end
        object ComboBoxHogi: TComboBox
          Left = 115
          Top = 10
          Width = 54
          Height = 24
          Enabled = False
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = []
          ImeName = 'Microsoft Office IME 2007'
          ParentFont = False
          TabOrder = 9
          Items.Strings = (
            ''
            '1')
        end
        object ComboBoxBank: TComboBox
          Left = 170
          Top = 10
          Width = 54
          Height = 24
          Enabled = False
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = []
          ImeName = 'Microsoft Office IME 2007'
          ItemIndex = 0
          ParentFont = False
          TabOrder = 10
          Items.Strings = (
            ''
            '1'
            '2')
        end
        object ComboBoxBay: TComboBox
          Left = 225
          Top = 10
          Width = 54
          Height = 24
          Enabled = False
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = []
          ImeName = 'Microsoft Office IME 2007'
          ParentFont = False
          TabOrder = 11
          Items.Strings = (
            ''
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
          Left = 280
          Top = 10
          Width = 55
          Height = 24
          Enabled = False
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = []
          ImeName = 'Microsoft Office IME 2007'
          ParentFont = False
          TabOrder = 12
          Items.Strings = (
            ''
            '01'
            '02'
            '03'
            '04'
            '05'
            '06')
        end
        object CB_ID_STATUS: TComboBox
          Left = 115
          Top = 37
          Width = 220
          Height = 24
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = []
          ImeName = 'Microsoft Office IME 2007'
          ParentFont = False
          TabOrder = 13
          Items.Strings = (
            #44277#49472
            #44277#54028#47112#53944
            #49892#49472
            #44552#51648#49472
            #51077#44256#50696#50557
            #52636#44256#50696#50557
            #51060#51473#51077#44256
            #44277#52636#44256)
        end
        object edtITM_CD: TEdit
          Left = 115
          Top = 64
          Width = 220
          Height = 24
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = []
          ImeName = 'Microsoft Office IME 2007'
          ParentFont = False
          TabOrder = 14
        end
        object edtITM_NAME: TEdit
          Left = 115
          Top = 91
          Width = 220
          Height = 24
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = []
          ImeName = 'Microsoft Office IME 2007'
          ParentFont = False
          TabOrder = 15
        end
        object edtITM_SPEC: TEdit
          Left = 115
          Top = 118
          Width = 220
          Height = 24
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = []
          ImeName = 'Microsoft Office IME 2007'
          ParentFont = False
          TabOrder = 16
        end
        object edtITM_QTY: TEdit
          Left = 115
          Top = 145
          Width = 220
          Height = 24
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = []
          ImeName = 'Microsoft Office IME 2007'
          ParentFont = False
          TabOrder = 17
        end
        object cbInUSED: TCheckBox
          Left = 115
          Top = 229
          Width = 57
          Height = 21
          Caption = #44552#51648
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 18
        end
        object cbOtUSED: TCheckBox
          Left = 276
          Top = 229
          Width = 57
          Height = 21
          Caption = #44552#51648
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 19
        end
        object Panel8: TPanel
          Left = 10
          Top = 199
          Width = 100
          Height = 24
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #48708#44256
          Color = 9365209
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 20
        end
        object edtID_MEMO: TEdit
          Left = 115
          Top = 199
          Width = 220
          Height = 24
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = []
          ImeName = 'Microsoft Office IME 2007'
          ParentFont = False
          TabOrder = 21
        end
        object dtDate: TDateTimePicker
          Left = 115
          Top = 172
          Width = 117
          Height = 24
          Date = 42691.722841990740000000
          Time = 42691.722841990740000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = []
          ImeName = 'Microsoft Office IME 2007'
          ParentFont = False
          TabOrder = 22
        end
        object dtTime: TDateTimePicker
          Left = 238
          Top = 172
          Width = 97
          Height = 24
          Date = 42691.000000000000000000
          Time = 42691.000000000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = []
          ImeName = 'Microsoft Office IME 2007'
          Kind = dtkTime
          ParentFont = False
          TabOrder = 23
        end
        object Panel2: TPanel
          Left = 10
          Top = 280
          Width = 100
          Height = 24
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #46972#51064#47749'2'
          Color = 9365209
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 24
        end
        object Panel11: TPanel
          Left = 10
          Top = 307
          Width = 100
          Height = 24
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #54036#47112#53944#48264#54840'1'
          Color = 9365209
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 25
        end
        object Panel20: TPanel
          Left = 10
          Top = 334
          Width = 100
          Height = 24
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #54036#47112#53944#48264#54840'2'
          Color = 9365209
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 26
        end
        object Panel21: TPanel
          Left = 10
          Top = 253
          Width = 100
          Height = 24
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #46972#51064#47749'1'
          Color = 9365209
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 27
        end
        object Panel22: TPanel
          Left = 10
          Top = 361
          Width = 100
          Height = 24
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #52264#51333'#1'
          Color = 9365209
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 28
        end
        object Panel25: TPanel
          Left = 10
          Top = 388
          Width = 100
          Height = 24
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #52264#51333'#2'
          Color = 9365209
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 29
        end
        object Panel28: TPanel
          Left = 10
          Top = 415
          Width = 100
          Height = 24
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #49373#49328#51648
          Color = 9365209
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 30
        end
        object edtLineName1: TEdit
          Left = 115
          Top = 253
          Width = 220
          Height = 24
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = []
          ImeName = 'Microsoft Office IME 2007'
          ParentFont = False
          TabOrder = 31
        end
        object edtLineName2: TEdit
          Left = 115
          Top = 280
          Width = 220
          Height = 24
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = []
          ImeName = 'Microsoft Office IME 2007'
          ParentFont = False
          TabOrder = 32
        end
        object edtPalletNo1: TEdit
          Left = 115
          Top = 307
          Width = 220
          Height = 24
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = []
          ImeName = 'Microsoft Office IME 2007'
          ParentFont = False
          TabOrder = 33
        end
        object edtPalletNo2: TEdit
          Left = 115
          Top = 334
          Width = 220
          Height = 24
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = []
          ImeName = 'Microsoft Office IME 2007'
          ParentFont = False
          TabOrder = 34
        end
        object edtModelNo1: TEdit
          Left = 115
          Top = 361
          Width = 220
          Height = 24
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = []
          ImeName = 'Microsoft Office IME 2007'
          ParentFont = False
          TabOrder = 35
        end
        object edtModelNo2: TEdit
          Left = 115
          Top = 388
          Width = 220
          Height = 24
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = []
          ImeName = 'Microsoft Office IME 2007'
          ParentFont = False
          TabOrder = 36
        end
        object edtArea: TEdit
          Left = 115
          Top = 415
          Width = 220
          Height = 24
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = []
          ImeName = 'Microsoft Office IME 2007'
          ParentFont = False
          TabOrder = 37
        end
        object Panel3: TPanel
          Left = 10
          Top = 442
          Width = 100
          Height = 24
          Alignment = taRightJustify
          BevelOuter = bvNone
          Caption = #49888#44508'/'#51116#44256
          Color = 9365209
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 38
        end
        object edtNewBMA: TEdit
          Left = 115
          Top = 442
          Width = 220
          Height = 24
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #46027#50880
          Font.Style = []
          ImeName = 'Microsoft Office IME 2007'
          ParentFont = False
          TabOrder = 39
        end
      end
    end
    object Pnl_Top: TPanel
      Left = 2
      Top = 2
      Width = 371
      Height = 65
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvLowered
      ParentBackground = False
      TabOrder = 1
      object Pnl_BTN: TPanel
        Left = 247
        Top = 2
        Width = 122
        Height = 61
        Align = alRight
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object Pnl_Btn5: TPanel
          Left = 61
          Top = 0
          Width = 61
          Height = 61
          Align = alRight
          BevelInner = bvRaised
          Color = 16250871
          TabOrder = 0
          object btnClose: TSpeedButton
            Tag = 4
            Left = 2
            Top = 2
            Width = 57
            Height = 57
            Cursor = crHandPoint
            ParentCustomHint = False
            Align = alClient
            BiDiMode = bdLeftToRight
            Caption = #45803' '#44592
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = #46027#50880
            Font.Style = []
            Glyph.Data = {
              761A0000424D761A000000000000360000002800000046000000180000000100
              200000000000401A0000120B0000120B00000000000000000000CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CCD1D400DADDE000FBFBFC00FEFEFD00FAFAF800FBFBF800FBFBF800FBFB
              F800FBFBF800FBFBF800FBFBF800FFFFFD00F8F8F900D6DADC00CBD1D400CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2
              D200D2D2D200D2D2D200D2D2D200D0D0D000DDDDDD00FCFCFC00FEFEFE00F9F9
              F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900F9F9F900FEFEFE00F8F8
              F800D9D9D900D0D0D000D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2
              D200D2D2D200D2D2D200D2D2D200D2D2D200CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600CCD1D400D7DCDE00F7F7
              F900EFEFEA00C6C6BC00B7B7B000B9B9B100B9B9B100B9B9B100B9B9B100B9B9
              B000B7B7AF00C8C8BE00F2F3EE00F2F4F600D3D7DA00CDD2D500CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600D2D2
              D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2
              D200D0D0D000DBDBDB00F8F8F800EDEDED00C1C1C100B3B3B300B4B4B400B4B4
              B400B4B4B400B3B3B300B3B3B300B2B2B200C2C2C200EFEFEF00F4F4F400D7D7
              D700D1D1D100D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2
              D200D2D2D200D2D2D200CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CCD1D400D8DCDF00F8F9FB00F3F3EA00A0A0A2004242
              9B003838A4003D3DA3003D3DA2003D3DA2003D3DA1003D3DA1003A3AA3003838
              92009A9A9F00F9F8EE00F4F5F700D4D8DB00CDD2D500CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600D2D2D200D2D2D200D2D2
              D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D0D0D000DCDCDC00FAFA
              FA00EEEEEE00A0A0A0006E6E6E006E6E6E00707070006F6F6F006F6F6F006E6E
              6E006F6F6F006E6E6E00646464009D9D9D00F3F3F300F5F5F500D7D7D700D1D1
              D100D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2
              D200CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CCD1
              D400D7DBDD00F7F8F900F2F2EA00A0A09F003939A7002525E0002C2CE9002727
              EB002727EB002828EC002828EC002929ED003030EC002222DF00252598009D9D
              9D00F6F6EE00F4F4F500D3D7DA00CDD2D500CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600D2D2D200D2D2D200D2D2D200D2D2D200D2D2
              D200D2D2D200D2D2D200D0D0D000DADADA00F9F9F900EDEDED009E9E9E007070
              7000828282008989890089898900888888008A8A8A008A8A8A008B8B8B008D8D
              8D00818181005E5E5E009D9D9D00F2F2F200F4F4F400D6D6D600D1D1D100D2D2
              D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CBD0D400D8DCDE00F8F8F900F1F0
              E900A2A2A0003939A8002C2CE4003333E9003232D0005252B7005454BB004B4B
              BE004E4EBB004E4EBA003636D4003939F0002D2DE60025259A009F9F9F00F4F3
              ED00F3F4F500D3D8DA00CCD1D500CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200CFCF
              CF00DBDBDB00F8F8F800EDEDED00A0A0A00070707000888888008E8E8E008181
              8100848484008787870084848400848484008484840085858500949494008989
              89005F5F5F009F9F9F00F1F1F100F4F4F400D7D7D700D0D0D000D2D2D200D2D2
              D200D2D2D200D2D2D200D2D2D200D2D2D200CED3D600CED3D600CED3D600CED3
              D600CED3D600CDD2D500D7DBDD00F7F8F900F2F1EA00A0A0A0003A3AAA002F2F
              E5003232E9003939C800A1A1B500DCDCD600D9D9D700D4D4D200D6D6D400DADA
              D300A1A1BC003B3BD2003A3AF1003232E90027279A009D9D9D00F7F6EE00F3F4
              F600D3D7DA00CDD2D500CED3D600CED3D600CED3D600CED3D600CED3D600D2D2
              D200D2D2D200D2D2D200D2D2D200D2D2D200D1D1D100DADADA00F8F8F800EEEE
              EE00A0A0A000727272008A8A8A008D8D8D0080808000AAAAAA00D9D9D900D8D8
              D800D2D2D200D4D4D400D5D5D500AEAEAE0086868600959595008D8D8D006060
              60009D9D9D00F3F3F300F4F4F400D6D6D600D1D1D100D2D2D200D2D2D200D2D2
              D200D2D2D200D2D2D200CED3D600CED3D600CED3D600CED3D600CDD2D500D2D7
              DA00F8F8FA00F5F5EC00A4A4A2003A3AAA002F2FE6003939E8002C2CDB008D8D
              BB00EAEAE600DCDCE800DADAE600DBDBE700DADAE600DBDBE900E9E9E5008E8E
              C3002E2EE4004141F1003232EA0028289900A1A19F00F8F9EF00F4F5F800D2D6
              D900CDD2D500CED3D600CED3D600CED3D600CED3D600D2D2D200D2D2D200D2D2
              D200D2D2D200D1D1D100D6D6D600F9F9F900F1F1F100A4A4A400717171008A8A
              8A009090900084848400A4A4A400E8E8E800E2E2E200E0E0E000E1E1E100E0E0
              E000E2E2E200E7E7E700A9A9A90088888800979797008D8D8D0060606000A0A0
              A000F4F4F400F6F6F600D5D5D500D1D1D100D2D2D200D2D2D200D2D2D200D2D2
              D200CED3D600CED3D600CED3D600CED3D600CDD2D500D7DBDE00FFFFFE00B3B3
              B8003939A9002D2DE6003B3BE7003333EC004444D200C7C7D300E4E4EA00DCDC
              E800DCDCE800DDDDE900DCDCE800DBDBE800E3E3EB00D2D2D8005454D3003636
              F0004545F1003030EB0028289A00B0B0B700FFFFFF00D6DBDD00CDD2D500CED3
              D600CED3D600CED3D600CED3D600D2D2D200D2D2D200D2D2D200D2D2D200D1D1
              D100DADADA00FFFFFF00B5B5B5007171710089898900909090008F8F8F008B8B
              8B00CDCDCD00E6E6E600E1E1E100E1E1E100E2E2E200E1E1E100E1E1E100E7E7
              E700D5D5D50092929200929292009A9A9A008D8D8D0060606000B3B3B300FFFF
              FF00DADADA00D1D1D100D2D2D200D2D2D200D2D2D200D2D2D200CED3D600CED3
              D600CED3D600CED3D600CDD2D500D8DCDF00FFFFF3007777B7002222DA003A3A
              EB003D3DE8003333EE005656D400D6D6DD00E7E7EF00E0E0EC00E0E0EC00E0E0
              EC00E0E0EC00E0E0EC00E2E2EE00ECECE7009090D1003838EC004242F1004444
              F4002A2AE6007D7DC400FFFFF400D8DCDF00CDD2D500CED3D600CED3D600CED3
              D600CED3D600D2D2D200D2D2D200D2D2D200D2D2D200D1D1D100DCDCDC00F9F9
              F900969696007E7E7E0092929200929292008F8F8F0095959500DADADA00EBEB
              EB00E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E8E8E800EAEAEA00B0B0
              B000929292009A9A9A009B9B9B0087878700A0A0A000FBFBFB00DBDBDB00D1D1
              D100D2D2D200D2D2D200D2D2D200D2D2D200CED3D600CED3D600CED3D600CED3
              D600CDD2D500D8DDDF00FEFEF2007878BD002929DE003E3EED004141EC003838
              F3005959D700D8D8DF00EBEBF300E5E5F100E5E5F100E5E5F200E5E5F100E5E5
              F100E5E5F200F3F3F200BBBBD7004646E9004242F7004646F3003636EE008484
              D200FEFEF200D8DCDF00CDD2D500CED3D600CED3D600CED3D600CED3D600D2D2
              D200D2D2D200D2D2D200D2D2D200D1D1D100DCDCDC00F8F8F8009A9A9A008383
              830095959500969696009595950097979700DBDBDB00EFEFEF00EBEBEB00EBEB
              EB00EBEBEB00EBEBEB00EBEBEB00EBEBEB00F2F2F200C9C9C900979797009C9C
              9C009C9C9C0092929200ABABAB00F8F8F800DBDBDB00D1D1D100D2D2D200D2D2
              D200D2D2D200D2D2D200CED3D600CED3D600CED3D600CED3D600CDD2D500D8DD
              DF00FEFEF3007A7ABF002D2DE0004242F1004646F1003E3EF9005E5EDA00DBDB
              E300F4F4FC00EAEAF700EAEAF700EAEAF700E9E9F700EAEAF700E4E4F000F1F1
              F500DDDDE3005A5AE2004242FC004949FA003838F0008686D000FEFEF200D8DC
              DF00CDD2D500CED3D600CED3D600CED3D600CED3D600D2D2D200D2D2D200D2D2
              D200D2D2D200D1D1D100DCDCDC00F8F8F8009B9B9B00868686009A9A9A009C9C
              9C009B9B9B009C9C9C00DEDEDE00F7F7F700F0F0F000EFEFEF00F0F0F000EFEF
              EF00F0F0F000EAEAEA00F2F2F200DFDFDF009E9E9E009E9E9E00A1A1A1009494
              9400AAAAAA00F8F8F800DBDBDB00D1D1D100D2D2D200D2D2D200D2D2D200D2D2
              D200CED3D600CED3D600CED3D600CED3D600CDD2D500D8DDDF00FEFEF2007A7A
              C0003030E3004646F6004A4AF7004242FF006262DD00E3E3E900E8E8F000EBEB
              F800F4F4FF00F2F2FE00F3F3FE00F7F7FF00B5B5DE00BBBBE200FFFFF8008B8B
              D4004646F5004D4DFF003B3BF4008585D000FEFEF200D8DCDF00CDD2D500CED3
              D600CED3D600CED3D600CED3D600D2D2D200D2D2D200D2D2D200D2D2D200D1D1
              D100DCDCDC00F8F8F8009D9D9D008A8A8A009F9F9F00A1A1A100A1A1A100A0A0
              A000E6E6E600ECECEC00F1F1F100F8F8F800F6F6F600F7F7F700FAFAFA00C8C8
              C800CECECE00FFFFFF00AEAEAE009D9D9D00A6A6A60097979700ABABAB00F8F8
              F800DBDBDB00D1D1D100D2D2D200D2D2D200D2D2D200D2D2D200CED3D600CED3
              D600CED3D600CED3D600CDD2D500D8DDDF00FEFEF2007B7BC0003434E9004B4B
              FD005050FD004949FF006767E000EAEAEE00BDBDCE00E8E8F300F4F4FB00F5F5
              FC00F4F4F900FCFCFB00AFAFE6006C6CEA00F0F0F700E8E8E0005E5EEB004F4F
              FF004040F5008585D000FEFEF200D8DCDF00CDD2D500CED3D600CED3D600CED3
              D600CED3D600D2D2D200D2D2D200D2D2D200D2D2D200D1D1D100DCDCDC00F8F8
              F8009D9D9D008E8E8E00A3A3A300A7A7A700A5A5A500A2A2A200EBEBEB00C6C6
              C600EDEDED00F7F7F700F8F8F800F6F6F600FBFBFB00CACACA00AAAAAA00F5F5
              F500E4E4E400A3A3A300A8A8A8009B9B9B00ABABAB00F8F8F800DBDBDB00D1D1
              D100D2D2D200D2D2D200D2D2D200D2D2D200CED3D600CED3D600CED3D600CED3
              D600CDD2D500D8DDDF00FEFEF2007C7CC2003939ED005151FF005555FF005050
              FF006E6EE100EBEBEF00BCBCCD00EEEEF300C6C6D600E4E4E900CBCBD900EDED
              ED00C1C1E9005050F9007474F9009393F8006161FB005656FF004444F6008585
              D200FEFEF200D8DCDF00CDD2D500CED3D600CED3D600CED3D600CED3D600D2D2
              D200D2D2D200D2D2D200D2D2D200D1D1D100DCDCDC00F8F8F8009E9E9E009292
              9200A9A9A900ABABAB00A9A9A900A7A7A700EDEDED00C4C4C400F0F0F000CECE
              CE00E7E7E700D2D2D200EDEDED00D4D4D400A5A5A500B6B6B600C5C5C500AEAE
              AE00ABABAB009C9C9C00ABABAB00F8F8F800DBDBDB00D1D1D100D2D2D200D2D2
              D200D2D2D200D2D2D200CED3D600CED3D600CED3D600CED3D600CDD2D500D8DD
              DF00FDFDF1007C7CC2003E3EEE005757FF005C5CFF005757FF007676E000EDED
              EF00BEBEC600F0F0F300C0C0D100E1E1E700C4C4D800EDEDEE00C5C5E8006161
              F8006666FF005E5EFF006060FF005E5EFF004747F5008484D000FDFDF100D8DC
              DF00CDD2D500CED3D600CED3D600CED3D600CED3D600D2D2D200D2D2D200D2D2
              D200D2D2D200D1D1D100DCDCDC00F7F7F7009E9E9E0095959500ACACAC00AEAE
              AE00ACACAC00ABABAB00EEEEEE00C2C2C200F2F2F200C8C8C800E4E4E400CECE
              CE00EDEDED00D6D6D600ADADAD00B3B3B300AEAEAE00B0B0B000AFAFAF009E9E
              9E00AAAAAA00F7F7F700DBDBDB00D1D1D100D2D2D200D2D2D200D2D2D200D2D2
              D200CED3D600CED3D600CED3D600CED3D600CDD2D500D8DCDF00FFFFF4007979
              C7003F3FEE006060FF006363FF005F5FFF007B7BE300EDEDEE00C1C1CB00F0F0
              F300C4C4D600E4E4EA00C6C6D800EDEDEE00C6C6E8006B6BF8007474FF006D6D
              FF006868FF006464FF004949F5008484D400FFFFF400D8DCDE00CDD2D500CED3
              D600CED3D600CED3D600CED3D600D2D2D200D2D2D200D2D2D200D2D2D200D1D1
              D100DBDBDB00FAFAFA00A0A0A00097979700B1B1B100B1B1B100B0B0B000AEAE
              AE00EFEFEF00C6C6C600F2F2F200CCCCCC00E6E6E600CECECE00EDEDED00D6D6
              D600B1B1B100BABABA00B7B7B700B4B4B400B3B3B3009F9F9F00ACACAC00FAFA
              FA00DBDBDB00D1D1D100D2D2D200D2D2D200D2D2D200D2D2D200CED3D600CED3
              D600CED3D600CED3D600CDD2D500D3D7DA00FEFEF600B0B0DF003D3DE3005E5E
              FF006C6CFF006F6FFF007878F800B1B1F600A3A3DC00F3F3F200C4C4D600E3E3
              EA00C6C6D700EDEDEE00C8C8E7007575F8007D7DFF007676FF007070FF006767
              FF005252F100B7B7E700FAFBF200D2D7DA00CDD2D500CED3D600CED3D600CED3
              D600CED3D600D2D2D200D2D2D200D2D2D200D2D2D200D1D1D100D6D6D600FAFA
              FA00C7C7C7008F8F8F00AFAFAF00B5B5B500B7B7B700B7B7B700D3D3D300BFBF
              BF00F3F3F300CDCDCD00E6E6E600CECECE00EDEDED00D8D8D800B6B6B600BEBE
              BE00BABABA00B7B7B700B4B4B400A1A1A100CFCFCF00F6F6F600D6D6D600D1D1
              D100D2D2D200D2D2D200D2D2D200D2D2D200CED3D600CED3D600CED3D600CED3
              D600CED3D600CDD2D500D4D9DB00F5F7F200A5A5E1004545E6007171FF007A7A
              FF007F7FFF007B7BFF008E8EDC00F8F8F300C7C7D600E3E3E900C7C7D600EFEF
              EE00CDCDE7007F7FF8008686FF007F7FFF007878FF005C5CF500AFAEEB00F4F5
              F000D5D9DB00CDD2D500CED3D600CED3D600CED3D600CED3D600CED3D600D2D2
              D200D2D2D200D2D2D200D2D2D200D2D2D200D1D1D100D7D7D700F4F4F400C1C1
              C10095959500B9B9B900BDBDBD00C0C0C000BDBDBD00B4B4B400F6F6F600CECE
              CE00E7E7E700CECECE00EEEEEE00DADADA00BBBBBB00C2C2C200BFBFBF00BCBC
              BC00A8A8A800CCCCCC00F2F2F200D8D8D800D1D1D100D2D2D200D2D2D200D2D2
              D200D2D2D200D2D2D200CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CBD0D400D6DBDB00F5F7F2009E9EDF004F4FE8008484FF008A8AFF008D8D
              FF009898E900EBEBF000C6C6DE00E8E8ED00C8C8DE00E3E3EB00C9C9F1008989
              FC008E8EFF008989FF006464F500A7A7E800F5F6F100D6DADA00CBD0D400CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600D2D2D200D2D2D200D2D2
              D200D2D2D200D2D2D200D2D2D200CFCFCF00D8D8D800F3F3F300BFBFBF009B9B
              9B00C2C2C200C4C4C400C6C6C600C1C1C100EDEDED00D1D1D100EAEAEA00D3D3
              D300E6E6E600DDDDDD00C2C2C200C6C6C600C4C4C400ADADAD00C7C7C700F3F3
              F300D8D8D800CFCFCF00D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2
              D200CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CCD2
              D500D4D8DA00F4F4F300A0A0DF005959E8009393FF009B9BFF009D9DFF00A2A2
              FA00A6A6EB00ECECED00CECEF100A2A2F600A0A0FE009C9CFF009696FF006D6D
              F400A9A9E800F3F4F100D4D8DA00CCD2D500CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600D2D2D200D2D2D200D2D2D200D2D2D200D2D2
              D200D2D2D200D2D2D200D1D1D100D7D7D700F3F3F300BFBFBF00A1A1A100CACA
              CA00CECECE00CDCDCD00CECECE00C8C8C800ECECEC00DFDFDF00CBCBCB00CFCF
              CF00CECECE00CBCBCB00B0B0B000C8C8C800F2F2F200D6D6D600D1D1D100D2D2
              D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CDD3D600D4D9
              DB00F4F5F2009E9DE0006060E7009D9DFF00ADADFF00AFAFFF00B2B2FD00C0C0
              F700BCBCFD00B0B0FF00AFAFFF00A2A2FF007272F200A6A6E700F3F5F000D4D9
              DA00CDD3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2
              D200D2D2D200D2D2D200D7D7D700F2F2F200BEBEBE00A3A3A300CFCFCF00D7D7
              D700D8D8D800D8D8D800DBDBDB00DCDCDC00D8D8D800D8D8D800D2D2D200B2B2
              B200C6C6C600F1F1F100D7D7D700D2D2D200D2D2D200D2D2D200D2D2D200D2D2
              D200D2D2D200D2D2D200D2D2D200D2D2D200CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600CCD1D500D6DADB00F4F5
              F1009E9EE1006C6CE9008484F4008989F3008A8AF4008585F5008787F3008989
              F3008585F3007676EE00A7A7E800F2F3EF00D6DADB00CCD1D500CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600D2D2
              D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2
              D200D0D0D000D8D8D800F2F2F200BFBFBF00AAAAAA00BBBBBB00BDBDBD00BFBF
              BF00BDBDBD00BDBDBD00BEBEBE00BCBCBC00B2B2B200C8C8C800F1F1F100D8D8
              D800D0D0D000D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2
              D200D2D2D200D2D2D200CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CBD0D400D7DCDC00F1F3F200CFCE
              F000BFBEEC00C1C0EC00C1C1EC00C1C0ED00BFBFEC00BFBFEC00BEBDED00CECE
              F000F2F4F100D7DCDC00CBD0D400CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600D2D2D200D2D2D200D2D2
              D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200CFCF
              CF00D9D9D900F2F2F200DFDFDF00D6D6D600D6D6D600D7D7D700D6D6D600D5D5
              D500D6D6D600D5D5D500DFDFDF00F2F2F200D9D9D900CFCFCF00D2D2D200D2D2
              D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2
              D200CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600CDD2D500D3D8DA00DCE0DC00DADEDA00DADE
              DA00DADEDA00D9DEDA00DADEDA00DADEDA00DADEDA00DBDFDC00D3D8DA00CDD2
              D500CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600D2D2D200D2D2D200D2D2D200D2D2D200D2D2
              D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D1D1D100D6D6
              D600DDDDDD00DADADA00DADADA00DADADA00DADADA00DADADA00DADADA00DADA
              DA00DCDCDC00D7D7D700D1D1D100D2D2D200D2D2D200D2D2D200D2D2D200D2D2
              D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200D2D2D200}
            Layout = blGlyphTop
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ParentBiDiMode = False
            ShowHint = False
            Transparent = False
            OnClick = btnCloseClick
            ExplicitLeft = 1
            ExplicitTop = 1
            ExplicitWidth = 55
            ExplicitHeight = 55
          end
        end
        object Pnl_Btn0: TPanel
          Left = 0
          Top = 0
          Width = 61
          Height = 61
          Align = alRight
          BevelInner = bvRaised
          Color = 16250871
          TabOrder = 1
          object btnSave: TSpeedButton
            Tag = 2
            Left = 2
            Top = 2
            Width = 57
            Height = 57
            Cursor = crHandPoint
            ParentCustomHint = False
            Align = alClient
            BiDiMode = bdLeftToRight
            Caption = #51200' '#51109
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = #46027#50880
            Font.Style = []
            Glyph.Data = {
              761A0000424D761A000000000000360000002800000046000000180000000100
              200000000000401A0000120B0000120B00000000000000000000CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D700CED6DB00CAD3D800C8D1D600C9D3
              D800CAD1D400C9CED000C9CFD200C9CFD200C9CED100C9CED100C9CED100C9CE
              D100C9CED100C9CED100C9CED100C9D1D600C8D2D700C9D2D700C9D2D700C8D1
              D600C8D1D600CAD3D700CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600D0D5
              D800CDD2D400CCD0D200CDD1D400CCD0D300C9CDD000CACED100CACED100CACE
              D100CACED000CACED000CACED100CACED100CACED100CACED100CCD0D200CCD0
              D300CDD1D400CCD1D300CCD0D300CCD0D300CDD1D400CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600CFD4D700C9C0BD00B1988F00AB938A00AD938A00A79B9700A7A9
              A900A6ACB000A4ACB200A6A8AB00A6A5A500A5A5A600A4A5A500A5A5A500A5A5
              A600A4A3A400A8948D00A9908600A8928800AC958C00AC958C00AC938900A899
              9200BFC2C400CFD5D800CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CFD4D700C1C4C500A09FA0009A99
              99009B9A9A009E9E9E00A8A7A700AAAAAA00AAAAAA00A8A8A800A5A5A500A5A5
              A500A5A5A400A4A4A400A4A4A400A4A3A3009A9A9A0097969600989898009C9C
              9C009C9C9C009B9A9A009D9D9C00BEC2C400CFD5D800CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED5D900CEC9
              C700CB734C00D16B3800D9784400CD5B2500B57F6800C3CBCF00C2A99A00BC99
              8200BAAFA900C0C0C000BDBBB900BBB9B900B9B7B700B9B8B800B2AEAC00CB78
              4B00D5683300BF562B00C7613200D8774200D9713B00BB623900B6A9A400CED6
              DB00CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600D0D5D800C7CBCE008C8B8B00858585008E8E8E00797979008E8E
              8E00C8C8C800AEAEAE009E9E9E00B1B1B100C0C0C000BCBCBC00BABABA00B7B7
              B700B8B8B800AEAEAE008B8B8B0084848400747474007D7D7D008C8C8C008A8A
              8A007A7A7A00ACADAF00D0D5D800CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED6DA00CDC3BF00D3653300EC87
              4A00F5995900E26D2D00C38F7600D4DFE400DD936300E0783400CCAB9400D4DC
              E200D3D2D200CFD1D100CCCECE00CBCECF00C0C0BE00DB905B00ED854500D162
              3000DB713A00F3955500F6914F00D4713F00BEA9A100CDD6DB00CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600D0D5
              D800C3C7C900838382009B9B9B00A7A7A700888888009D9D9D00DCDCDC00A0A0
              A0008A8A8A00B0B0B000DBDBDB00D3D3D300D1D1D100CDCDCD00CDCDCD00BFBF
              BF009B9B9B0098989800808080008A8A8A00A4A4A400A3A3A30089898900AEAF
              AF00D0D5D800CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED6DA00CDC4C100D36F3E00E8894E00F1995B00DE6F
              3100C4907900D6DFE300D38F6000DB783400CCAA9200D8E0E600D5D5D400D2D2
              D200D1D1D100CFD0D000C3C0BF00CF8B5B00D87E4300C25F2F00D8733D00F096
              5800F1915200D0744400BCA9A200CDD6DB00CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600D0D5D800C4C8CB008888
              88009B9B9B00A6A6A600878787009E9E9E00DCDCDC009999990087878700AEAE
              AE00DEDEDE00D5D5D500D2D2D200D1D1D100CFCFCF00C1C1C100959595008D8D
              8D00787878008B8B8B00A3A3A300A1A1A1008A8A8900AEAFB000D0D5D800CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED6DA00CDC4C100D36D3D00E8884D00F3995A00D66A2C00C1907A00E0E9
              ED00D5926600D9793900D1AF9A00E3E9EF00DFDEDE00DBDCDC00D8D8D800D7D8
              DA00CAC7C500D28C5C00D87C4200B95A2C00CC6C3800EF945600F2915200D074
              4300BCA9A200CDD6DB00CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600D0D5D800C4C8CB00888888009A9A9A00A6A6
              A600808080009D9D9D00E6E6E6009D9D9D0089898900B5B5B500E8E8E800DEDE
              DE00DCDCDC00D8D8D800D8D8D800C7C7C700969696008D8D8D00737373008282
              8200A2A2A200A2A2A2008A898900AEAFB000D0D5D800CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED6DA00CDC4
              C100D36D3D00EA894D00EE965900C7612900C3957E00E6EFEC00D3895600D76C
              2400D1AC9300ECF3F800E8E7E500E5E4E400E1E0E000E0E1E200D2CFCD00D28F
              5D00DA7E4300BD5C2F00C3673500E38E5200F2925200D1744300BBA9A200CDD6
              DB00CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600D0D5D800C4C8CB00888888009B9B9B00A2A2A20078787800A1A1
              A100E9E9E900959595007D7D7D00B2B2B200F2F2F200E6E6E600E4E4E400E0E0
              E000E0E0E000CFCFCF00979797008E8E8E00767676007C7C7C009A9A9A00A2A2
              A2008A8A8A00AEAEB000D0D5D800CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED6DA00CDC4C100D46E3E00E988
              4B00E18F5500C6602800C4917A00F4FDFC00DAB59800D2956B00DFD1C500FBFF
              FF00F4FDFF00F2FAFE00EEF7FB00EEF9FE00DADFE100D28B5900D6783E00BA57
              2B00C66A3800DA894F00EB8E4F00D1754400BCA9A200CDD6DB00CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600D0D5
              D800C4C8CB00888888009A9A9A009A9A9A00777777009F9F9F00FAFAFA00B8B8
              B8009E9E9E00D1D1D100FFFFFF00FAFAFA00F8F8F800F4F4F400F6F6F600DDDD
              DD00959595008A8A8A00727272007F7F7F00939393009D9D9D008B8B8B00AEAE
              B000D0D5D800CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED6DA00CDC4C200D56E3D00E2844900DA8A5100D377
              3C00BC694000C89F8E00C9A99B00C2A09000C8A69700CDA89600CCA99700CCA8
              9700C9A69400C6A69800BE8D7600C05F3100BE572800B9552600D1784200D988
              4F00E2884C00D0744400BCAAA200CDD6DB00CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600D0D5D800C4C8CB008989
              89009595950096969600878787007E7E7E00ABABAB00B1B1B100A9A9A900AFAF
              AF00B1B1B100B1B1B100B1B1B100AFAFAF00AFAFAF009A9A9A00777777007272
              7200707070008A8A8A0093939300969696008A8A8900AEAFB000D0D5D800CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED6DA00CEC5C200D56E3D00DC814800D8884E00D4794100C65D2900B849
              1800B84A1B00B84D1E00BA491A00BE4A1800C04B1900C04B1900C04B1900BB49
              1800B8481800BA4C1E00B94F2100C45E2B00D4773F00D8874F00DD854A00CD73
              4200BDABA300CDD6DB00CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600D0D5D800C4C8CB0089898900919191009393
              93008A8A8A0077777700676767006A6A6A006B6B6B00696969006A6A6A006C6C
              6C006C6C6C006C6C6C0069696900686868006B6B6B006D6D6D00777777008989
              8900939393009393930088878700AFB0B000D0D5D800CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED6DA00CEC5
              C200D36D3E00D77F4600D47A3E00C7805D00CAAFA100D1B3A300D0B1A100D0B1
              A100D0B1A100D1B1A100D0B0A100D0B0A100D0B0A100D1B1A100D0B1A200D0B1
              A100D0B3A400C9AEA200C77F5B00D5773D00DC864B00C9704200BCAAA300CDD6
              DB00CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600D0D5D800C5C9CB00888888008E8E8E008989890091919100B4B4
              B400BABABA00B8B8B800B8B8B800B8B8B800B9B9B900B9B9B900B9B9B900B8B8
              B800B9B9B900B8B8B800B8B8B800BABABA00B5B5B50091919100888888009393
              930086868500AFB0B100D0D5D800CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED6DA00CEC5C200D16E3D00D77C
              4200CE6B3000C6A79900EEFFFF00FCFFFF00FAFFFF00FAFFFF00F9FFFF00F9FF
              FF00F9FFFF00F9FFFF00F9FFFF00F9FFFF00F9FFFF00F9FFFF00FBFFFF00EDFF
              FF00C6A59500CD692E00DC864A00C6704200BCAAA300CDD6DB00CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600D0D5
              D800C5C9CB00878787008C8C8C007E7E7E00B0B0B000FAFAFA00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FDFDFD00AEAEAE007D7D7D009393930084848400AEAF
              B000D0D5D800CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED6DA00CEC5C200CF6D3C00D67C4200CC683100CCA9
              9800FAFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00CBA49300CB67
              2E00DD854A00C66F4100BCAAA200CDD6DB00CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600D0D5D800C4C9CB008686
              85008C8C8C007E7E7E00B2B2B200FCFCFC00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FDFDFD00AEAEAE007C7C7C009393930083838300AEAFB000D0D5D800CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED6DA00CEC5C200D06D3D00D67C4200CC683100CCA79700F7FEFF00F8F6
              F600F2F2F200F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3
              F300F3F3F300F2F2F100F7F7F600F7FFFF00CBA29100CB672E00DD854A00C670
              4100BCAAA200CDD6DB00CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600D0D5D800C5C9CB00878787008C8C8C007E7E
              7E00B1B1B100FBFBFB00F7F7F700F2F2F200F3F3F300F3F3F300F3F3F300F3F3
              F300F3F3F300F3F3F300F3F3F300F3F3F300F1F1F100F6F6F600FDFDFD00ADAD
              AD007C7C7C009494940083838300AEAFB000D0D5D800CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED6DA00CEC5
              C200D26E3F00D77C4300CC683000CCA79700F7FEFF00FCFBFB00FAFAFA00FAFA
              FA00FAFAFA00FAFAFA00FAFAFA00FAFAFA00FAFAFA00FAFAFA00FAFAFA00FAFA
              F900FDFCFB00F6FFFF00CBA29100CB672E00DD864A00C8714200BCAAA300CDD6
              DB00CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600D0D5D800C5C9CC00888888008C8C8C007E7E7E00B1B1B100FBFB
              FB00FCFCFC00FAFAFA00FAFAFA00FAFAFA00FAFAFA00FAFAFA00FAFAFA00FAFA
              FA00FAFAFA00FAFAFA00F9F9F900FCFCFC00FDFDFD00ADADAD007C7C7C009393
              930085848400AFB0B000D0D5D800CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED6DA00CEC5C200D46F3F00D97E
              4400CB683000CCA79700F6FFFF00FEFEFE00FDFDFD00FDFDFD00FDFDFD00FDFD
              FD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FFFFFE00F5FF
              FF00CBA29100CA662E00DE864A00CB734300BDABA300CDD6DB00CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600D0D5
              D800C4C8CB00898989008E8E8E007D7D7D00B1B1B100FAFAFA00FEFEFE00FCFC
              FC00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFD
              FD00FCFCFC00FEFEFE00FDFDFD00ACACAC007C7C7C009494940087878700AFB0
              B100D0D5D800CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED6DA00CDC4C100D5703F00E0814500CC693100CCA7
              9700F7FEFF00F8F7F700F2F2F200F3F3F300F3F3F300F3F3F300F3F3F300F3F3
              F300F3F3F300F3F3F300F3F3F300F2F2F200F7F7F700F6FFFF00CBA39100CA66
              2E00E0874B00CF744400BCA9A200CDD6DB00CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600D0D5D800C4C8CB008A8A
              8A00929292007D7D7D00B1B1B100FBFBFB00F7F7F700F1F1F100F2F2F200F2F2
              F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F1F1F100F7F7
              F700FEFEFE00ADADAD007B7B7B009595950089898900AEAFB000D0D5D800CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED6DA00CDC4C100D5703F00E7854800CE6A3100CBA69600F6FFFF00FEFE
              FE00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
              FB00FBFBFB00FBFBFB00FFFDFD00F6FFFF00CAA39100C9652D00E98C4E00D276
              4500BBA9A200CDD6DB00CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600D0D5D800C4C8CB008A898900979797007F7F
              7F00B0B0B000FBFBFB00FDFDFD00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
              FB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FDFDFD00FDFDFD00ACAC
              AC007B7B7B009B9B9B008B8B8B00AEAEB000D0D5D800CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED6DA00CDC4
              C100D46F3F00EB894B00D9703500CBA69600F6FEFF00FCFCFC00FAFAFA00FBFB
              FB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFA
              FA00FEFCFC00F6FFFF00C9A29100CE682F00F2905000D2754500BBA9A200CDD6
              DB00CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600D0D5D800C4C8CB00898989009B9B9B0087878700B0B0B000FAFA
              FA00FCFCFC00FAFAFA00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
              FB00FBFBFB00FBFBFB00FAFAFA00FDFDFD00FEFEFE00ACACAC007E7E7E00A1A1
              A1008B8B8B00AEAEB000D0D5D800CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED6DA00CDC4C200D56F3F00EA80
              4100DE6C2E00CDA79700F7FEFF00F8F7F700F1F1F100F2F2F200F2F2F200F2F2
              F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F1F1F100F8F7F600F5FF
              FF00C8A19100DB723500FC9B5700D3774500BBA8A200CDD6DB00CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600D0D5
              D800C4C8CB008A8A8A009595950084848400B1B1B100FBFBFB00F7F7F700F1F1
              F100F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2
              F200F1F1F100F7F7F700FDFDFD00ADADAD0089898900A9A9A9008C8C8C00AEAE
              AF00D0D5D800CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED6DA00CEC4C000CA633600CC795700CA684100CDA4
              9200F7FFFF00FFFFFF00FFFEFE00FFFEFE00FFFEFE00FFFEFE00FFFEFE00FFFE
              FE00FFFEFE00FFFEFE00FFFEFE00FFFEFE00FFFFFF00F5FFFF00CEA59200CD61
              2B00D6743E00CB704100BEACA400CDD6DB00CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600D0D5D800C4C8CB008080
              80009191910084848400AFAFAF00FBFBFB00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FBFBFB00AEAEAE007C7C7C008B8B8B0086868600B0B1B100D0D5D800CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED6DB00D1C2BB00BD542C00A5969A00B5827700CBA59400F5FFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00F3FFFF00D2B19D00B6481B00A43C1A00BE62
              3700C1AFA500CDD6DB00CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600D0D5D800C3C7CA00747474009F9F9F009595
              9500B0B0B000FDFDFD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
              FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00B8B8
              B800686868005F5F5F007A7A7A00B2B3B400D0D5D800CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED6DA00CFC6
              C200C75E3300B65E3F00BE5C3500C58F7900D2C9C100DAC6BB00D8C6BC00D8C6
              BB00D8C6BB00D8C6BB00D8C6BB00D8C6BB00D8C6BB00D8C6BB00D8C6BB00D8C6
              BB00DAC6BC00D1C7C200C5917900CE5E2800CD612F00C6643900C1AFA900CED7
              DC00CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600D0D5D800C5C9CC007D7D7D007A7A7A00797979009F9F9F00C8C8
              C800CACACA00CACACA00CACACA00CACACA00CACACA00CACACA00CACACA00CACA
              CA00CACACA00CACACA00CACACA00CBCBCB00C9C9C9009F9F9F007B7B7B007D7D
              7D007F7F7F00B4B5B600D1D6D900CED3D600CED3D600CED3D600CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED4D700CED2D300D1A28B00D171
              4700CF704700C9755100C6765300C6745000C6745100C6745000C6745000C674
              5000C6745000C6745000C6745000C6745000C6745000C6745000C6755000C675
              5200C9745000D17A5100D5784C00CC907500CCCBCB00CED5D900CED3D600CED3
              D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CED3D600CFD4
              D700CDD2D400AEAEAD008C8C8C008B8B8B008C8C8C008C8C8C008B8B8B008B8B
              8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B8B008B8B
              8B008B8B8B008B8B8B008C8C8C008D8D8D009191910091919100A0A0A000C9CB
              CD00D0D5D800CED3D600CED3D600CED3D600CED3D600CED3D600}
            Layout = blGlyphTop
            NumGlyphs = 2
            ParentFont = False
            ParentShowHint = False
            ParentBiDiMode = False
            ShowHint = False
            Transparent = False
            OnClick = btnSaveClick
            ExplicitLeft = -2
            ExplicitTop = -4
          end
        end
      end
      object PnlFormName: TPanel
        Left = 2
        Top = 2
        Width = 245
        Height = 61
        Align = alClient
        BevelInner = bvRaised
        Caption = #49472' '#49688#51221
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = #46027#50880
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
        object Shape3: TShape
          Left = 2
          Top = 2
          Width = 241
          Height = 57
          Align = alClient
          Brush.Style = bsClear
          Pen.Color = clGray
          Shape = stRoundRect
          ExplicitLeft = 4
          ExplicitTop = 4
          ExplicitWidth = 292
          ExplicitHeight = 53
        end
      end
    end
    object Panel24: TPanel
      Left = 371
      Top = 67
      Width = 2
      Height = 481
      Align = alRight
      BevelOuter = bvNone
      Color = 14211288
      ParentBackground = False
      TabOrder = 2
      ExplicitHeight = 452
    end
    object Panel13: TPanel
      Left = 2
      Top = 67
      Width = 2
      Height = 481
      Align = alLeft
      BevelOuter = bvNone
      Color = 14211288
      ParentBackground = False
      TabOrder = 3
      ExplicitHeight = 452
    end
    object Panel14: TPanel
      Left = 2
      Top = 548
      Width = 371
      Height = 2
      Align = alBottom
      BevelOuter = bvNone
      Color = 14211288
      ParentBackground = False
      TabOrder = 4
      ExplicitTop = 519
    end
  end
  object qryUpdate: TADOQuery
    Connection = MainDm.MainDB
    CursorType = ctStatic
    Parameters = <>
    Left = 16
    Top = 14
  end
end
