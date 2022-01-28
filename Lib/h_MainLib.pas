unit h_MainLib;

interface

uses inifiles,Windows, Sysutils, ExtCtrls, ADODB, ScktComp, Graphics ;

Const
  LogFileName  : String = '.\Log\Monitoring.Log';
  INI_PATH : String = 'AwHouse.INI';

  CONN_STATUS_COLOR : Array [0..1] of TColor = ($008484FF, $0068FF68);
  BTN_FONT_COLOR : Array [1..2] of TColor = (clBlack, $008B8B8B);

  // �ϼ�ǰ -------------------------
  START_SCNO   = 1 ; // Start SC No
  End_SCNO     = 1 ; // End SC No

  START_CVNO   = 1 ; // Start CV No
  End_CVNO     = 2 ; // End CV No

  START_BCRNO  = 1 ; // Start BCR No
  End_BCRNO    = 4 ; // End BCR No

  START_ITNO_P = 1 ; // Start Interface No
  End_ITNO_P   = 1 ; // End Interface No
  //---------------------------------


  SiteCH117 = 31; //Site ä��
  SiteCH118 = 33; //42; //Site ä��
  SiteCH119 = 34; //43; //Site ä��

  inReady117  = 1;
  inReady118  = 2;
  inReady119  = 3;

  OutReady100 = 4;
  OutReady101 = 5;
  OutReady200 = 6;
  OutReady201 = 7;
  OutReady109 = 8;



  MenuCount  = 7 ; // ����ȭ���� �޴� ��

  //========================================================================
  // ������ ���� ��ư Tag��
  //========================================================================
  MSG_MDI_WIN_ORDER   = 11 ; // ����
  MSG_MDI_WIN_ADD     = 12 ; // �ű�
  MSG_MDI_WIN_DELETE  = 13 ; // ����
  MSG_MDI_WIN_UPDATE  = 14 ; // ����
  MSG_MDI_WIN_EXCEL   = 15 ; // ����
  MSG_MDI_WIN_PRINT   = 16 ; // �μ�
  MSG_MDI_WIN_QUERY   = 17 ; // ��ȸ
  MSG_MDI_WIN_CLOSE   = 20 ; // �ݱ�
  MSG_MDI_WIN_LANG    = 21 ; // ���

  //�޴�ID
  PGMID      : Array[1..25] of String=('100','110','120','200','210','220','300','310','320',
                                       '400','410','420','430','440','450','460','470',
                                       '500','510','520','600','610','700','710','720' );


  // Display Ref Arry
  LANG_BColor : Array[0..1] of TColor = ( clWhite,  $00FF3C3C );  // Language Button Base Color (�̼���, ����)
  LANG_FColor : Array[0..1] of TColor = ( $00828282,  clWhite );  // Language Button Font Color (�̼���, ����)

  Btn_BColor  : Array[0..1] of TColor = ( $00F7F7F7, $00FF3C3C) ; // Button Click Base Color (��Ŭ��, Ŭ��)
  Btn_FColor  : Array[0..1] of TColor = ( $004D4D4D,  clWhite ) ; // Button Click Font Color (��Ŭ��, Ŭ��)

  Add_No      : Array[1..2] of integer = ( 100, 210 );


  BCR_Def     : Array[1..3] of integer = ( 100, 151, 260 );
  Add_No_P    : Array[1..3] of integer = ( 100, 151, 210 );

  STOPER_DEF  : Array[1..4] of integer = ( 211, 221, 231, 241 ) ;

  BUFF_IDX   : Array[1..45] of integer =  // ȭ�� ���� Bit�� index
       (100, 101, 102, 110, 111, 112, 113, 120, 121, 122,
        123, 130, 131, 132, 133, 140, 141, 142, 143, 150,
        151, 152, 210, 211, 212, 213, 214, 215, 220, 221,
        222, 223, 230, 231, 232, 233, 240, 241, 242, 243,
        260, 261, 262, 263, 264 );

  OFF_BUFF_IDX : Array[1..35] of integer =// Off Line
       ( 10,  20,  21,  30,  40,  41,  50,  51,  52,  53,
        310, 320, 330, 340,   0, 400, 401,   0, 420, 430,
        440, 450, 460, 470, 471, 472, 480, 481, 490, 500,
        501, 510, 520, 521, 530) ;

  FULL_BUFF_IDX : Array[1..35] of integer =// Off Line
       ( 10,  20,   0,  30,  40,  41,  50,   0,   0,   0,
        310, 320, 330, 340, 152, 400,   0,   0, 420, 430,
        440, 450, 460, 470,   0,   0, 480,   0, 490, 500,
          0, 510, 520,   0, 530) ;

  CargoIndex : Array[1..45, 1..2] of integer =  // ȭ�� ���� Bit�� index
       (( 1,13), ( 1,14), ( 1,15), ( 2, 0), ( 2, 1), ( 2, 2), ( 2, 3), ( 2, 4), ( 2, 5), ( 2, 6),
        ( 2, 7), ( 2, 8), ( 2, 9), ( 2,10), ( 2,11), ( 2,12), ( 2,13), ( 2,14), ( 2,15), ( 3, 0),
        ( 3, 1), ( 3, 2), ( 8, 1), ( 8, 2), ( 8, 3), ( 8, 4), ( 8, 5), ( 8, 6), ( 8, 7), ( 8, 8),
        ( 8, 9), ( 8,10), ( 8,11), ( 8,12), ( 8,13), ( 8,14), ( 8,15), ( 9, 0), ( 9, 1), ( 9, 2),
        ( 9, 6), ( 9, 7), ( 9, 8), ( 9, 9), ( 9,10) );

  ErrorIndex : Array[1..45, 1..2] of integer =  // ȭ�� ���� Bit�� index
       (( 5, 9), ( 5,10), ( 5,11), ( 5,12), ( 5,13), ( 5,14), ( 5,15), ( 6, 0), ( 6, 1), ( 6, 2),
        ( 6, 3), ( 6, 4), ( 6, 5), ( 6, 6), ( 6, 7), ( 6, 8), ( 6, 9), ( 6,10), ( 6,11), ( 6,12),
        ( 6,13), ( 6,14), (11,13), (11,14), (11,15), (12, 0), (12, 1), (12, 2), (12, 3), (12, 4),
        (12, 5), (12, 6), (12, 7), (12, 8), (12, 9), (12,10), (12,11), (12,13), (12,14), (13, 2),
        (13, 3), (13, 4), (13, 5), (13, 6), (13, 7) ) ;




  // RGV Status Display Ref Arry
  Auto_Text   : Array[0..1] of String = ( '����', '�ڵ�');    // Auto Mode Caption Text
  Auto_BColor : Array[0..1] of TColor = ( clYellow, clLime);  // Auto Mode Base Color
  Auto_FColor : Array[0..1] of TColor = ( clBlack, clBlack);  // Auto Mode Font Color

  EMG_Text   : Array[0..1] of String = ( '����', '���');     // Emergency S/W Status Caption Text
  EMG_BColor : Array[0..1] of TColor = ( clLime, clRed   );   // Emergency S/W  Status Base Color
  EMG_FColor : Array[0..1] of TColor = ( clBlack, clWhite);   // Emergency S/W  Status Font Color

  Error_Text   : Array[0..1] of String = ( '����', '����');   // Auto Mode Caption Text
  Error_BColor : Array[0..1] of TColor = ( clLime, clRed  );  // Error Status Base Color
  Error_FColor : Array[0..1] of TColor = ( clBlack, clWhite); // Error Status Font Color
  Error_LColor : Array[0..1] of TColor = ( clActiveCaption, clRed  );  // Error Status Lamp Color

  Move_Text   : Array[0..1] of String = ( '�����', '�۾���');// Working Mode Caption Text
  Move_BColor : Array[0..1] of TColor = ( clYellow, clLime ); // Working Status Base Color
  Move_FColor : Array[0..1] of TColor = ( clBlack, clBlack ); // Working Status Font Color

  Pwr_Text   : Array[0..1] of String = ( 'OFF', 'ON');        // Power Bit Status Caption Text
  Pwr_BColor : Array[0..1] of TColor = ( clYellow, clLime );  // Power Bit Status Base Color
  Pwr_FColor : Array[0..1] of TColor = ( clBlack, clBlack   );// Power Bit Status Font Color

  CrgAndData_Text   : Array[0..3] of String = ( 'ȭ��(O) ������(O)', 'ȭ��(O) ������(X)', 'ȭ��(X) ������(O)', 'ȭ��(X) ������(X)'  );// RGV Gargo Exist Status Base Color
  Crg_Text   : Array[0..1] of String = ( 'ȭ��(X)', 'ȭ��(O)' );// RGV Gargo Exist Status Base Color
  Crg_BColor : Array[0..1] of TColor = ( clWhite, $00C08000 );// RGV Gargo Exist Status Base Color
  Crg_FColor : Array[0..1] of TColor = ( clBlack, clWhite );// RGV Gargo Exist Status Base Color
  Brk_BColor : Array[0..1] of TColor = ( clWhite, clYellow ); // RGV Gargo Break Status Base Color

  Comm_Text   : Array[0..1] of String = ( '����', '�̻�');    // RCT ��RCC ��� Mode Caption Text
  Comm_BColor : Array[0..1] of TColor = ( clLime  , clRed   );// RCT ��RCC ��� Mode Base Color
  Comm_FColor : Array[0..1] of TColor = ( clBlack , clWhite );// RCT ��RCC ��� Mode Font Color

  Rail_Text   : Array[0..1] of String = ( 'Ż��', '����');    // ������ ���� Mode Caption Text
  Rail_BColor : Array[0..1] of TColor = ( clRed   , clLime  );// ������ ���� Mode Base Color
  Rail_FColor : Array[0..1] of TColor = ( clWhite , clBlack );// ������ ���� Mode Font Color

  OX_Text     : Array[0..1] of String = ( ' X', ' O');          // ��Ÿ O, X ���� Caption Text
  OX_BColor1  : Array[0..1] of TColor = ( clWhite, clLime);   // ��Ÿ O, X ���� Mode Base Color
  OX_BColor2  : Array[0..1] of TColor = ( clWhite, clRed);    // ��Ÿ O, X ���� Mode Base Color
  OX_FColor   : Array[0..1] of TColor = ( clBlack, clWhite);  // ��Ÿ O, X ���� Mode Font Color

  SC_ForkStatus : Array[0..5] of String
            = ( '��ũ�߽�', '���� ��', '�³�', '���� ��', '�쳡', '�˼�����' ) ;

  RGV_A_Ack_Status : Array[0..9] of String
            = ( 'U-message�� ���� ���ο� �۾��� ���� ��ϵǾ���' ,
                '��� �� RTC�� ���� ������ �۾��� ���� �Ϸ�Ǿ���',
                '��ϵ� �۾��� �����ϴ� �۾��� ������ �߻��Ͽ���',
                'U-message�� ���� �۾��� �����Ǿ���',
                '�۾��� ��⵿ �Ǿ���',
                '���õ� ��ü�� Ʋ��, �̹� �Ϸ��',
                '�۾� ���� Full',
                '������� Lugg number�� ���',
                '�۾������ �� �� ÷�ε� Data�� �̻��� ����',
                '�۾��� ���ų� �������� �ƴϾ �۾��� ��⵿ �� �� ����' ) ;

  // RGV Phase Msg
  RGVPhase : Array[0..31, 1..2] of String
            = ( ('00', '�۾����� �����'),
                ('01', '������'),
                ('02', '������'),
                ('03', '������'),
                ('04', '������'),
                ('05', '������'),
                ('06', '������'),
                ('07', '������'),
                ('08', '������'),
                ('09', '������'),
                ('0A', '������'),
                ('0B', '������'),
                ('0C', 'Home�̵���'),
                ('0D', 'Home�̵��Ϸ�'),
                ('0E', '������'),
                ('0F', '������'),
                ('10', '�԰�� �̵��� ȭ�������� �۾��Ϸ�'),
                // ('10', '�԰��� �̵��� Conveyor���� ȭ���˻��Ͽ� ������ �۾� �Ϸ�'),
                ('11', '�԰��� �̵�'),
                ('12', '�԰�� �˻�'),
                ('13', 'Loading �۾�'),
                ('14', '�۾��� ȭ���˻�'),
                ('15', '������'),
                ('16', '������'),
                ('17', '�԰�� �۾��Ϸ�'),
                ('18', '���� �̵��� ȭ�������� �۾��Ϸ�'),
                // ('18', '���� �̵��� Conveyor�� ȭ���˻��Ͽ� ������ �۾� �Ϸ�'),
                ('19', '����� �̵�'),
                ('1A', '���� �˻�'),
                ('1B', 'Unloading �۾�'),
                ('1C', '�۾��� ȭ���˻�'),
                ('1D', '������'),
                ('1E', '������'),
                ('1F', '�̵��۾� �Ϸ�')
              ) ;


  // SC Phase Msg
  SCPhase : Array[1..21, 1..2] of String
            = (
               ('00','�����'),
               ('01','Ȩ�̵�'),
               ('02','�԰��� �̵�'),
               ('03','����� �̵�'),
               ('04','������ �̵�'),
               ('11','�԰��� �̵�'),
               ('12','�԰�� ���ͷ� �˻�'),
               ('13','�԰�� �ε���'),
               ('14','�ε� �� ȭ�� �˻�'),
               ('21','��ε� ���� ������ �̵�'),
               ('22','��ε� �� �����԰� �˻�'),
               ('23','���� ��ε���'),
               ('24','��ε� �� ȭ���˻�'),
               ('31','�ε� ���� ������ �̵�'),
               ('32','�ε� �� ȭ�� �˻�'),
               ('33','������ �ε���'),
               ('34','�ε� �� ȭ���˻�'),
               ('41','����� �̵�'),
               ('42','���� ���ͷ� �˻�'),
               ('43','���� ��ε���'),
               ('44','�𸮵� �� ȭ�� �˻�')
              );




