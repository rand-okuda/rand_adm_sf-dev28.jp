public without sharing class J22_NohinshoController{
    /** 受注データID */
    private Id urlId;

    /** 明細最大行数*/
    private static final Integer pageDetailMaxRows = SystemParam__c.getInstance().NohinshoMeisaiMaxNum__c.intValue();
    
    /** 納品書品名改行バイト数*/
    public static final Integer nohinshoLineByteNum  = SystemParam__c.getInstance().NohinshoLineByteNum__c.intValue();
    
    /** 納品書品名フォントサイズ*/
    public Integer nohinshoFontSize {get{return SystemParam__c.getInstance().NohinshoFontSize__c.intValue();}}

    /** ページデータ リスト */
    public List<PageData> pageDatas {get; private set;}
    
    
    /**
     * コンストラクタ
     */
    public J22_NohinshoController () {
        // URL受注データIDを取得する
        urlId = ApexPages.currentPage().getParameters().get('JdId');

        this.pageDatas = createPageData(urlId);
    }
    
    
    /**
     * 納品書出力済フラグを更新する
     */
    public void doUpdate(){
        if(null != pageDatas && pageDatas.size() > 0){
            // 受注データ
            JuchuData__c juchuData = pageDatas[0].headData;
            
            // 納品書　を　発行した際に　受注データ.納品書出力済フラグ　を　TRUE　にする
            juchuData.NouhinsyoShutsuryokuzumiFlg__c = true;
            update juchuData;
        }
    }
    
    
    /** ページデータ作成処理 */
    private List<PageData> createPageData(Id urlId){
        // インスタンス化
        PageData pageData = new PageData();
        List<PageData> pageDatas = new List<PageData>();

        // 在庫データリスト
        List<ZaikoData__c> zaikoDataAll = this.doSearchZaikoData(urlId);

        // 受注データ
        JuchuData__c juchuData = new JuchuData__c();
        
        if(zaikoDataAll != null && zaikoDataAll.size() > 0) {
            juchuData = zaikoDataAll[0].JuchuMeisai__r.JuchuData__r;
        }else{
            juchuData = doSearchJuchuData(urlId);
        }

        // 受注明細データリスト
        List<JuchuMeisaiData__c> juchuMeisaiDatas = this.doSearchJuchuMeisai(urlId);

        // 受注明細データと在庫データマップ
        Map<Id,List<ZaikoData__c>> meisaiZaikoMap = new Map<Id,List<ZaikoData__c>>();
        
        // 受注明細データで繰り返し、受注明細データと在庫データマップを作成
        for(Integer i = 0, j = juchuMeisaiDatas.size(); i < j; i++) {
            List<ZaikoData__c> zaikoDatas = new List<ZaikoData__c>();
            
            for(Integer m = 0, n = zaikoDataAll.size(); m < n; m++){
                if(zaikoDataAll[m].JuchuMeisai__c == juchuMeisaiDatas[i].Id) {
                    zaikoDatas.add(zaikoDataAll[m]);
                }
            }
            meisaiZaikoMap.put(juchuMeisaiDatas[i].Id, zaikoDatas);
        }

        // 1ページ目のヘッダを設定
        pageData.headData = juchuData;
        Integer pageRows = 0;

        // 受注明細データで繰り返し
        for(Integer i = 0, j = juchuMeisaiDatas.size(); i < j; i++){
            
            // 受注明細データと入金データ
            DetailWrapper detailWrap = new DetailWrapper();
            
            // 受注明細データ
            detailWrap.meisaiData = juchuMeisaiDatas[i];
            
            // 品名をリスト化
            String hinmei = String.ValueOf(juchuMeisaiDatas[i].KariNohinshoHinmei__c);
            List <String> hinmeis = new List<String>();

            if(hinmei != null && hinmei.length() != 0) {
                hinmei = Strings.doInsertNewLineB(hinmei, nohinshoLineByteNum);
            
                hinmeis = hinmei.split('\n',0);
            }

            detailWrap.hinmeis = hinmeis;
            pageRows++;

            for(Integer m = 0, n = zaikoDataAll.size(); m < n; m++){
                if(zaikoDataAll[m].JuchuMeisai__c == juchuMeisaiDatas[i].Id) {
                    detailWrap.zaikoDatas.add(zaikoDataAll[m]);
                    pageRows++;

                    // 明細行数が最大行数に達した時　かつ　最後受注明細以外の場合
                    if(pageRows == pageDetailMaxRows && (i != (j-1)) ){
                        // ページデータに受注データと受注明細データを追加
                        pageData.detailDatas.add(detailWrap);
                        
                        // ページデータリストに追加
                        pageDatas.add(pageData);
                        
                        // 新しいページデータ作成
                        pageData = new PageData();
                        detailWrap = new DetailWrapper();
                        pageData.headData = juchuData;
                        pageData.pageNumber += pageDatas.size();
                        
                        pageRows = 0;
                    }
                }
            }
            
            // 一つの受注明細が２ページに分かれないように改ページを行う。（１明細でMAX行以上ある場合は仕方ないけど）
            // 明細の在庫データ数がページの残した行数に入れない場合、次のページに回す、最後の明細の場合、下記処理を行わない
            if( (i != (j-1)) && ((pageDetailMaxRows - pageRows) < (meisaiZaikoMap.get(juchuMeisaiDatas[i+1].Id).size()+1)) ) {
                // ページデータに受注データと受注明細データを追加
                        pageData.detailDatas.add(detailWrap);
                        
                        // ページデータリストに追加
                        pageDatas.add(pageData);
                        
                        // 新しいページデータ作成
                        pageData = new PageData();
                        detailWrap = new DetailWrapper();
                        pageData.headData = juchuData;
                        pageData.pageNumber += pageDatas.size();
                        
                        pageRows = 0;
            }
            
            // ページデータに受注データと受注明細データを追加
            pageData.detailDatas.add(detailWrap);
        }
        
        // ページデータリストに追加
        pageDatas.add(pageData);

        return pageDatas;
    }


    // 在庫データを取得する
    private List<ZaikoData__c> doSearchZaikoData(Id urlId) {
        
        // 在庫データ検索
        List<ZaikoData__c> zaikoDatas = [
                SELECT
                    Id,
                    Name,
                    JuchuMeisai__r.JuchuData__r.KariNohinshoTitle__c,               //仮納品書_タイトル
                    JuchuMeisai__r.JuchuData__r.KariNohinshoNohinMoto__c,           //仮納品書_納品元
                    JuchuMeisai__r.JuchuData__r.KariNohinshoNohinsakiMei1__c,       //仮納品書_納品先名１
                    JuchuMeisai__r.JuchuData__r.KariNohinshoNohinsakiMei2__c,       //仮納品書_納品先名２
                    JuchuMeisai__r.JuchuData__r.KariNohinshoNohinsakiDenwa__c,      //仮納品書_納品先電話
                    JuchuMeisai__r.JuchuData__r.KariNohinshoTokuisakiCD__c,         //仮納品書_得意先ＣＤ
                    JuchuMeisai__r.JuchuData__r.KariNohinshoTokuisakiCDTitle__c,    //仮納品書_得意先ＣＤタイトル
                    JuchuMeisai__r.JuchuData__r.KariNohinshoNohinsakiCD__c,         //仮納品書_納品先ＣＤ
                    JuchuMeisai__r.JuchuData__r.KariNohinshoNohinsakiCDTitle__c,    //仮納品書_納品先ＣＤタイトル
                    JuchuMeisai__r.JuchuData__r.KariNohinshoNohinbi__c,             //仮納品書_納品日
                    JuchuMeisai__r.JuchuData__r.KariNohinshoNohinbiTitle__c,        //仮納品書_納品日タイトル
                    JuchuMeisai__r.JuchuData__r.KariNohinshoDenpyoNo__c,            //仮納品書_伝票番号
                    JuchuMeisai__r.JuchuData__r.KariNohinshoDenpyoNoTitle__c,       //仮納品書_伝票番号タイトル
                    JuchuMeisai__r.JuchuData__r.KariNohinshoNyuryokusha__c,         //仮納品書_入力者
                    JuchuMeisai__r.JuchuData__r.KariNohinshoNyuryokushaTitle__c,    //仮納品書_入力者タイトル
                    JuchuMeisai__r.JuchuData__r.KariNohinshoKen__c,                 //仮納品書_検
                    JuchuMeisai__r.JuchuData__r.KariNohinshoKenTitle__c,            //仮納品書_検タイトル
                    JuchuMeisai__r.JuchuData__r.KariNohinshoShutsu__c,              //仮納品書_出
                    JuchuMeisai__r.JuchuData__r.KariNohinshoShutsuTitle__c,         //仮納品書_出タイトル
                    JuchuMeisai__r.JuchuData__r.KariNohinshoHassobi__c,             //仮納品書_発送日
                    JuchuMeisai__r.JuchuData__r.KariNohinshoGyoTitle__c,            //仮納品書_行タイトル
                    JuchuMeisai__r.JuchuData__r.KariNohinshoHinbanTitle__c,         //仮納品書_品番タイトル
                    JuchuMeisai__r.JuchuData__r.KariNohinshoHinmeiTitle__c,         //仮納品書_品名タイトル
                    JuchuMeisai__r.JuchuData__r.KariNohinshoShomiKigenTitle__c,     //仮納品書_賞味期限タイトル
                    JuchuMeisai__r.JuchuData__r.KariNohinshoSuryoTitle__c,          //仮納品書_数量タイトル
                    JuchuMeisai__r.JuchuData__r.KariNohinshoKikakuBikoTitle__c,     //仮納品書_規格備考タイトル
                    JuchuMeisai__r.JuchuData__r.KariNohinshoFooter__c,              //￥_仮納品書_フッタ
                    
                    JuchuMeisai__r.KariNohinshoHinban__c,                           //仮納品書_品番
                    JuchuMeisai__r.KariNohinshoHinmei__c,                          //仮納品書_品名
                    JuchuMeisai__r.KariNohinshoKikakuBiko__c,                      //仮納品書_規格備考
                    
                    KariNohinshoShomiKigen__c,                                      //仮納品書_賞味期限
                    KariNohinshoKikakuBiko__c,                                      //仮納品書_規格備考
                    KariNohinshoSuryo__c                                           //仮納品書_数量
                FROM
                    ZaikoData__c
                WHERE
                    JuchuMeisai__r.JuchuData__c = :urlId
                AND JuchuMeisai__r.NohinJogai__c = FALSE
                ORDER BY
                    JuchuMeisai__r.KariNohinshoHinban__c,                           //仮納品書_品番
                    KariNohinshoShomiKigen__c                                       //仮納品書_賞味期限
            ];
        return zaikoDatas;
    }


    // 受注明細データを取得する
    private List<JuchuMeisaiData__c> doSearchJuchuMeisai(Id urlId) {
        
        // 受注明細タデータ検索
        List<JuchuMeisaiData__c> juchuMeisais = [
                SELECT
                    Id,
                    Name,
                    KariNohinshoHinban__c,                           //仮納品書_品番
                    KariNohinshoHinmei__c,                          //仮納品書_品名
                    KariNohinshoKikakuBiko__c                       //仮納品書_規格備考
                FROM
                    JuchuMeisaiData__c
                WHERE
                    JuchuData__c = :urlId
                AND NohinJogai__c = FALSE
                ORDER BY
                    NarabiJun__c ASC
            ];
        return juchuMeisais;
    }
    

    // 受注データを取得する
    private JuchuData__c doSearchJuchuData(Id urlId) {
    
        JuchuData__c zaikoData = [
            SELECT
                Id,
                Name,
                KariNohinshoTitle__c,               //仮納品書_タイトル
                KariNohinshoNohinMoto__c,           //仮納品書_納品元
                KariNohinshoNohinsakiMei1__c,       //仮納品書_納品先名１
                KariNohinshoNohinsakiMei2__c,       //仮納品書_納品先名２
                KariNohinshoNohinsakiDenwa__c,      //仮納品書_納品先電話
                KariNohinshoTokuisakiCD__c,         //仮納品書_得意先ＣＤ
                KariNohinshoTokuisakiCDTitle__c,    //仮納品書_得意先ＣＤタイトル
                KariNohinshoNohinsakiCD__c,         //仮納品書_納品先ＣＤ
                KariNohinshoNohinsakiCDTitle__c,    //仮納品書_納品先ＣＤタイトル
                KariNohinshoNohinbi__c,             //仮納品書_納品日
                KariNohinshoNohinbiTitle__c,        //仮納品書_納品日タイトル
                KariNohinshoDenpyoNo__c,            //仮納品書_伝票番号
                KariNohinshoDenpyoNoTitle__c,       //仮納品書_伝票番号タイトル
                KariNohinshoNyuryokusha__c,         //仮納品書_入力者
                KariNohinshoNyuryokushaTitle__c,    //仮納品書_入力者タイトル
                KariNohinshoKen__c,                 //仮納品書_検
                KariNohinshoKenTitle__c,            //仮納品書_検タイトル
                KariNohinshoShutsu__c,              //仮納品書_出
                KariNohinshoShutsuTitle__c,         //仮納品書_出タイトル
                KariNohinshoHassobi__c,             //仮納品書_発送日
                KariNohinshoGyoTitle__c,            //仮納品書_行タイトル
                KariNohinshoHinbanTitle__c,         //仮納品書_品番タイトル
                KariNohinshoHinmeiTitle__c,         //仮納品書_品名タイトル
                KariNohinshoShomiKigenTitle__c,     //仮納品書_賞味期限タイトル
                KariNohinshoSuryoTitle__c,          //仮納品書_数量タイトル
                KariNohinshoKikakuBikoTitle__c,     //仮納品書_規格備考タイトル
                KariNohinshoFooter__c               //￥_仮納品書_フッタ
            FROM
                JuchuData__c
            WHERE
                Id = :urlId
        ];
        return zaikoData;
    }

    /** ページデータクラス */
    public class PageData {
        public Integer pageNumber { get; private set; }
        public JuchuData__c headData{ get; set; }
        public List<DetailWrapper> detailDatas{ get; private set; }
        
        public PageData(){
            this.pageNumber = 1;
            this.detailDatas = new List<DetailWrapper>();
        }
    }
    
    
    /** ラッパークラス */
    public class DetailWrapper {
        public JuchuMeisaiData__c meisaiData { get; set; }
        public List<ZaikoData__c> zaikoDatas { get; set; }
        public List<String> hinmeis { get; set; }
        
        public DetailWrapper(){
            this.zaikoDatas = new List<ZaikoData__c>();
        }
    }
    
    
}