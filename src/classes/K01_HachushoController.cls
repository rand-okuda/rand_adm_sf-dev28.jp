public without sharing class K01_HachushoController {
    /** 発注データID */
    private Id urlId;

    /** 発注書明細最大行数*/
    private static final Integer pageDetailMaxRows = SystemParam__c.getInstance().HachushoMeisaiMaxNum__c.intValue();
    
    /** ページデータ リスト */
    public List<PageData> pageDatas {get; private set;}
    
    
    /**
     * コンストラクタ
     */
    public K01_HachushoController () {
        // URL発注データIDを取得する
        urlId = ApexPages.currentPage().getParameters().get('HdId');
        
        pageDatas = createPageData(urlId);
    }


    /** ページデータ作成処理 */
    private List<PageData> createPageData(Id urlId){
        // インスタンス化
        PageData pageData = new PageData();
        List<PageData> pageDatas = new List<PageData>();
        
        // 発注データ
        HachuData__c hachuData = this.doSearchHachuData(urlId);
        
        // 発注データ備考をリスト化
        String hachushoBiko = String.ValueOf(hachuData.HachushoBiko__c);
        List <String> memos = new List<String>();

        if(hachushoBiko != null && hachushoBiko.length() != 0) {
            hachushoBiko = Strings.doInsertNewLineB(hachushoBiko, 150);
            
            memos = hachushoBiko.split('\n',0);
        }

        pageData.hachushoBikos = memos;
        
        
        // 発注明細データ
        List<HachuMeisaiData__c> hachuMeisaiDatas = this.doSearchHachuMeisaiData(urlId);
        
        // 1ページ目のヘッダを設定
        pageData.headData = hachuData;
        
        // 発注明細データで繰り返し
        for(Integer i = 0, j = hachuMeisaiDatas.size(); i < j; i++){
            // ページデータに見積商品明細を追加
            pageData.detailDatas.add(hachuMeisaiDatas[i]); 
            
            // 明細行数が最大に達した時
            if(pageData.detailDatas.size() == pageDetailMaxRows && i + 1 <> j ){
                // ページデータリストに追加
                pageDatas.add(pageData);
                
                // 新しいページデータ作成
                pageData = new PageData();
                pageData.headData = hachuData;
                pageData.hachushoBikos = memos;
                pageData.pageNumber += pageDatas.size();
            }
        }
        
        // ページデータリストに追加
        pageDatas.add(pageData);
        
        return pageDatas;
    }


    //発注データを取得する
    private HachuData__c doSearchHachuData(Id hachuDataId){
        // 発注データ検索
        HachuData__c hachuData = [
            SELECT
                Id,
                Name,
                HachushoShiiresakiMei__c,       //発注書_仕入先名
                HachushoDenpyoNo__c,            //発注書_伝票番号
                HachushoHakkobi__c,             //発注書_発行日
                HachushoNoki__c,                //発注書_納期
                HachushoTantoshaMei__c,         //発注書_担当者名
                HachushoNohinsakiMei1__c,       //発注書_納品先名１
                HachushoNohinsakiMei2__c,       //発注書_納品先名２
                HachushoNohinsakiJusho1__c,     //発注書_納品先住所１
                HachushoNohinsakiJusho2__c,     //発注書_納品先住所２
                HachushoNohinsakiDenwa__c,      //発注書_納品先電話
                HachushoNohinsakiFax__c,        //発注書_納品先ＦＡＸ
                
                HachushoMotoMei1__c,            //発注書_元名１
                HachushoMotoMei2__c,            //発注書_元名２
                HachushoMotoJusho1__c,          //発注書_元住所１
                HachushoMotoJusho2__c,          //発注書_元住所２
                HachushoMotoDenwa__c,           //発注書_元電話
                HachushoMotoFax__c,             //発注書_元ＦＡＸ
                
                HachushoBiko__c,                //発注書_備考
                
                HachushoTitle__c,               //発注書_タイトル
                HachushoNoTitle__c,             //発注書_ＮＯタイトル
                HachushoShohinCodeTitle__c,     //発注書_商品コードタイトル
                HachushoKikakuTitle__c,         //発注書_規格タイトル
                HachushoShohinMeiTitle__c,      //発注書_商品名タイトル
                HachushoIrisuTitle__c,          //発注書_入数タイトル
                HachushoSuryoTitle__c,          //発注書_数量タイトル
                HachushoTaniTitle__c,           //発注書_単位タイトル
                HachushoNokikaitoTitle__c,      //発注書_納期回答タイトル
                HachushoBikoTitle__c,           //発注書_備考タイトル
                
                HachushoMotoYubinBango__c,      //発注書_元郵便番号
                HachushoShiiresakiCode__c,      //発注書_仕入先コード
                HachushoShiiresakiFax__c,       //発注書_仕入先ＦＡＸ
                HachushoNohinsakiYubinBango__c, //発注書_納品先郵便番号
                HachushoHachubi__c              //発注書_発注日
            FROM
                HachuData__c
            WHERE
                Id = :hachuDataId
        ];
        
        return hachuData;
    }
    
    
    //発注明細データを取得する
    private List<HachuMeisaiData__c> doSearchHachuMeisaiData(Id hachuDataId){
        // 発注明細データ検索
        List<HachuMeisaiData__c> hachuMeisaiDatas = [
            SELECT
                Id,
                Name,
                HachushoShohinCode__c,  //発注書_商品コード
                HachushoKikaku__c,      //発注書_規格
                HachushoShohinMei__c,   //発注書_商品名
                HachushoIrisu__c,       //発注書_入数
                HachushoSuryo__c,       //発注書_数量
                HachushoTani__c,        //発注書_単位
                HachushoNoki__c         //発注書_納期
            FROM
                HachuMeisaiData__c
            WHERE
                HachuData__c = :hachuDataId
            ORDER BY
                HachushoShohinCode__c
        ];
        
        return hachuMeisaiDatas;
    }
    
    
    /** ページデータクラス */
    public class PageData {
        public Integer pageNumber { get; private set; }
        public HachuData__c headData{ get; set; }
        public List<String> hachushoBikos{ get; set; }
        public List<HachuMeisaiData__c> detailDatas{ get; private set; }
              
        public PageData(){
            this.pageNumber = 1;
            this.hachushoBikos = new List<String>();
            this.detailDatas = new List<HachuMeisaiData__c>();
        }
    }
}