type
  TPGM_PER = Record
    Write : Boolean ;
    Ban   : Boolean ;
    Read  : Boolean ;
  end;

  TSC_STATUS = Record
    D200  ,
    D201  ,
    D202  ,
    D203  ,
    D204  ,
    D205  ,
    D206  ,
    D207  ,
    D208  ,
    D209  : String ;
    D210  : Array [0..15] of String ;
    D211  : Array [0..15] of String ;
  end;

  TUSR_INFO = Record
    WRHS     : String;
    USR_ID   : String;
    USR_NM   : String;
    USR_GRAD : String;
    USE_YN   : String;
    PASSWD   : String;
    PGM      : Array [1..27] of TPGM_PER ;
  end;

  TFind_Info = Record
    GOODS_CD : String;
    ITEM_NO  : String;
    Model_NO : String;
  end;

  TBCR = Record
    BCRData  : String;
    BCRFlag  : String;
  End;

  TCurrent = Record
    Types   : String;
    Index   : Integer;
    Name    : String;
    Desc    : String;
    Option1 : String;
    Option2 : String;
    Option3 : String;
  end;

  TComportSet = Record
    Index       : Integer;
    Name        : String;
    Comport     : String;
    BaudRate    : String;
    DataBit     : String;
    StopBit     : String;
    Parity      : String;
    FlowControl : String;
  end;



  TCV_PLC = Record
   Case Integer of
    1 : (All : Array [0..9] of Char);
    2 : (
      PLC_Reset   : char;                        // (  1) PLC DATA Reset
      OP_Reset    : Array[1..  8] of Char;       // (  4) OP ��� ���� ����
    )
  End;

  // CV ���� ����
  TCV_Info = Record
   Case Integer of
    1 : (All : Array [0..2] of Char);
    2 : (
      CargoExist    : Char;
      CV_Error      : Char;
      AirTreat      : Char;

    )
  End;

  //OP ���� ����
  TOP_STATUS = Record
   Case Integer of
    1 : (All : Array [0..1] of Char);
    2 : (
      Error   : Char;  // OP �������
      Auto    : Char;  // OP �ڵ�( OP 1���� 2�� ����.)
    )
  End;

  TCVReady = Record
   Case Integer of
    1 : (All : Array [0..1] of Char);
    2 : (
      InReady        : Char;
      OutReady       : Char;
    )
  End;

  TBCR_Info = Record
   Case Integer of
    1 : (All : Array [0..1] of Char);
    2 : (
      Empty_Plt  : Char;
      Cargo_Plt  : Char;
    )
  End;

  TMagazine = Record
   Case Integer of
     1 : (All : Array [0..1] of Char);
     2 : (
      CargoExist     : Char;
      FullSignal     : Char;
    )
  End;


  //+++++++++++++++++++++++++++++++++++++++++++++++
  // SC ��� ����ü
  //+++++++++++++++++++++++++++++++++++++++++++++++
  TSts_SCMODE = Record
  Case Integer of
    1 : ( ALL : Array [1..08] Of char );
    2 : (
      SCCMAN   : Char;
      SCCAUTO  : Char;
      SCCREADY : Char;
      SCCEMG   : Char;
      SCTMAN   : Char;
      SCTAUTO  : Char;
      SCTREADY : Char;
      SCTEMG   : Char;
    );
  end;

  TSts_FORK = Record
  Case Integer of
    1 : ( ALL : Array [1..09] Of char );
    2 : (
      aFork_Center  : Char;
      aFork_Left    : Char;
      aFork_Right   : Char;
      aFork_Left_E  : Char;
      aFork_Right_E : Char;
      fFork_Center  : Char;
      fFork_Left    : Char;
      fFork_Right   : Char;
      fFork_Left_E  : Char;
      fFork_Right_E : Char;
    );
  end;

  TSC = Record // DB�� SC���� �����.
    SCRC_FK        : String ;    // �۾� ��ũ '1': ����ũ, '2' : ����ũ
    SCRC_CYCLE     : String ;    // �۾� Cycle -> 0: Idle, 1: �۾�����, 2: ������, 3: ȭ�� ����,
                                 //               4: �۾��Ϸ�, 5: �۾� �����߻�, 6: ������ ���� �߻�
    SCRC_PHASE     : String ;    // �۾� PHASE : ���� ������ SC Manual ����.
    SCRC_BAYPOS    : String ;    // SC ��ġ (��)
    SCRC_LVLPOS    : String ;    // SC ��ġ (��)
    SCRC_SCMODE    : TSts_SCMODE ;  // ���� �ڵ� ( 0: ����, 1: �ڵ� )
    SCRC_FK_STS    : TSts_FORK ;    // ��ũ ���� ( 0 : ��ũ�߽�, 1 : ������, 2 : �³�, 3 : ������, 4 : �쳡 )
    SCRC_STOCK     : String ;    // Fork �� ȭ�� ���� ( 0: ȭ��X, 1 : ȭ�� ���� )

    SCRC_RUNNING   : String ;    // ���� ���� ( 0: �����, 1: �����۾���, 2: ���ڵ��۾��� )
    SCRC_CONTROL   : String ;    // �۾� ( 1: ��⵿, 2: �۾����� )
    SCRC_COMPLETE  : String ;    // �۾��Ϸ�
    SCRC_ERROR     : String ;    // SC �������� ( 0: ����, 1: ���� )
    SCRC_RMTERROR  : String ;    // ���� �� �߻� �����ڵ�
    SCRC_ERRCODE   : String ;    // ���� ���� �ڵ�
    SCRC_ONOFF     : String ;    // Power Bit ����
  end;


  // CV Read ���� ����ü : OK
  TCVCR = Record
   Case Integer of
    1 : (All : Array [0..574] of Char);
    2 : (
      Buff            : Array[1..45] of TCV_Info;      // 2 * 48 = 96 : Buff ����(101~154)
      MOP_STATUS      : Array[1..04] of TOP_STATUS;    // 2 *  4 =  8 : Main OP���� (4���� : �ڵ�, ����)
      SOP_STATUS      : Array[1..06] of TOP_STATUS;    // 2 *  6 = 12 : Sub OP���� (6���� : �ڵ�, ����)
      CVReady         : Array[1..08] of TCVReady;      // 2 *  8 = 16 : ����� ������ ����(Ready)
      BCRData         : Array[1..03] of TBCR_Info;     // 2 *  3 =  6 : BCR �ȷ�Ʈ ����
      ByPass_MODE     : Array[1..03] of Char;          // 1 *  3 =  3 : ������ ByPass ���
      Magazine        : Array[1..35] of TMagazine;     // 2 * 35 = 70 : Off���� Buff ��������
    )
  End;


  TCVCW = Record
  Case Integer of
    1 : (All : Array [0..36] of Char);
    2 : (
      PLC_Reset    : Char;                        // (  1) PLC DATA Reset
      MOP_Reset    : Array[1..  8] of Char;       // (  8) OP ��� ���� ����
      SOP_Reset    : Array[1..  8] of Char;       // (  8) OP ��� ���� ����
      CON_Stoper   : Array[1..  4] of Char;       // (  4) ��� ������ ����
      BCR_Status   : Array[0.. 15] of Char;       // ( 16) BCR ������ ��Ȳ
    )
  End;

  TCVCR_P = Record
   Case Integer of
    1 : (All : Array [0..243] of Char);
    2 : (
      Buff            : Array[1..45] of TCV_Info;      // 3 * 48 = 135 : Buff ����(101~154)
      MOP_STATUS      : Array[1..04] of TOP_STATUS;    // 2 *  4 =   8 : Main OP���� (4���� : �ڵ�, ����)
      SOP_STATUS      : Array[1..06] of TOP_STATUS;    // 2 *  6 =  12 : Sub OP���� (6���� : �ڵ�, ����)
      CVReady         : Array[1..05] of TCVReady;      // 2 *  5 =  10 : ����� ������ ����(Ready)
      BCRData         : Array[1..03] of TBCR_Info;     // 2 *  3 =   6 : BCR �ȷ�Ʈ ����
      ByPass_MODE     : Array[1..03] of Char;          // 1 *  3 =   3 : ������ ByPass ���
      Magazine        : Array[1..35] of TMagazine;     // 2 * 35 =  70 : Off���� Buff ��������
    )
  End;
