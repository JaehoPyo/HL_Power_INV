object MainDm: TMainDm
  OldCreateOrder = False
  Height = 247
  Width = 272
  object MainDB: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    AfterConnect = MainDBAfterConnect
    AfterDisconnect = MainDBAfterDisconnect
    Left = 12
    Top = 136
  end
  object qryTemp: TADOQuery
    Connection = MainDB
    Parameters = <>
    Left = 12
    Top = 88
  end
  object SaveDlg: TSaveDialog
    Left = 52
    Top = 16
  end
  object qryCommand: TADOQuery
    Connection = MainDB
    Parameters = <>
    Left = 92
    Top = 16
  end
  object qryInfo: TADOQuery
    Connection = MainDB
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    EnableBCD = False
    Parameters = <
      item
        Name = 'cBR'
        DataType = ftString
        Size = 6
        Value = 'asdasd'
      end
      item
        Name = 'cID'
        DataType = ftString
        Size = 9
        Value = 'asdasdasd'
      end
      item
        Name = 'cLO'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT   A.CO_CODE    AS CO_CODE  ,  '
      '              A.ID_DESC      AS US_DESC    , '
      '              A.ID_PSWD AS ID_PSWD   , '
      '              A.ID_LEVEL     AS ID_LEVEL    ,'
      '              B.ID_DESC      AS BR_DESC    , '
      '              C.ID_DESC     AS  LO_DESC     '
      '  FROM EMP_INFO  A , BRAN_INFO B  , LOCA_INFO C '
      'WHERE A.BR_CODE  = :cBR and A.ID_CODE = :cID AND '
      '           A.BR_CODE = B.ID_CODE  AND '
      '           B.ID_CODE = C.BR_CODE AND  C.ID_CODE = :cLO')
    Left = 193
    Top = 16
  end
  object qrySearch: TADOQuery
    Connection = MainDB
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    EnableBCD = False
    Parameters = <
      item
        Name = 'cBR'
        DataType = ftString
        Size = 6
        Value = 'asdasd'
      end
      item
        Name = 'cID'
        DataType = ftString
        Size = 9
        Value = 'asdasdasd'
      end
      item
        Name = 'cLO'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT   A.CO_CODE    AS CO_CODE  ,  '
      '              A.ID_DESC      AS US_DESC    , '
      '              A.ID_PSWD AS ID_PSWD   , '
      '              A.ID_LEVEL     AS ID_LEVEL    ,'
      '              B.ID_DESC      AS BR_DESC    , '
      '              C.ID_DESC     AS  LO_DESC     '
      '  FROM EMP_INFO  A , BRAN_INFO B  , LOCA_INFO C '
      'WHERE A.BR_CODE  = :cBR and A.ID_CODE = :cID AND '
      '           A.BR_CODE = B.ID_CODE  AND '
      '           B.ID_CODE = C.BR_CODE AND  C.ID_CODE = :cLO')
    Left = 193
    Top = 64
  end
  object PD_INS_PGM_HIST: TADOStoredProc
    ProcedureName = 'PD_INS_PGM_HIST'
    Parameters = <
      item
        Name = 'I_MENU_ID'
        Attributes = [paNullable]
        DataType = ftString
        Size = 4000
        Value = Null
      end
      item
        Name = 'I_HIST_TYPE'
        Attributes = [paNullable]
        DataType = ftString
        Size = 4000
        Value = Null
      end
      item
        Name = 'I_PGM_FUNCTION'
        Attributes = [paNullable]
        DataType = ftString
        Size = 4000
        Value = Null
      end
      item
        Name = 'I_EVENT_NAME'
        Attributes = [paNullable]
        DataType = ftString
        Size = 4000
        Value = Null
      end
      item
        Name = 'I_EVENT_DESC'
        Attributes = [paNullable]
        DataType = ftString
        Size = 4000
        Value = Null
      end
      item
        Name = 'I_COMMAND_TYPE'
        Attributes = [paNullable]
        DataType = ftString
        Size = 4000
        Value = Null
      end
      item
        Name = 'I_COMMAND_TEXT'
        Attributes = [paNullable]
        DataType = ftString
        Size = 4000
        Value = Null
      end
      item
        Name = 'I_PARAM'
        Attributes = [paNullable]
        DataType = ftString
        Size = 4000
        Value = Null
      end
      item
        Name = 'I_ERROR_MSG'
        Attributes = [paNullable]
        DataType = ftString
        Size = 4000
        Value = Null
      end
      item
        Name = 'I_USER_ID'
        Attributes = [paNullable]
        DataType = ftString
        Size = 4000
        Value = Null
      end
      item
        Name = 'O_ERR_CD'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdOutput
        Size = 4000
        Value = Null
      end
      item
        Name = 'O_ERR_MSG'
        Attributes = [paNullable]
        DataType = ftString
        Direction = pdOutput
        Size = 4000
        Value = Null
      end>
    Left = 184
    Top = 176
  end
end
