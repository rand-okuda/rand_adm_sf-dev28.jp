public without sharing class N01_SeikyushoController {

    /** 売掛データID */
    private Id urlId;

    /** 請求書明細最大行数*/
    private static final Integer pageDetailMaxRows = SystemParam__c.getInstance().SeikyushoMeisaiMaxNum__c.intValue();
    
    /** 請求書宛先左余白調整(mm)*/
    public Integer atesakiHidariChoseiMm {get{return SystemParam__c.getInstance().SeikyushoAtesakiHidariChoseiMm__c.intValue();}}
    
    /** 請求書宛先上余白調整(mm)*/
    public Integer atesakiUeChoseiMm {get{return SystemParam__c.getInstance().SeikyushoAtesakiUeChoseiMm__c.intValue();}}
    
    /** 請求書タイトル上余白調整(mm)*/
    public Integer titleUeMm {get{return SystemParam__c.getInstance().SeikyushoTitleUeChoseiMm__c.intValue();}}
    
    /** 請求書タイトル下余白調整(mm)*/
    public Integer titleShitaMm {get{return SystemParam__c.getInstance().SeikyushoTitleShitaChoseiMm__c.intValue();}}
    
    /** ページデータ リスト */
    public List<PageData> pageDatas {get; private set;}
    
    private UrikakeData__c urikakeData;
    
    
    /**
     * コンストラクタ
     */
    public N01_SeikyushoController () {
        // URL売掛データIDを取得する
        urlId = ApexPages.currentPage().getParameters().get('UdId');
        
        // 売掛データ
        urikakeData = this.doSearchUrikakeData(urlId);
        
        pageDatas = createPageData(urlId);
        
    }
    
     /**
     * 請求書出力済フラグを更新する
     */
    public void doUpdate(){
        // 請求書　を　発行した際に　売掛データ.請求書出力済フラグ　を　TRUE　にする
        urikakeData.SeikyusyoShutsuryokuzumiFlg__c = true;
        update urikakeData;
    }
    
    /** ページデータ作成処理 */
    private List<PageData> createPageData(Id urlId){
        // インスタンス化
        PageData pageData = new PageData();
        List<PageData> pageDatas = new List<PageData>();
        
        // 売掛データ請求書_あいさつをリスト化
        String aisatsu = String.ValueOf(urikakeData.SeikyushoAisatsu__c);
        List <String> aisatsus = new List<String>();

        if(aisatsu != null && aisatsu.length() != 0) {
            aisatsu = Strings.doInsertNewLineB(aisatsu, 44);
            
            aisatsus = aisatsu.split('\n',0);
        }

        pageData.aisatsuDatas = aisatsus;
        
        // 受注明細データ
        List<JuchuMeisaiData__c> juchuMeisaiDataAll = this.doSearchJuchuMeisaiData(urlId);

        // 受注データ
        List<JuchuData__c> juchuDatas = this.doSearchJuchuData(juchuMeisaiDataAll);

        // 入金データ
        List<KeshikomiData__c> keshikomiDatas = this.doSearchKeshikomiData(urlId);
        
        // 1ページ目のヘッダを設定
        pageData.headData = urikakeData;
        
        Integer pageRows = 0;

        // 受注データで繰り返し
        for(Integer i = 0, j = juchuDatas.size(); i < j; i++){
            // 受注データと受注明細データ
            DetailWrapper detailWrap = new DetailWrapper();
            
            // 受注データ
            detailWrap.juchuData = juchuDatas[i];
            
            pageRows++;
            
            for(Integer m = 0, n = juchuMeisaiDataAll.size(); m < n; m++){
                if(juchuMeisaiDataAll[m].JuchuData__c == juchuDatas[i].Id) {
                    detailWrap.juchuMeisaiDatas.add(juchuMeisaiDataAll[m]);
                    pageRows++;

                    // 明細行数が最大に達した時
                    // （受注データが最後レコード　AND　（受注明細データが最後レコード　OR　入金データなし））の場合、次のページを作らない
                    if(pageRows >= pageDetailMaxRows && 
                       ( (i != (j-1)) || ( (i == (j-1)) && ( (m != (n-1)) || keshikomiDatas.size()!=0 ) ) )
                        ){
                        
                        // ページデータに受注データと受注明細データを追加
                        pageData.detailDatas.add(detailWrap);
                        
                        // ページデータリストに追加
                        pageDatas.add(pageData);
                        
                        // 新しいページデータ作成
                        pageData = new PageData();
                        detailWrap = new DetailWrapper();
                        pageData.headData = urikakeData;
                        pageData.aisatsuDatas = aisatsus;
                        pageData.pageNumber += pageDatas.size();
                        
                        pageRows = 0;
                    }
                }
            }
            
            // ページデータに受注データと受注明細データを追加
            pageData.detailDatas.add(detailWrap);
        }
        
        
        // 入金データで繰り返し
        for(Integer i = 0, j = keshikomiDatas.size(); i < j; i++){
            pageData.keshikomiDatas.add(keshikomiDatas[i]);
            pageRows++;
            
            // 明細行数が最大に達した時（入金データが最後レコードの場合、次のページを作らない）
            if(pageRows == pageDetailMaxRows && i != (j-1) ){
                
                // ページデータリストに追加
                pageDatas.add(pageData);
                
                // 新しいページデータ作成
                pageData = new PageData();
                pageData.headData = urikakeData;
                pageData.aisatsuDatas = aisatsus;
                pageData.pageNumber += pageDatas.size();
                
                pageRows = 0;
            }
        }
        
        // ページデータリストに追加
        pageDatas.add(pageData);
        
        return pageDatas;
    }
    
    
    //売掛データを取得する
    private UrikakeData__c doSearchUrikakeData(Id urikakeDataId){
        // 売掛データ検索
        UrikakeData__c urikakeData = [
            SELECT
                Id,
                Name,
                SeikyushoShamei__c,                     //請求書_社名
                SeikyushoSeikyusakiYubinBango__c,       //請求書_請求先郵便番号
                SeikyushoSeikyusakiJusho__c,            //請求書_請求先住所
                SeikyushoSeikyusakiBusho__c,            //請求書_請求先部署
                SeikyushoSeikyusakiMei__c,              //請求書_請求先名
                SeikyushoTitle__c,                      //請求書_タイトル
                SeikyushoAisatsu__c,                    //請求書_あいさつ
                SeikyushoGinkoTitle__c,                 //請求書_銀行タイトル
                SeikyushoGinko1__c,                     //請求書_銀行１
                SeikyushoGinko2__c,                     //請求書_銀行２

                SeikyushoUpper01Title__c,        //請求書_上段01タイトル
                SeikyushoUpper01__c,             //請求書_上段01
                SeikyushoUpper02Title__c,        //請求書_上段02タイトル
                SeikyushoUpper02__c,             //請求書_上段02
                SeikyushoUpper03Title__c,        //請求書_上段03タイトル
                SeikyushoUpper03__c,             //請求書_上段03
                SeikyushoUpper04Title__c,        //請求書_上段04タイトル
                SeikyushoUpper04__c,             //請求書_上段04
                SeikyushoUpper05Title__c,        //請求書_上段05タイトル
                SeikyushoUpper05__c,             //請求書_上段05

                SeikyushoLower01Title__c,        //請求書_下段01タイトル
                SeikyushoLower01__c,             //請求書_下段01
                SeikyushoLower02Title__c,        //請求書_下段02タイトル
                SeikyushoLower02__c,             //請求書_下段02
                SeikyushoLower03Title__c,        //請求書_下段03タイトル
                SeikyushoLower03__c,             //請求書_下段03
                SeikyushoLower04Title__c,        //請求書_下段04タイトル
                SeikyushoLower04__c,             //請求書_下段04
                SeikyushoLower05Title__c,        //請求書_下段05タイトル
                SeikyushoLower05__c,             //請求書_下段05

                SeikyushoDenpyoHizukeTitle__c,          //請求書_伝票日付タイトル
                SeikyushoDenpyoNoTitle__c,              //請求書_伝票番号タイトル
                SeikyushoShohinMeiKikakuTitle__c,       //請求書_商品名規格タイトル
                SeikyushoSuryoTitle__c,                 //請求書_数量タイトル
                SeikyushoTaniTitle__c,                  //請求書_単位タイトル
                SeikyushoTankaTitle__c,                 //請求書_単価タイトル
                SeikyushoKingakuTitle__c,               //請求書_金額タイトル
                SeikyushoBikoTitle__c                   //請求書_備考タイトル

            FROM
                UrikakeData__c
            WHERE
                Id = :urikakeDataId
        ];
        
        return urikakeData;
    }
    
    
    //受注明細データを取得する
    private List<JuchuMeisaiData__c> doSearchJuchuMeisaiData(Id urikakeDataId){
        // 受注明細データ検索
        List<JuchuMeisaiData__c> juchuMeisaiDatas = [
            SELECT
                Id,
                Name,
                JuchuData__c,                   //受注データ
                SeikyushoMeisaiShohinMei__c,    //請求書_明細商品名
                SeikyushoMeisaiKikaku__c,       //請求書_明細規格
                SeikyushoMeisaiSuryo__c,        //請求書_明細数量
                SeikyushoMeisaiTani__c,         //請求書_明細単位
                SeikyushoMeisaiTanka__c,        //請求書_明細単価
                SeikyushoMeisaiKingaku__c,      //請求書_明細金額
                SeikyushoMeisaiBiko__c          //請求書_明細備考
            FROM
                JuchuMeisaiData__c
            WHERE
                SeikyuShoTaishoGai__c = False
            and JuchuData__r.UrikakeData__c = :urikakeDataId
            ORDER BY
                JuchuData__r.SeikyushoDenpyoNo__c,      //受注データ．請求書_伝票番号
                NarabiJun__c ASC           //受注明細データ．並び順
        ];
        
        return juchuMeisaiDatas;
    }
    
    
    // 受注データを取得する
    private List<JuchuData__c> doSearchJuchuData(List<JuchuMeisaiData__c> juchuMeisaiDatas){
        
        Set<Id> juchuIds = new Set<Id>();
        
        //受注データIDを取得する
        if (juchuMeisaiDatas != null && juchuMeisaiDatas.size() > 0) {
            for(Integer i=0, j=juchuMeisaiDatas.size(); i<j; i++) {
                juchuIds.add(juchuMeisaiDatas[i].JuchuData__c);
            }
        }
        
        List<JuchuData__c> juchuDatas = new List<JuchuData__c>();
        
        // 受注データ検索
        if (juchuIds != null && juchuIds.size() > 0) {
            juchuDatas = [
                SELECT
                    Id,
                    Name,
                    JuchuUriageKakuteiBi__c,
                    SeikyushoDenpyoHizuke__c,   //請求書_伝票日付
                    SeikyushoDenpyoNo__c,       //請求書_伝票番号
                    SeikyushoDenpyoTanka__c,    //請求書_伝票単価
                    SeikyushoDenpyoKingaku__c,  //請求書_伝票金額
                    SeikyushoDenpyoBiko__c,      //請求書_伝票備考
                    SeikyushoDempyoSetsumei__c //請求書_伝票説明
                FROM
                    JuchuData__c
                WHERE
                    Id In :juchuIds
                    AND DenpyoKingakuZeroFlg__c = false
                    AND JuchuUriageKakuteiFlg__c = true
                ORDER BY
                    SeikyushoDenpyoNo__c        //受注データ．請求書_伝票番号
            ];
        }
        return juchuDatas;
    }
    
    
    // 入金データを取得する
    private List<KeshikomiData__c> doSearchKeshikomiData(Id urikakeDataId){
        
        // 入金データ検索
        List<KeshikomiData__c> keshikomiDatas = [
                SELECT
                    Id,
                    Name,
                    SeikyushoNyukinKingaku__c,      //請求書_入金金額
                    SeikyushoNyukinShohinMei__c,    //請求書_入金商品名
                    SeikyushoNyukinHizuke__c        //請求書_入金日付
                FROM
                    KeshikomiData__c
                WHERE
                    UrikakeData__c = :urikakeDataId
                AND SeikyuMeisaiFlg__c = TRUE
                ORDER BY
                    SeikyushoNyukinHizuke__c,        //請求書_入金日付
                    Biko__c                          //備考
            ];
        return keshikomiDatas;
    }
    
    
    /** ページデータクラス */
    public class PageData {
        public Integer pageNumber { get; private set; }
        public UrikakeData__c headData{ get; set; }
        public List<String> aisatsuDatas { get; set; }
        public List<DetailWrapper> detailDatas{ get; private set; }
        public List<KeshikomiData__c> keshikomiDatas{ get; private set; }
        
        public PageData(){
            this.pageNumber = 1;
            this.detailDatas = new List<DetailWrapper>();
            this.keshikomiDatas = new List<KeshikomiData__c>();
        }
    }
    
    
    /** ラッパークラス */
    public class DetailWrapper {
        public JuchuData__c juchuData { get; set; }
        public List<JuchuMeisaiData__c> juchuMeisaiDatas { get; set; }
        
        public DetailWrapper(){
            this.juchuMeisaiDatas = new List<JuchuMeisaiData__c>();
        }
    }
}