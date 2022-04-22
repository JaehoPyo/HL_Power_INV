unit h_MainLib;

interface

uses inifiles,Windows, Sysutils, ExtCtrls, ADODB, ScktComp, Graphics ;

Const
  LogFileName  : String = '.\Log\Monitoring.Log';
  INI_PATH : String = 'AwHouse.INI';

  CONN_STATUS_COLOR : Array [0..1] of TColor = ($008484FF, $0068FF68);
  BTN_FONT_COLOR : Array [1..2] of TColor = (clBlack, $008B8B8B);

  // 완성품 -------------------------
  START_SCNO   = 1 ; // Start SC No
  End_SCNO     = 1 ; // End SC No

  START_CVNO   = 1 ; // Start CV No
  End_CVNO     = 2 ; // End CV No

  START_BCRNO  = 1 ; // Start BCR No
  End_BCRNO    = 4 ; // End BCR No

  START_ITNO_P = 1 ; // Start Interface No
  End_ITNO_P   = 1 ; // End Interface No
  //---------------------------------


  SiteCH117 = 31; //Site 채널
  SiteCH118 = 33; //42; //Site 채널
  SiteCH119 = 34; //43; //Site 채널

  inReady117  = 1;
  inReady118  = 2;
  inReady119  = 3;

  OutReady100 = 4;
  OutReady101 = 5;
  OutReady200 = 6;
  OutReady201 = 7;
  OutReady109 = 8;



  MenuCount  = 7 ; // 메인화면의 메뉴 수

  //========================================================================
  // 메인폼 툴바 버튼 Tag값
  //========================================================================
  MSG_MDI_WIN_ORDER   = 11 ; // 지시
  MSG_MDI_WIN_ADD     = 12 ; // 신규
  MSG_MDI_WIN_DELETE  = 13 ; // 삭제
  MSG_MDI_WIN_UPDATE  = 14 ; // 수정
  MSG_MDI_WIN_EXCEL   = 15 ; // 엑셀
  MSG_MDI_WIN_PRINT   = 16 ; // 인쇄
  MSG_MDI_WIN_QUERY   = 17 ; // 조회
  MSG_MDI_WIN_CLOSE   = 20 ; // 닫기
  MSG_MDI_WIN_LANG    = 21 ; // 언어

  //메뉴ID
  PGMID      : Array[1..25] of String=('100','110','120','200','210','220','300','310','320',
                                       '400','410','420','430','440','450','460','470',
                                       '500','510','520','600','610','700','710','720' );


  // Display Ref Arry
  LANG_BColor : Array[0..1] of TColor = ( clWhite,  $00FF3C3C );  // Language Button Base Color (미선택, 선택)
  LANG_FColor : Array[0..1] of TColor = ( $00828282,  clWhite );  // Language Button Font Color (미선택, 선택)

  Btn_BColor  : Array[0..1] of TColor = ( $00F7F7F7, $00FF3C3C) ; // Button Click Base Color (미클릭, 클릭)
  Btn_FColor  : Array[0..1] of TColor = ( $004D4D4D,  clWhite ) ; // Button Click Font Color (미클릭, 클릭)

  Add_No      : Array[1..2] of integer = ( 100, 210 );


  BCR_Def     : Array[1..3] of integer = ( 100, 151, 260 );
  Add_No_P    : Array[1..3] of integer = ( 100, 151, 210 );

  STOPER_DEF  : Array[1..4] of integer = ( 211, 221, 231, 241 ) ;

  BUFF_IDX   : Array[1..45] of integer =  // 화물 유무 Bit의 index
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

  CargoIndex : Array[1..45, 1..2] of integer =  // 화물 유무 Bit의 index
       (( 1,13), ( 1,14), ( 1,15), ( 2, 0), ( 2, 1), ( 2, 2), ( 2, 3), ( 2, 4), ( 2, 5), ( 2, 6),
        ( 2, 7), ( 2, 8), ( 2, 9), ( 2,10), ( 2,11), ( 2,12), ( 2,13), ( 2,14), ( 2,15), ( 3, 0),
        ( 3, 1), ( 3, 2), ( 8, 1), ( 8, 2), ( 8, 3), ( 8, 4), ( 8, 5), ( 8, 6), ( 8, 7), ( 8, 8),
        ( 8, 9), ( 8,10), ( 8,11), ( 8,12), ( 8,13), ( 8,14), ( 8,15), ( 9, 0), ( 9, 1), ( 9, 2),
        ( 9, 6), ( 9, 7), ( 9, 8), ( 9, 9), ( 9,10) );

  ErrorIndex : Array[1..45, 1..2] of integer =  // 화물 유무 Bit의 index
       (( 5, 9), ( 5,10), ( 5,11), ( 5,12), ( 5,13), ( 5,14), ( 5,15), ( 6, 0), ( 6, 1), ( 6, 2),
        ( 6, 3), ( 6, 4), ( 6, 5), ( 6, 6), ( 6, 7), ( 6, 8), ( 6, 9), ( 6,10), ( 6,11), ( 6,12),
        ( 6,13), ( 6,14), (11,13), (11,14), (11,15), (12, 0), (12, 1), (12, 2), (12, 3), (12, 4),
        (12, 5), (12, 6), (12, 7), (12, 8), (12, 9), (12,10), (12,11), (12,13), (12,14), (13, 2),
        (13, 3), (13, 4), (13, 5), (13, 6), (13, 7) ) ;




  // RGV Status Display Ref Arry
  Auto_Text   : Array[0..1] of String = ( '수동', '자동');    // Auto Mode Caption Text
  Auto_BColor : Array[0..1] of TColor = ( clYellow, clLime);  // Auto Mode Base Color
  Auto_FColor : Array[0..1] of TColor = ( clBlack, clBlack);  // Auto Mode Font Color

  EMG_Text   : Array[0..1] of String = ( '정상', '비상');     // Emergency S/W Status Caption Text
  EMG_BColor : Array[0..1] of TColor = ( clLime, clRed   );   // Emergency S/W  Status Base Color
  EMG_FColor : Array[0..1] of TColor = ( clBlack, clWhite);   // Emergency S/W  Status Font Color

  Error_Text   : Array[0..1] of String = ( '정상', '에러');   // Auto Mode Caption Text
  Error_BColor : Array[0..1] of TColor = ( clLime, clRed  );  // Error Status Base Color
  Error_FColor : Array[0..1] of TColor = ( clBlack, clWhite); // Error Status Font Color
  Error_LColor : Array[0..1] of TColor = ( clActiveCaption, clRed  );  // Error Status Lamp Color

  Move_Text   : Array[0..1] of String = ( '대기중', '작업중');// Working Mode Caption Text
  Move_BColor : Array[0..1] of TColor = ( clYellow, clLime ); // Working Status Base Color
  Move_FColor : Array[0..1] of TColor = ( clBlack, clBlack ); // Working Status Font Color

  Pwr_Text   : Array[0..1] of String = ( 'OFF', 'ON');        // Power Bit Status Caption Text
  Pwr_BColor : Array[0..1] of TColor = ( clYellow, clLime );  // Power Bit Status Base Color
  Pwr_FColor : Array[0..1] of TColor = ( clBlack, clBlack   );// Power Bit Status Font Color

  CrgAndData_Text   : Array[0..3] of String = ( '화물(O) 데이터(O)', '화물(O) 데이터(X)', '화물(X) 데이터(O)', '화물(X) 데이터(X)'  );// RGV Gargo Exist Status Base Color
  Crg_Text   : Array[0..1] of String = ( '화물(X)', '화물(O)' );// RGV Gargo Exist Status Base Color
  Crg_BColor : Array[0..1] of TColor = ( clWhite, $00C08000 );// RGV Gargo Exist Status Base Color
  Crg_FColor : Array[0..1] of TColor = ( clBlack, clWhite );// RGV Gargo Exist Status Base Color
  Brk_BColor : Array[0..1] of TColor = ( clWhite, clYellow ); // RGV Gargo Break Status Base Color

  Comm_Text   : Array[0..1] of String = ( '정상', '이상');    // RCT ↔RCC 통신 Mode Caption Text
  Comm_BColor : Array[0..1] of TColor = ( clLime  , clRed   );// RCT ↔RCC 통신 Mode Base Color
  Comm_FColor : Array[0..1] of TColor = ( clBlack , clWhite );// RCT ↔RCC 통신 Mode Font Color

  Rail_Text   : Array[0..1] of String = ( '탈착', '장착');    // 레일위 장착 Mode Caption Text
  Rail_BColor : Array[0..1] of TColor = ( clRed   , clLime  );// 레일위 장착 Mode Base Color
  Rail_FColor : Array[0..1] of TColor = ( clWhite , clBlack );// 레일위 장착 Mode Font Color

  OX_Text     : Array[0..1] of String = ( ' X', ' O');          // 기타 O, X 관련 Caption Text
  OX_BColor1  : Array[0..1] of TColor = ( clWhite, clLime);   // 기타 O, X 관련 Mode Base Color
  OX_BColor2  : Array[0..1] of TColor = ( clWhite, clRed);    // 기타 O, X 관련 Mode Base Color
  OX_FColor   : Array[0..1] of TColor = ( clBlack, clWhite);  // 기타 O, X 관련 Mode Font Color

  SC_ForkStatus : Array[0..5] of String
            = ( '포크중심', '좌출 중', '좌끝', '우출 중', '우끝', '알수없음' ) ;

  RGV_A_Ack_Status : Array[0..9] of String
            = ( 'U-message에 의해 새로운 작업이 정상 등록되었음' ,
                '등록 후 RTC에 의해 지정된 작업이 정상 완료되었음',
                '등록된 작업을 수행하다 작업에 에러가 발생하였음',
                'U-message에 의해 작업이 삭제되었음',
                '작업이 재기동 되었음',
                '지시된 주체가 틀림, 이미 완료됨',
                '작업 버퍼 Full',
                '사용중인 Lugg number를 사용',
                '작업등록을 할 때 첨부된 Data에 이상이 있음',
                '작업이 없거나 에러중이 아니어서 작업을 재기동 할 수 없음' ) ;

  // RGV Phase Msg
  RGVPhase : Array[0..31, 1..2] of String
            = ( ('00', '작업없이 대기중'),
                ('01', '사용안함'),
                ('02', '사용안함'),
                ('03', '사용안함'),
                ('04', '사용안함'),
                ('05', '사용안함'),
                ('06', '사용안함'),
                ('07', '사용안함'),
                ('08', '사용안함'),
                ('09', '사용안함'),
                ('0A', '사용안함'),
                ('0B', '사용안함'),
                ('0C', 'Home이동중'),
                ('0D', 'Home이동완료'),
                ('0E', '사용안함'),
                ('0F', '사용안함'),
                ('10', '입고대 이동전 화물있으면 작업완료'),
                // ('10', '입고대로 이동전 Conveyor위의 화물검사하여 있으면 작업 완료'),
                ('11', '입고대로 이동'),
                ('12', '입고대 검사'),
                ('13', 'Loading 작업'),
                ('14', '작업후 화물검사'),
                ('15', '사용안함'),
                ('16', '사용안함'),
                ('17', '입고대 작업완료'),
                ('18', '출고대 이동전 화물없으면 작업완료'),
                // ('18', '출고대 이동전 Conveyor위 화물검사하여 없으면 작업 완료'),
                ('19', '출고대로 이동'),
                ('1A', '출고대 검사'),
                ('1B', 'Unloading 작업'),
                ('1C', '작업후 화물검사'),
                ('1D', '사용안함'),
                ('1E', '사용안함'),
                ('1F', '이동작업 완료')
              ) ;


  // SC Phase Msg
  SCPhase : Array[1..21, 1..2] of String
            = (
               ('00','대기중'),
               ('01','홈이동'),
               ('02','입고대로 이동'),
               ('03','출고대로 이동'),
               ('04','랙으로 이동'),
               ('11','입고대로 이동'),
               ('12','입고대 인터록 검사'),
               ('13','입고대 로딩중'),
               ('14','로딩 후 화물 검사'),
               ('21','언로딩 위해 랙으로 이동'),
               ('22','언로딩 전 이중입고 검사'),
               ('23','랙에 언로딩중'),
               ('24','언로딩 후 화물검사'),
               ('31','로딩 위해 랙으로 이동'),
               ('32','로딩 전 화물 검사'),
               ('33','랙에서 로딩중'),
               ('34','로딩 후 화물검사'),
               ('41','출고대로 이동'),
               ('42','출고대 인터록 검사'),
               ('43','출고대 언로딩중'),
               ('44','언리딩 후 화물 검사')
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
    D212  : Array [0..15] of String ;
    D213  : Array [0..15] of String ;
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
      OP_Reset    : Array[1..  8] of Char;       // (  4) OP 경고 해제 지시
    )
  End;

  // CV 상태 정보
  TCV_Info = Record
   Case Integer of
    1 : (All : Array [0..2] of Char);
    2 : (
      CargoExist    : Char;
      CV_Error      : Char;
      AirTreat      : Char;

    )
  End;

  //OP 상태 정보
  TOP_STATUS = Record
   Case Integer of
    1 : (All : Array [0..1] of Char);
    2 : (
      Error   : Char;  // OP 비상정지
      Auto    : Char;  // OP 자동( OP 1개당 2개 있음.)
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
  // SC 사용 구조체
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

  TSC = Record // DB에 SC상태 저장용.
    SCRC_FK        : String ;    // 작업 포크 '1': 전포크, '2' : 후포크
    SCRC_CYCLE     : String ;    // 작업 Cycle -> 0: Idle, 1: 작업지시, 2: 동작중, 3: 화물 재하,
                                 //               4: 작업완료, 5: 작업 에러발생, 6: 데이터 에러 발생
    SCRC_PHASE     : String ;    // 작업 PHASE : 세부 내용은 SC Manual 참조.
    SCRC_BAYPOS    : String ;    // SC 위치 (연)
    SCRC_LVLPOS    : String ;    // SC 위치 (단)
    SCRC_SCMODE    : TSts_SCMODE ;  // 기상반 자동 ( 0: 수동, 1: 자동 )
    SCRC_FK_STS    : TSts_FORK ;    // 포크 상태 ( 0 : 포크중심, 1 : 좌출중, 2 : 좌끝, 3 : 우출중, 4 : 우끝 )
    SCRC_STOCK     : String ;    // Fork 내 화물 유무 ( 0: 화물X, 1 : 화물 재하 )

    SCRC_RUNNING   : String ;    // 동작 상태 ( 0: 대기중, 1: 원격작업중, 2: 반자동작업중 )
    SCRC_CONTROL   : String ;    // 작업 ( 1: 재기동, 2: 작업삭제 )
    SCRC_COMPLETE  : String ;    // 작업완료
    SCRC_ERROR     : String ;    // SC 에러상태 ( 0: 정상, 1: 에러 )
    SCRC_RMTERROR  : String ;    // 원격 중 발생 에러코드
    SCRC_ERRCODE   : String ;    // 현재 에러 코드
    SCRC_ONOFF     : String ;    // Power Bit 관련
  end;


  // CV Read 정보 구조체 : OK
  TCVCR = Record
   Case Integer of
    1 : (All : Array [0..574] of Char);
    2 : (
      Buff            : Array[1..45] of TCV_Info;      // 2 * 48 = 96 : Buff 정보(101~154)
      MOP_STATUS      : Array[1..04] of TOP_STATUS;    // 2 *  4 =  8 : Main OP정보 (4개소 : 자동, 수동)
      SOP_STATUS      : Array[1..06] of TOP_STATUS;    // 2 *  6 = 12 : Sub OP정보 (6개소 : 자동, 수동)
      CVReady         : Array[1..08] of TCVReady;      // 2 *  8 = 16 : 입출고 컨베어 상태(Ready)
      BCRData         : Array[1..03] of TBCR_Info;     // 2 *  3 =  6 : BCR 팔렛트 정보
      ByPass_MODE     : Array[1..03] of Char;          // 1 *  3 =  3 : 컨베어 ByPass 모드
      Magazine        : Array[1..35] of TMagazine;     // 2 * 35 = 70 : Off라인 Buff 센서정보
    )
  End;


  TCVCW = Record
  Case Integer of
    1 : (All : Array [0..36] of Char);
    2 : (
      PLC_Reset    : Char;                        // (  1) PLC DATA Reset
      MOP_Reset    : Array[1..  8] of Char;       // (  8) OP 경고 해제 지시
      SOP_Reset    : Array[1..  8] of Char;       // (  8) OP 경고 해제 지시
      CON_Stoper   : Array[1..  4] of Char;       // (  4) 출고 스토퍼 제어
      BCR_Status   : Array[0.. 15] of Char;       // ( 16) BCR 데이터 상황
    )
  End;

  TCVCR_P = Record
   Case Integer of
    1 : (All : Array [0..243] of Char);
    2 : (
      Buff            : Array[1..45] of TCV_Info;      // 3 * 48 = 135 : Buff 정보(101~154)
      MOP_STATUS      : Array[1..04] of TOP_STATUS;    // 2 *  4 =   8 : Main OP정보 (4개소 : 자동, 수동)
      SOP_STATUS      : Array[1..06] of TOP_STATUS;    // 2 *  6 =  12 : Sub OP정보 (6개소 : 자동, 수동)
      CVReady         : Array[1..05] of TCVReady;      // 2 *  5 =  10 : 입출고 컨베어 상태(Ready)
      BCRData         : Array[1..03] of TBCR_Info;     // 2 *  3 =   6 : BCR 팔렛트 정보
      ByPass_MODE     : Array[1..03] of Char;          // 1 *  3 =   3 : 컨베어 ByPass 모드
      Magazine        : Array[1..35] of TMagazine;     // 2 * 35 =  70 : Off라인 Buff 센서정보
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

  // 로봇 상태 정보
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


  // CV 1Word 데이터
  TCV_Read_M = Record
   Case Integer of
    1 : (All : Array [0..15] of Char);
    2 : (
          No1,No2,No3,No4,No5,No6,No7,No8,No9,No10,No11,No12,No13,No14,No15,No16    : Char;
    )
  End;

  // CV 전체데이터
  TCV_Read_Buff = Record
   Case Integer of
    1 : (All : Array [0..176] of char);  // 16 * 11 = 176 Byte
    2 : (
           Mbuffer : Array [ 0..10] of TCV_Read_M ;  //16*11 = 176 Byte
     //      Dbuffer : Array [21..70] of TCV_Read_M ;  //16*51 = 800 Byte
    )
  End;

  // 입고대 대기시간 타임체크
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
    ID_ORDLUGG     ,          // 작업 번호
    ID_REGTIME     ,          // 작업 등록 시간
    ID_ORDDATE     ,          // 작업 등록 일자
    ID_ORDTIME     ,          // 작업 등록 일시

    IO_TYPE        ,          // 입출고 유형 ( I:입고, O:출고, M:Rack To Rack, C:SC Site to SC Site )

    LOAD_BANK      ,          // 적재(열)
    LOAD_BAY       ,          // 적재(연)
    LOAD_LEVEL     ,          // 적재(단)
    UNLOAD_BANK    ,          // 하역(열)
    UNLOAD_BAY     ,          // 하역(연)
    UNLOAD_LEVEL   ,          // 하역(단)

    ITM_CD         ,          // 아이템 코드

    SC_STEP        ,          // 작업 단계 ( L : Loading, U : UnLoading, C : Cancel )

    JOB_RETRY      ,          // 재기동
    JOB_CANCEL     ,          // 작업취소
    JOB_COMPLETE   ,          // 작업완료 Reset

    DATA_RESET     ,          // 데이터초기화

    MOVE_ON        : String ; // 기동지시
  end;

  TTrk_JOB = Record
    TRACK_NO       : String  ; // 버퍼번호
    TRACK_YN       : String  ; // 데이터유무
    TRACK_ORDLUGG  : String  ; // 작업번호
    TRACK_ORDDATE  : String  ; // 작업지시 일자
    TRACK_ORDTIME  : String  ; // 작업지시 시간
    TRACK_DEST     : String  ; // 목적지
    TRACK_ITEMNO   : String  ; // 기종코드
    TRACK_LOTNO    : String  ; // Lot번호
    TRACK_STOCKYN  : String  ; // 스톡 Y/N
  end;

  TTrk_JOB_P = Record
    TRACK_NO       : String  ;
    TRACK_YN       : String  ; // 데이터유무
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
    LOT_NO                : String ; // 로트번호
    JOB_NO                : String ; // 작업번호
    ITM_CD                : String ; // 품목코드
    ITM_NM                : String ; // 품목 명
    MACHTP                : String ; // 기종
    ITM_QTY               : String ; // 품목수량
    MACHTP_STS            : String ; // 기종상태
    IST_DT                : String ; // 입고일자
    IST_TM                : String ; // 입고일시
    STBL_IST_TM           : String ; // 쇼트볼입고일시
    STK_IST_TM            : String ; // 스토커입고일시
    OT_TM                 : String ; // 출고일시
    LOCA                  : String ; // 로케이션
    CURR_LOC              : String ; // 현재위치
    STOCKERNO             : String ; // 스토커사이트
    REF_ATCL              : String ; // 참조사항
    STBL_GBN              : String ; // 쇼트볼처리여부
    HEAT_PRCES_CNT        : String ; // 열처리횟수
    HEAT_PRCES_LINE       : String ; // 열처리라인
    HEAT_PRCES_CELL       : String ; // 열처리셀
    HEAT_PRCES_FINISH_STS : String ; // 열처리완료일시
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

  TSTOCK = Record
    ID_STATUS,
    ITM_CD,
    ITM_NAME,
    ITM_SPEC,
    ITM_QTY,
    OT_USED,
    IN_USED,
    RF_LINE_NAME1,
    RF_LINE_NAME2,
    RF_PALLET_NO1,
    RF_PALLET_NO2,
    RF_MODEL_NO1,
    RF_MODEL_NO2,
    RF_BMA_NO,
    RF_AREA : String;
  End;

implementation

end.
