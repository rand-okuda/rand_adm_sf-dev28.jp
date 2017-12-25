public class J01_JuchuDataControllerExtension {

    // 受注確定フラグ
    public Boolean isDispUpdateButton {get; set;}
    // 納品入力描画フラグ
    public Boolean isNohinByoga {get; set;}
    // 警告表示フラグ
    public Boolean AlertFlg {get; set;}
    // 警告フラグ各種
    public Boolean SonotaErrorFlg {get; set;}
    public Boolean HikiateMemoFlg {get; set;}
    public Boolean HikiateMemoALLFlg {get; set;}
    public Boolean KoteiKoseiMemoALLFlg {get; set;}
    public Boolean JuchuErrorFlg {get; set;}
    public Boolean JuchuSuryoMemoFlg {get; set;}
    public Boolean TourokuMemoFlg {get; set;}
    public Boolean TourokuMemoALLFlg {get; set;}
    public Boolean MeisaiMemoALLFlg {get; set;}

    // 標準セットコントローラー
    public ApexPages.StandardSetController ssc {get; set;}

    // ページング用
    public Boolean hasNext {get; set;}
    public Boolean hasPrevious {get; set;}
    public Integer pageNumber;

    // 編集ページング用　明細データ一覧
    public List<JuchuMeisaiData__c> targetMeisaiList {get; set;}
    // クエリ用　明細データ一覧
    public List<JuchuMeisaiData__c> selctMeisaiList;
    // 受注データ 
    public JuchuData__c juchuData {get; set;}
    // 受注データID
    public Id juchuDataId;
    
    // コンストラクタ
    public J01_JuchuDataControllerExtension(ApexPages.StandardController stdController){

        // 受注データIDを取得
        juchuDataId = stdController.getId();

        // 受注データを取得
        getJuchuData();

        // 受注データフラグを取得
        getJuchuDataFlg();

        // ページ番号初期化
        pageNumber = 1;

        //セットコントローラー初期化
        initStdSetCon();

        //ページネイション情報取得
        initSwitchingPage();

    }

    //受注明細取得処理とセットコントローラー初期化
    public void initStdSetCon() {

        // 受注明細取得処理
        List<JuchuMeisaiData__c> selctMeisaiList = new List<JuchuMeisaiData__c>();
        
        selctMeisaiList = [SELECT Id, 
                           ShohinShizaiM__c, ShohinShizaiMeisho__c, MeyasuZan__c, Biko__c, 
                           KingakuZero__c, KingakuMinus__c, 
                           DenpatsuJogai__c, NohinJogai__c, MeisaiJyogai__c, HikiateFuyoFig__c, 
                           JuchuSuryo__c, JuchuSuryoCT__c, JuchuSuryoCS__c, JuchuSuryoPC__c, 
                           NohinSuryo__c, 
                           ShohinBaika__c,
                           TaniPC__c, TaniCS__c, TaniCT__c ,
                           SuryoBairitsuCS__c, SuryoBairitsuCT__c 
                           FROM JuchuMeisaiData__c 
                           WHERE JuchuData__c = :juchuDataId 
                           ORDER BY NarabiJun__c ASC
                          ];

        // セットコントローラー起動
        ssc = new ApexPages.StandardSetController(selctMeisaiList);
        // 1ページ行数設定
        ssc.setPageSize(10);
        // ページ番号番号設定
        ssc.setPageNumber(pageNumber);
        // セットコントローラーから一覧取得
        targetMeisaiList = ssc.getRecords();

    }
    
    //ページネイション情報取得
    public void initSwitchingPage() {
        // 次ページ有無
        hasNext = ssc.getHasNext();
        // 前ページ有無
        hasPrevious = ssc.getHasPrevious();
        // 現在のページ番号取得
        pageNumber = ssc.getPageNumber();
    }
    
    //保存ボタンを押した時の処理
    public void saveButton() {
        //明細一覧と受注データ更新
        updateMeisaiList();
        //ページネイション情報取得
        initSwitchingPage();
        //受注明細取得処理とセットコントローラー初期化
        initStdSetCon();
        // 受注データ側の表示を更新
        getJuchuData();
        // 受注データ側のフラグを更新
        getJuchuDataFlg();
    }

    //再表示ボタンを押した時の処理
    public void reDisplay() {
        //ページネイション情報取得
        initSwitchingPage();
        //受注明細取得処理とセットコントローラー初期化
        initStdSetCon();
        // 受注データ側の表示を更新
        getJuchuData();
        // 受注データ側のフラグを更新
        getJuchuDataFlg();
    }

    // ページ次ページ
    public void next(){
        // 一旦に初期化（編集途中のページネイションエラー対策）
        initStdSetCon();
        // 次ページを選択
        ssc.next();
        // ページを選択後の情報を取得
        initSwitchingPage();
        // ページを選択後の情報で初期化
        initStdSetCon();
    }

    // ページ前ページ
    public void previous(){
        // 一旦に初期化（編集途中のページネイションエラー対策）
        initStdSetCon();
        // 前ページを選択
        ssc.previous();
        // ページを選択後の情報を取得
        initSwitchingPage();
        // ページを選択後の情報で初期化
        initStdSetCon();
    }
    
    //受注明細と受注データ更新処理
    private void updateMeisaiList(){

        //エラー書込先を一旦空白
        JuchuData.MeisaiMemoALL__c = '';

        // DMLエクセプション想定
        try {
            //明細を更新
            update targetMeisaiList;
        } catch (System.DmlException e) {
            //エクセプション発生時はメッセージを受注データに書き込む
            for (Integer i = 0; i < e.getNumDml(); i++) {
                JuchuData.MeisaiMemoALL__c += '\n' + e.getDmlMessage(i);
            }
        }

        //メッセージを書込で受注データを更新
        update JuchuData;

    }

    //受注データ取得処理
    public void getJuchuData(){

        juchuData = new JuchuData__c();

        juchuData = [SELECT Id, 
                     IsDispUpdateButton__c, NohinByogaFlg__c,
                     SonotaError__c, JuchuError__c, HikiateMemo__c, JuchuSuryoMemo__c, TourokuMemo__c, 
                     HikiateMemoALL__c, KoteiKoseiMemoALL__c, TourokuMemoALL__c, MeisaiMemoALL__c
                     FROM JuchuData__c 
                     WHERE Id = :juchuDataId 
                     LIMIT 1
                    ];

    }

    //受注データフラグ取得処理
    public void getJuchuDataFlg(){

        // 描画切替フラグ設定
        isDispUpdateButton = JuchuData.IsDispUpdateButton__c;
        isNohinByoga = JuchuData.NohinByogaFlg__c;

        // 警告：その他 フラグ設定
        if (String.isNotBlank(juchuData.SonotaError__c)){ SonotaErrorFlg = TRUE; }else{ SonotaErrorFlg = FALSE; }
        // 警告：引当 フラグ設定
        if (String.isNotBlank(juchuData.HikiateMemo__c)){ HikiateMemoFlg = TRUE; }else{ HikiateMemoFlg = FALSE; }
        // 警告＋：引当 フラグ設定
        //if (String.isNotBlank(juchuData.HikiateMemoALL__c)){ HikiateMemoALLFlg = TRUE; }else{ HikiateMemoALLFlg = FALSE; }
        // 警告＋：引当 フラグ設定（非表示固定）
        HikiateMemoALLFlg = FALSE;
        // 警告＋：構成 フラグ設定
        //if (String.isNotBlank(juchuData.KoteiKoseiMemoALL__c)){ KoteiKoseiMemoALLFlg = TRUE; }else{ KoteiKoseiMemoALLFlg = FALSE; }
        // 警告＋：構成 フラグ設定（非表示固定）
        KoteiKoseiMemoALLFlg = FALSE;
        // 警告：受注 フラグ設定
        if (String.isNotBlank(juchuData.JuchuError__c)){ JuchuErrorFlg = TRUE; }else{ JuchuErrorFlg = FALSE; }
        // 警告：数量 フラグ設定
        if (String.isNotBlank(juchuData.JuchuSuryoMemo__c)){ JuchuSuryoMemoFlg = TRUE; }else{ JuchuSuryoMemoFlg = FALSE; }
        // 警告：登録 フラグ設定
        if (String.isNotBlank(juchuData.TourokuMemo__c)){ TourokuMemoFlg = TRUE; }else{ TourokuMemoFlg = FALSE; }
        // 警告＋：登録 フラグ設定
        //if (String.isNotBlank(juchuData.TourokuMemoALL__c)){ TourokuMemoALLFlg = TRUE; }else{ TourokuMemoALLFlg = FALSE; }
        // 警告＋：登録 フラグ設定（非表示固定）
        TourokuMemoALLFlg = FALSE;
        // 警告＋：明細 フラグ設定
        if (String.isNotBlank(juchuData.MeisaiMemoALL__c)){ MeisaiMemoALLFlg = TRUE; }else{ MeisaiMemoALLFlg = FALSE; }

        // 警告表示フラグ設定
        if (SonotaErrorFlg||HikiateMemoFlg||HikiateMemoALLFlg||KoteiKoseiMemoALLFlg||JuchuErrorFlg||JuchuSuryoMemoFlg||TourokuMemoFlg||TourokuMemoALLFlg||MeisaiMemoALLFlg){
            AlertFlg = TRUE;
        }else{
            AlertFlg = FALSE;
        }
        
    }

}