//
//  TCVCW = Record
//  Case Integer of
//    1 : (All : Array [0..8] of Char);
//    2 : (
//          CV_PLC        : Array[1..1] of TCV_PLC;         // (  1) PLC DATA Reset
//        )
//  End;

  TCVC_ITEM = Record
   Case Integer of
    1 : (All : Array [0..3] of Char);
    2 : (
      ITEM : Array[0..3] of Char;
    )
  End;

  TCVC_JOB = Record
   Case Integer of
    1 : (All : Array [0..2] of integer);
    2 : (
      NO   : Integer;
      DEST : Integer;
      ITEM : Integer;
    )
  End;

  TCV_JOB = Record
    Case Integer of
      1 : (All : Array[0..((sizeof(TCVC_JOB) * 2) -1)] of integer);
      2 : (
        Read  : array [1..45] of TCVC_JOB;
        Write : array [1..45] of TCVC_JOB;
      )
  end;

  TCV_ITM = Record
    ITEM  : array [1..45] of String;
  end;

  TCV_ITEM = Record
  Case Integer of
      1 : (All : Array[0..((sizeof(TCVC_JOB) * 2) -1)] of integer);
      2 : (
        Read  : array [1..45] of TCVC_ITEM;
        Write : array [1..45] of TCVC_ITEM;
      )
  end;

  // �κ� ���� ����
  TRobot_Info = Record
      CargoExist    : Char;
      Robot_Error   : Char;
      Robot_Mode    : Char;
      Plt_Count     : Integer;
      Error_Desc    : String;
  End;

  TCV = Record
    Case Integer of
      1 : (All : Array[0..(sizeof(TCVCR) + sizeof(TCVCW) -1)] of Char);
      2 : (
        Read  : TCVCR;
        Write : TCVCW;
      )
  end;

  TCV_ERR = Record
     Case Integer of
      1 : (All : Array[0..3679] of integer);
      2 : (
        New  : array [1..115, 0..15] of AnsiChar;  // 115 * 16 = 1840
        Old  : array [1..115, 0..15] of AnsiChar;  // 115 * 16 = 1840
      )
  End;


  // CV 1Word ������
  TCV_Read_M = Record
   Case Integer of
    1 : (All : Array [0..15] of Char);
    2 : (
          No1,No2,No3,No4,No5,No6,No7,No8,No9,No10,No11,No12,No13,No14,No15,No16    : Char;
    )
  End;

  // CV ��ü������
  TCV_Read_Buff = Record
   Case Integer of
    1 : (All : Array [0..176] of char);  // 16 * 11 = 176 Byte
    2 : (
           Mbuffer : Array [ 0..10] of TCV_Read_M ;  //16*11 = 176 Byte
     //      Dbuffer : Array [21..70] of TCV_Read_M ;  //16*51 = 800 Byte
    )
  End;

  // �԰�� ���ð� Ÿ��üũ
  TCV_Times = Record
        Flag : char;
        New  : String;
        Item : String;
  end;


  TCV_TimeR = Record
     tm  : array [1..3] of TCV_Times;
  end;


  // DBuffer Data
  TCV_DBuffer = Record
      Dbuffer : Array [21..70] of String;
  End;


  TinterLock = Record
    In118 : char ;
    In119 : char ;
  end;





  TCV_P = Record
    Case Integer of
      1 : (All : Array[0..(sizeof(TCVCR) + sizeof(TCVCW) -1)] of Char);
      2 : (
        Read  : TCVCR_P;
        Write : TCVCW;
      )
  end;


  TSC_JOB = Record
    ID_ORDLUGG     ,          // �۾� ��ȣ
    ID_REGTIME     ,          // �۾� ��� �ð�
    ID_ORDDATE     ,          // �۾� ��� ����
    ID_ORDTIME     ,          // �۾� ��� �Ͻ�

    IO_TYPE        ,          // ����� ���� ( I:�԰�, O:���, M:Rack To Rack, C:SC Site to SC Site )

    LOAD_BANK      ,          // ����(��)
    LOAD_BAY       ,          // ����(��)
    LOAD_LEVEL     ,          // ����(��)
    UNLOAD_BANK    ,          // �Ͽ�(��)
    UNLOAD_BAY     ,          // �Ͽ�(��)
    UNLOAD_LEVEL   ,          // �Ͽ�(��)

    ITM_CD         ,          // ������ �ڵ�

    SC_STEP        ,          // �۾� �ܰ� ( L : Loading, U : UnLoading, C : Cancel )

    JOB_RETRY      ,          // ��⵿
    JOB_CANCEL     ,          // �۾����
    JOB_COMPLETE   ,          // �۾��Ϸ� Reset

    DATA_RESET     ,          // �������ʱ�ȭ

    MOVE_ON        : String ; // �⵿����
  end;

  TTrk_JOB = Record
    TRACK_NO       : String  ; // ���۹�ȣ
    TRACK_YN       : String  ; // ����������
    TRACK_ORDLUGG  : String  ; // �۾���ȣ
    TRACK_ORDDATE  : String  ; // �۾����� ����
    TRACK_ORDTIME  : String  ; // �۾����� �ð�
    TRACK_DEST     : String  ; // ������
    TRACK_ITEMNO   : String  ; // �����ڵ�
    TRACK_LOTNO    : String  ; // Lot��ȣ
    TRACK_STOCKYN  : String  ; // ���� Y/N
  end;

  TTrk_JOB_P = Record
    TRACK_NO       : String  ;
    TRACK_YN       : String  ; // ����������
    TRACK_ORDLUGG  : String  ;
    TRACK_ORDDATE  : String  ;
    TRACK_ORDTIME  : String  ;
    TRACK_DEST     : String  ;
    TRACK_COMD     : String  ;
    TRACK_ITEMNO   : String  ;
    TRACK_DT       : String  ;
    TRACK_ETC      : String  ;
    STOCK_YN       : String  ;
    TRACK_SERIAL   : String  ;
    TRACK_BCRCD    : String  ;
  end;

  TLOT_INFO = Record
    LOT_NO                : String ; // ��Ʈ��ȣ
    JOB_NO                : String ; // �۾���ȣ
    ITM_CD                : String ; // ǰ���ڵ�
    ITM_NM                : String ; // ǰ�� ��
    MACHTP                : String ; // ����
    ITM_QTY               : String ; // ǰ�����
    MACHTP_STS            : String ; // ��������
    IST_DT                : String ; // �԰�����
    IST_TM                : String ; // �԰��Ͻ�
    STBL_IST_TM           : String ; // ��Ʈ���԰��Ͻ�
    STK_IST_TM            : String ; // ����Ŀ�԰��Ͻ�
    OT_TM                 : String ; // ����Ͻ�
    LOCA                  : String ; // �����̼�
    CURR_LOC              : String ; // ������ġ
    STOCKERNO             : String ; // ����Ŀ����Ʈ
    REF_ATCL              : String ; // ��������
    STBL_GBN              : String ; // ��Ʈ��ó������
    HEAT_PRCES_CNT        : String ; // ��ó��Ƚ��
    HEAT_PRCES_LINE       : String ; // ��ó������
    HEAT_PRCES_CELL       : String ; // ��ó����
    HEAT_PRCES_FINISH_STS : String ; // ��ó���Ϸ��Ͻ�
    ResultCd : String; // Save, Delete, Close
  end;

  TITEM_INFO = Record
    ITM_CODE     ,
	  ITM_DESC     ,
	  ITM_MODEL    ,
	  ITM_MISSION  ,
	  ITM_ENGINE   ,
	  ITM_WD       ,
	  ITM_PART_NO  ,
	  ITM_SEPC     ,
	  ITM_EPLT_YN  ,
	  ITM_HYBRID_YN,
	  ITM_BYPASS_YN,
	  ITM_MEMO     : String ;
  end;

implementation

end.
