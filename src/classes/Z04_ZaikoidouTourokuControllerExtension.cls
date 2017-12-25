public class Z04_ZaikoidouTourokuControllerExtension {

    /** エラーメッセージ：リスト未選択*/
    private String LIST_KUUHAKU = 'リストが選択されていません。キャンセルしリストを選択して下さい。';
    /** エラーメッセージ：入庫数量が未入力またはゼロ */
    private String SURYO_KUUHAKU = 'の移動数量を入力してください。';
    /** エラーメッセージ：在庫が不足 */
    private String ZAIKO_HUSOKU = 'の在庫が不足しています。';
    /** エラーメッセージ：移動予定日が空白 */
    private String IDOU_KUUHAKU = 'の移動予定日を入力してください。';
    /** エラーメッセージ：移動場所が空白*/
    private String BASHO_KUUHAKU = 'の移動場所を入力してください。';

    /** 選択済リスト */
    public List<ZaikoData__c> selectedZaiko{get; set;}

    /** 表示用在庫リスト */
    public List<dispZaiko> targetDispZaikoList{get; set;}
    
    /** ページ側 移動先(一括指定)と予定日(一括指定)*/
    public ZaikoData__c allSelect{get; set;}

    /** ページ側 全数移動(一括指定)*/
    public Boolean allMove{get; set;}

    /** 処理が終わった後の遷移先 */
    public String retUrlString;
    
    /** エラーメッセージ */
    public List<String> errorMessageList;
    
    /** コンストラクタ */
    public Z04_ZaikoidouTourokuControllerExtension(ApexPages.StandardSetController controller) {

        // 遷移元に代入
        retUrlString = ApexPages.CurrentPage().getParameters().get('retUrl');

        // ページ側 一括指定用
        allSelect = new ZaikoData__c();

        // リストで選択されている一覧を取得
        selectedZaiko = (List<ZaikoData__c>) controller.getSelected();
        
    }
    
    /*
     * 表示用一覧の初期化処理
     */
    public void init(){
        
        // 画面表示用のリストを作成
        targetDispZaikoList = new List<dispZaiko>();

        // 1件以上リストで選択されている場合
        if(!selectedZaiko.isEmpty()){

            // リストで選択されている一覧からIdマップを作成
            Set<Id> oldZaikoDataIds = new Set<Id>();
            for (ZaikoData__c oldZaikoData :selectedZaiko){
                oldZaikoDataIds.add(oldZaikoData.Id);
            }

            // リストで選択されているレコード一覧をIdマップから作成
            List<ZaikoData__c> oldZaikoDataList = new List<ZaikoData__c>();
            oldZaikoDataList = [SELECT Id,Name,Zaikobasho__c,Zaikobasho__r.Name,ZaikoSuryo__c,ShohinShizaiM__c,ShomiKigen__c FROM ZaikoData__c WHERE Id IN :oldZaikoDataIds AND ZaikoSuryo__c > 0 ORDER BY Zaikobasho__c,Name];

            // 画面表示用のリストに追加
            targetDispZaikoList = new List<dispZaiko>();
            for(ZaikoData__c oldZaikoData :oldZaikoDataList){
                dispZaiko dispZaiko = new dispZaiko();
                dispZaiko.oldZaiko = oldZaikoData;
                targetDispZaikoList.add(dispZaiko);
            }

        }

        // １件も取得できなかった場合
        if (targetDispZaikoList.isEmpty()){
            // エラー表示する
            ApexPages.Message message = new ApexPages.Message( ApexPages.severity.ERROR, LIST_KUUHAKU);
            ApexPages.addMessage(message);
        }

    }
    
    /**
     * 移動実行ボタンが押された時の処理
     */
    public void jikkouButton(){

        // 	移動先(一括指定) が入力されている場合、移動先（個別指定）が空白の物を上書きする。
        if(!String.isEmpty(allSelect.zaikoBasho__c)){
            for(dispZaiko item :targetDispZaikoList){
                if(String.isEmpty(item.newZaiko.zaikoBasho__c)){
                    item.newZaiko.ZaikoBasho__c = allSelect.zaikoBasho__c;
                }
            }
        }

        // 予定日(一括指定) が未来日で入力されている場合、未来日の予定日が未入力の物を上書きする。
        if( System.today() <= allSelect.ZenShukkoNichiji__c){
            for(dispZaiko item :targetDispZaikoList){
                if( System.today() <= item.newZaiko.ZenShukkoNichiji__c){
                } else{
                    item.newZaiko.ZenShukkoNichiji__c = allSelect.ZenShukkoNichiji__c;
                }
            }
        }

        // 全数移動(一括指定) ONの場合は上書きする。
        if( allMove ){
            for(dispZaiko item :targetDispZaikoList){
                if( item.idouSuryo > 0){
                } else {
                    item.zensuIdou = true;
                }
            }
        }
                
        // 入力チェックの結果がエラーなしの場合
        if(checkInput(targetDispZaikoList)){

            // アップサートする在庫データ
            List<ZaikoData__c> upsZaikoList = new List<ZaikoData__c>();
            
            // 在庫データ毎に実行
            for(dispZaiko item :targetDispZaikoList){
                
                // 除外（移動対象外）でない場合は更新用リストに追加
                if (!item.idouTaisyogai){
                    
                    // 在庫データ（子）を作成
                    ZaikoData__c zaikoChild = new ZaikoData__c();
                    zaikoChild.ZenShukkoNichiji__c = item.newZaiko.ZenShukkoNichiji__c;
                    zaikoChild.ZenZaikoData__c = item.oldZaiko.Id;
                    zaikoChild.zaikoBasho__c = item.newZaiko.zaikoBasho__c;
                    zaikoChild.ShohinShizaiM__c = item.oldZaiko.ShohinShizaiM__c;
                    zaikoChild.ShomiKigen__c = item.oldZaiko.ShomiKigen__c;
                    zaikoChild.ShukkoFlg__c = true;
                    
                    // 全部移動チェックがfalse
                    if(!item.zensuIdou){
                        zaikoChild.ZenShukkoSuryo__c = item.idouSuryo;
                    // 全部移動チェックがtrue
                    }else{
                        zaikoChild.ZenShukkoSuryo__c = item.oldZaiko.ZaikoSuryo__c;
                    }
                    
                    upsZaikoList.add(zaikoChild);
                    
                    // 全数移動チェックがfalse
                    if(!item.zensuIdou){
                        // 在庫データ（親）の在庫数量から移動分を減算
                        item.oldZaiko.ZaikoSuryo__c = item.oldZaiko.ZaikoSuryo__c -item.idouSuryo;
                    // 全数移動チェックがtrue
                    }else{
                        // 在庫データ（親）の在庫数量に０：ゼロ個を設定
                        item.oldZaiko.ZaikoSuryo__c = 0;
                    }
                    upsZaikoList.add(item.oldZaiko);
                    
                }
                
            }

            // アップサートする在庫データが空ではない（エラーなしで移動が行われる）場合
            if (!upsZaikoList.isEmpty()){
                // 在庫データ（親）と　在庫データ（子）を更新/作成
                upsert upsZaikoList;
                // 初期化を実行
                init();
                // クリアーを実行
                clear();
                // 在庫データを洗替するバッチを起動
                updateZaikoBatch();
            }

        }
        
        for(String item :errorMessageList){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, item));
        }

    }
    
    /**
     * キャンセルボタンが押された時の処理
     */
    public pageReference cancelButton(){
        return new PageReference(retUrlString);
    }

    /**
     * クリアボタンが押された時の処理
     */
    public void clearButton(){
        init();
        clear();
    }

    /**
     * クリア処理
     */
    public void clear(){

        // 画面表示用のリストを空白で初期化
        for (dispZaiko dispZaiko :targetDispZaikoList){
            dispZaiko.idouTaisyogai = false;
            dispZaiko.idouSuryo = null;
            dispZaiko.zensuIdou = false;
            dispZaiko.newZaiko.Zaikobasho__c = null;
            dispZaiko.newZaiko.ZenShukkoNichiji__c = null;
        }
        // 画面側の値を空白で初期化
        allSelect.zaikoBasho__c = null;
        allSelect.ZenShukkoNichiji__c = null;
        allMove = false;
        
    }
    
    /**
     * 入力チェックする処理
     */
    private Boolean checkInput(List<dispZaiko> inputData){

        Boolean retFlg = true;
        errorMessageList = new List<String>();
        
        // 画面で入力したデータを順に処理
        for(dispZaiko item :inputData){

            // 除外がONの場合は入力チェックは行わない
            if (item.idouTaisyogai){

            // 除外がOFFの場合は以下の入力チェックを行う
            }else{

                // 全部移動チェックがfalseかつ(移動数量が空白またはゼロ)
                if(!item.zensuIdou && (String.isEmpty(String.valueOf(item.idouSuryo)) || item.idouSuryo == 0)){
                    errorMessageList.add(item.oldZaiko.Name + SURYO_KUUHAKU);
                    retFlg = false;
                }
                // 在庫数量<移動数量の場合エラー
                if(item.oldZaiko.zaikoSuryo__c < item.idouSuryo){
                    errorMessageList.add(item.oldZaiko.Name + ZAIKO_HUSOKU);
                    retFlg = false;
                }
                // 移動場所が空白の場合エラー
                if(String.isEmpty(item.newZaiko.zaikoBasho__c)){
                    errorMessageList.add(item.oldZaiko.Name + BASHO_KUUHAKU);
                    retFlg = false;
                }
                // 移動予定日が空白の場合エラー
                if((item.newZaiko.ZenShukkoNichiji__c) == null){
                    errorMessageList.add(item.oldZaiko.Name + IDOU_KUUHAKU);
                    retFlg = false;
                }
                
            }
        }
        return retFlg;
    }

    
    /**
     * 在庫データを洗替するバッチを起動する処理
     */
    public void updateZaikoBatch(){

        // バッチサイズを指定
        Integer batchSize = 100;

        // バッチをキックする
        Id batchId = Database.executeBatch(new Y06_UpdateZaikoDataBatch(), batchSize);
        System.debug('*** batchId = ' + batchId);

        List<AsyncApexJob> asyncApexJobList = new List<AsyncApexJob>();
        asyncApexJobList = [SELECT Id,ParentJobId,Status,JobType,CreatedDate,CompletedDate FROM AsyncApexJob WHERE ParentJobId = :batchId OR Id = :batchId];
        if(!asyncApexJobList.isEmpty()){
            for(AsyncApexJob aaJob :asyncApexJobList){
                System.debug('*** AsyncApexJob = ' + aaJob);
                
            }
        }
    }
    

    /**
     * 画面に表示する在庫データ
     */
    public class dispZaiko{

        public Boolean idouTaisyogai{get; set;}
        public Boolean zensuIdou{get; set;}
        public Integer idouSuryo{get; set;}
        public ZaikoData__c oldZaiko{get; set;}
        public ZaikoData__c newZaiko{get; set;}
        
        /** コンストラクタ */
        public dispZaiko(){
            newZaiko = new ZaikoData__c();
        }

    }

}