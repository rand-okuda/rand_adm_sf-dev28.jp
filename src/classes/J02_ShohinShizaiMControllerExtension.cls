public with sharing class J02_ShohinShizaiMControllerExtension {

    /** 定数 */

    // 受注明細一括追加上限 カスタム設定：システム設定：組織のデフォルトを取得
    SystemParam__c sc = SystemParam__c.getOrgDefaults();
    private Integer OrderDetailsBulkAddLimit = sc.JuchuMeisaiIkkatsuTsuikaJogen__c.intValue();

    //現在のガバナリミットSystem.limits.getLimitQueryRowsを取得
    Integer limitQueryRows = System.limits.getLimitQueryRows() / 8;

    // 取引先単価マスタが存在しない場合のワーニングメッセージ
    private final String TANKAM_ERROR_MESSAGE = ' は取引先条件マスタが存在していません。';
    // 既に追加している商品資材を追加しようとした場合のワーニングメッセージ 
    private final String DUPLICATE_NG_ERROR_MESSAGE = ' は既に追加済みの商品のため追加不可です。';
    // 既に追加している商品資材が明細重複許可の場合のワーニングメッセージ 
    private final String DUPLICATE_OK_ERROR_MESSAGE = ' は既に追加済みの商品ですが重複可能です。';
    // 受注明細一括追加上限以上の明細を同時に追加した場合のワーニングメッセージ 
    private final String TOOMANY_ERROR_MESSAGE = '明細の同時追加は'+ OrderDetailsBulkAddLimit +'件以下です。';

    /** プロパティ */

    //画面遷移時の受注データID
    public Id currentJuchuDataId;
    //画面遷移時の取引先マスタID
    public Id currentAccountId;

	//受注先に紐づく全　受注データ一覧
	public List<JuchuData__c> allJuchuDataList {get; set;}
	//受注先に紐づく全　受注明細データ一覧
	public List<JuchuMeisaiData__c> allJuchuMeisaiList {get; set;}
	//受注先に紐づく全　商品資材マスタ一覧
	public List<ShohinShizaiM__c> allShohinShizaiList {get; set;}
	//受注先に紐づく全　構成工程マスタ一覧（推奨）
	public List<KoteiKoseiM__c> allKoteiKoseiOkList {get; set;}
	//受注先に紐づく全　構成工程マスタ一覧（禁止）
	public List<KoteiKoseiM__c> allKoteiKoseiNgList {get; set;}

    //既に登録されている商品資材マスタ一覧（受注先）
    public List<JuchuMeisaiData__c> allAlreadyJuchuMeisaiList {get; set;}
    //既に登録されている商品資材マスタ一覧（受注データ）
    public List<JuchuMeisaiData__c> partAlreadyJuchuMeisaiList {get; set;}

    //工程構成マスタ一覧レンダリング切替用
    public Boolean isRenderedKoteiKosei {get; set;}
    //受注明細データ（受注データ配下）一覧レンダリング切替用
    public Boolean isRenderedJuchuMeisai {get; set;}
    //商品資材マスタ一覧レンダリング切替用
    public Boolean isRenderedShohinShizai {get; set;}

    //重複確認用受注明細データの一覧
    public List<JuchuMeisaiData__c> alreadyShohinShizaiList;

    //現在の受注データに紐づく受注明細データの有無
    public Boolean isExistAlreadyShohinShizaiList;

    // 商品資材マスタのリストビュー上で選択されたレコード
    public List<ShohinShizaiM__c> selectRecords {get; private set;}

    //** インスタンス変数 */

    // 処理が終わった後の遷移先
    public String retUrlString;
    // ログインユーザのID
    public Id userId;


    // コンストラクタ
    public J02_ShohinShizaiMControllerExtension(ApexPages.StandardSetController controller) {

        // ログインユーザの情報を取得
        this.userId = UserInfo.getUserId();
        
        // リストで選択されている値を取得
        this.selectRecords=(List<ShohinShizaiM__c>)controller.getSelected();

    }
    
    /** パブリックメソッド */
    
    /*
     * 商品資材リスト画面を開いた時の初期化処理
     */
    public PageReference init(){

        // 画面起動時の取引先IDパラメータを取得（文字列取得）
        String getParamCurrentAccountId = ApexPages.CurrentPage().getParameters().get('accountId');
        //ID値の検証を15文字以上で確認
        if(getParamCurrentAccountId.length() >= 15){
            currentAccountId = getParamCurrentAccountId;
        }

        // 画面起動時の受注データIDパラメータを取得（文字列取得）
        String getParamCurrentJuchuDataId = ApexPages.CurrentPage().getParameters().get('juchuId');
        //ID値の検証を15文字以上で確認
        if(getParamCurrentJuchuDataId.length() >= 15){
            currentJuchuDataId = getParamCurrentJuchuDataId;
        }


        /**　カスタム設定からのセッションデータ取得と設定　**/

        // 受注データと取引先両方のパラメータがnullではない場合
        if(currentJuchuDataId != null || currentAccountId != null){

            // カスタム設定：セッションデータにデータが存在するかチェック
            List<SessionsData__c> existSessionsData = [SELECT Id FROM SessionsData__c WHERE SetupOwnerId = :this.userId];

            SessionsData__c sd;
            // カスタム設定が存在する場合
            if(existSessionsData.size() > 0){
                //セッション情報を取得
                sd = SessionsData__c.getInstance(this.userId);
            // カスタム設定が存在しない場合
            }else{
                //セッション情報を新規作成
                sd = new SessionsData__c();
                sd.SetupOwnerId = userId;
            }
        
            // セッション情報を設定（カスタム設定は文字列のため文字列を代入）
            sd.JuchuDataId__c = getParamCurrentJuchuDataId;
            sd.AccountId__c = getParamCurrentAccountId;

            // セッション情報をupsert
            upsert sd;

        }

        
        /**　受注明細一括追加時のガイド用各種一覧取得　**/

        //画面起動時の受注データIDが空白ではない場合
        if(currentJuchuDataId != null){
            //画面起動時の受注データから受注先IDを取得
            JuchuData__c currentJuchuData = [SELECT Id, name, Juchusaki__c FROM JuchuData__c WHERE Id = :currentJuchuDataId LIMIT 1];
            //取得取引先に紐づくガイド用受注データ取得
            allJuchuDataList =  [SELECT Id, name, Juchusaki__c, JuchusakiChofukuJogaiFlg__c FROM JuchuData__c WHERE Juchusaki__c = :currentJuchuData.Juchusaki__c LIMIT :limitQueryRows];
        //画面起動時の取引先IDが空白ではない場合
        }else if(currentAccountId != null){
            //取引先に紐づくガイド用受注データ取得
            allJuchuDataList =  [SELECT Id, name, Juchusaki__c, JuchusakiChofukuJogaiFlg__c FROM JuchuData__c WHERE Juchusaki__c = :currentAccountId LIMIT :limitQueryRows];
        }
        
        //取得受注データに紐づくガイド用受注明細データ取得
        Set<String> jdIDs = new Set<String>();
        for(JuchuData__c jd :allJuchuDataList){
            jdIDs.add(jd.Id);
        }
        allJuchuMeisaiList = [SELECT Id, name, JuchuData__c, ShohinShizaiM__c, JuchuSuryo__c FROM JuchuMeisaiData__c WHERE JuchuData__c = :jdIDs LIMIT :limitQueryRows];

        //取得受注明細データが紐づくガイド用商品資材マスタ取得
        Set<String> ssmIDs = new Set<String>();
        for(JuchuMeisaiData__c jm :allJuchuMeisaiList){
            ssmIDs.add(jm.ShohinShizaiM__c);
        }
            allShohinShizaiList = [SELECT Id, name, ShohinShizaimeiHyoji__c, ShohinShizaiKubun__c, Biko__c, ShohinShizaiCode__c, ShubaiFlg__c FROM ShohinShizaiM__c WHERE Id = :ssmIDs AND ShubaiFlg__c = false ORDER BY ShohinShizaimeiHyoji__c LIMIT :limitQueryRows];

        //商品資材マスタが取得できた場合
        if(allShohinShizaiList.size() != 0){
            //商品資材マスタ一覧レンダリング切替用フラグTRUE
            isRenderedShohinShizai = true;
        }

        //取得商品資材マスタ取得に紐づくガイド用構成工程マスタ取得（OK組合）
        allKoteiKoseiOkList = [SELECT Id, name, OyaShohinShizaiM__r.ShohinShizaimeiHyoji__c, KoteiKoseiKaisetsu__c FROM KoteiKoseiM__c WHERE OyaShohinShizaiM__c = :ssmIDs AND JuchuMeisaiTsuikaGaido__c = true AND KumiawaseOKFlg__c = true AND KumiawaseNGFlg__c = false ORDER BY KoteiKoseiKaisetsu__c LIMIT :limitQueryRows];

        //取得商品資材マスタ取得に紐づくガイド用構成工程マスタ取得（NG組合）
        allKoteiKoseiNgList = [SELECT Id, name, OyaShohinShizaiM__r.ShohinShizaimeiHyoji__c, KoteiKoseiKaisetsu__c FROM KoteiKoseiM__c WHERE OyaShohinShizaiM__c = :ssmIDs AND JuchuMeisaiTsuikaGaido__c = true AND KumiawaseOKFlg__c = false AND KumiawaseNGFlg__c = true ORDER BY KoteiKoseiKaisetsu__c LIMIT :limitQueryRows];

        //構成工程マスタ取得ができた場合
        if(allKoteiKoseiOkList.size() != 0 || allKoteiKoseiNgList.size() !=0){
            //構成工程マスタ一覧レンダリング切替用フラグTRUE
            isRenderedKoteiKosei = true;
        }

        //既に登録されている受注明細データ一覧を取得（受注先配下）
        allAlreadyJuchuMeisaiList = [SELECT Id, NisugataSanko__c, MeyasuZan__c, ShohinShizaiM__r.ShohinShizaimeiHyoji__c FROM JuchuMeisaiData__c WHERE JuchuData__c IN :allJuchuDataList ORDER BY ShohinShizaiM__r.ShohinShizaimeiHyoji__c LIMIT :limitQueryRows];

        //既に登録されている受注明細データ一覧を取得（受注データ配下）
        partAlreadyJuchuMeisaiList = [SELECT Id, NisugataSanko__c, MeyasuZan__c, Biko__c, ShohinShizaiM__r.ShohinShizaimeiHyoji__c FROM JuchuMeisaiData__c WHERE JuchuData__c = :currentJuchuDataId ORDER BY ShohinShizaiM__r.ShohinShizaimeiHyoji__c LIMIT :limitQueryRows];                        

        //受注明細データ（受注データ配下）取得ができた場合
        if(partAlreadyJuchuMeisaiList.size() != 0){
            //受注明細データ（受注データ配下）一覧レンダリング切替用フラグTRUE
            isRenderedJuchuMeisai = true;
        }

        /**　構成工程マスタ　構成工程解説　を受注データ　警告：構成＋　に記入　**/

        //現在の受注データを取得
        List<JuchuData__c> updateJuchuDataList = [SELECT Id, name, KoteiKoseiMemoALL__c FROM JuchuData__c WHERE Id = :currentJuchuDataId LIMIT 1];
        //現在の受注データが取得出来た場合
        if(updateJuchuDataList.size() != 0){
            //現在の受注データを代入
            JuchuData__c updateJuchuData = updateJuchuDataList[0];
            //警告：構成＋をに空白を代入
            updateJuchuData.KoteiKoseiMemoALL__c = '';
            //取得したガイド用構成工程マスタを順に処理（NG組合）
            for(KoteiKoseiM__c allKoteiKoseiOk :allKoteiKoseiOkList){
                updateJuchuData.KoteiKoseiMemoALL__c += '\n' + allKoteiKoseiOk.KoteiKoseiKaisetsu__c + ',';
            }
            //取得したガイド用構成工程マスタを順に処理（OK組合）
            for(KoteiKoseiM__c allKoteiKoseiNg :allKoteiKoseiNgList){
                updateJuchuData.KoteiKoseiMemoALL__c += '\n' + allKoteiKoseiNg.KoteiKoseiKaisetsu__c + ',';
            }
            //受注データを更新
            update updateJuchuData;
        }

        return null;

    }


    /*
     * 商品資材一括登録ボタンが押下された時の処受注明細データの作成
     */
    public PageReference ikkatsuHensyuButton(){

        // retUrlの初期値を設定
        retUrlString = ApexPages.CurrentPage().getParameters().get('retUrl');

        // セッションデータが存在したか
        Boolean isGetSessionData = false;

        // カスタム設定：セッションデータを取得
        List<SessionsData__c> existSessionsData = [SELECT Id FROM SessionsData__c WHERE SetupOwnerId = :this.userId];

        SessionsData__c sd;
 
        //セッションデータが存在する場合
        if(existSessionsData.size() > 0){
            // セッションデータを取得
            sd = SessionsData__c.getInstance(this.userId);
            isGetSessionData = true;
        }

        // セッションデータが存在する場合
        if(isGetSessionData){
            // かつ　受注データの画面より遷移している場合（カスタム設定はNULL文字列のため文字列比較）
            if(sd.JuchuDataId__c != 'null' && sd.AccountId__c == 'null'){
                createMeisaiFromJuchu(sd.JuchuDataId__c);
                retUrlString = '/' + sd.JuchuDataId__c;
            // かつ　取引先の画面より遷移した場合（カスタム設定はNULL文字列のため文字列比較）
            } else if(sd.JuchuDataId__c == 'null' && sd.AccountId__c != 'null'){
                retUrlString = createMeisaiFromAccount(sd.AccountId__c);
            }

            //セッションデータを削除
            delete sd;
        }

        //遷移元に画面遷移
        return new PageReference(retUrlString);

    }

    
    /** プライベートメソッド */

    
    /*
     * 受注データの詳細画面より遷移した場合の受注明細データの作成
     */
    public void createMeisaiFromJuchu(String juchuId ){
        
        // 受注データのレコードを取得
        JuchuData__c currentJuchu = new JuchuData__c();
        currentJuchu = [SELECT id, name, JuchusakiChofukuJogaiFlg__c, TourokuMemo__c, TourokuMemoALL__c, UrikakeData__c, NohinsakiShokai__c, UrikakeDataShokaibi__c FROM JuchuData__c WHERE Id = :juchuId LIMIT 1];

        // 売掛データのレコードを取得
        UrikakeData__c currentUrikake = new UrikakeData__c();
        currentUrikake = [SELECT Id, name, ShimeKikanKara__c, ShimeKikanMade__c, SeikyuAccount__c FROM UrikakeData__c u WHERE Id = :currentJuchu.UrikakeData__c LIMIT 1];

        // 請求先レコードを取得
        Account currentSeikyusaki = new Account();
        currentSeikyusaki = [SELECT id, name, SeikyusakiShokai__c, AccountTankaMHuyouFlg__c FROM Account WHERE Id = :currentUrikake.SeikyuAccount__c LIMIT 1];

        // ワーニングメッセージ受け取り用変数
        String errorMessage = '';
        
        // 受注明細作成
        errorMessage = insertJuchuMeisai(currentJuchu, currentUrikake, currentSeikyusaki.AccountTankaMHuyouFlg__c);
        
        // 取引先単価マスタが取得できない商品資材が有った場合に警告：登録＋に書き込む
        if(!String.isBlank(errorMessage)){
            currentJuchu.TourokuMemoALL__c = errorMessage;
        }

        update currentJuchu;

    }

    
    /*
     * 取引先の詳細画面より遷移した場合に実行される売掛データ、受注データ、受注明細データの作成
     */
    public String createMeisaiFromAccount(String accountId){
        
        // 作成または、取得した売掛データ
        UrikakeData__c currentUrikake;
        
        // 請求先のレコードを取得
        Account currentSeikyusaki = [SELECT id, name, SeikyusakiShokai__c, AccountTankaMHuyouFlg__c FROM Account WHERE Id = :accountId LIMIT 1];

        // 売掛データを検索し取得
        List<UrikakeData__c> urikakeList = [SELECT Id, name, ShimeKikanKara__c, ShimeKikanMade__c, SeikyuAccount__c FROM UrikakeData__c u WHERE SeikyuAccount__c = :currentSeikyusaki.SeikyusakiShokai__c AND ShimeKikanKara__c <= TODAY AND ShimeKikanMade__c >= TODAY LIMIT 1];
        if(urikakeList.size() == 0){
            // 売掛データが存在しない場合売掛データを作成する。
            currentUrikake = new UrikakeData__c(name = 'XXX', SeikyuAccount__c = currentSeikyusaki.SeikyusakiShokai__c, ShimeHizuke__c = Date.today());
            insert currentUrikake;
        }else{
            // 売掛データが存在した場合紐付対象の売掛データとする。
            currentUrikake = urikakeList[0];
        }
        
        // 受注データを作成
        JuchuData__c insJuchuData = new JuchuData__c(UrikakeData__c = currentUrikake.id, name = 'XXX', Juchusaki__c = currentSeikyusaki.Id);
        insert insJuchuData;
        
        // ワーニングメッセージ受け取り用変数
        String errorMessage = '';
        
        // 商品資材を一件以上選択している場合のみ受注明細データを作成
        if(!this.selectRecords.isEmpty()){
            errorMessage = insertJuchuMeisai(insJuchuData, currentUrikake, currentSeikyusaki.AccountTankaMHuyouFlg__c);
        }

        // 取引先単価マスタが取得できない商品資材が有った場合に登録＋に書き込む
        if(!String.isBlank(errorMessage)){
            insJuchuData.TourokuMemoALL__c = errorMessage;
            update insJuchuData;
        }
        
        // 作成した受注データのIDを返す
        return '/' + insJuchuData.Id;

    }

    
    /*
     * 受注明細データをインサートする処理
     */
    public String insertJuchuMeisai(JuchuData__c currentJuchu, UrikakeData__c currentUrikake, Boolean accountTankaMHuyouFlg){

        // 受注明細データインサート用リスト
        List<JuchuMeisaiData__c> insJuchuMeisaiList = new List<JuchuMeisaiData__c>();

        // 受注明細データを作成対象外の商品資材マスタのレコード
        List<ShohinShizaiM__c> excludeShohinShizaiList = new List<ShohinShizaiM__c>();

        // 返却用ワーニングメッセージ
        String retErrorMessage = '';
        
        // 画面で選択した商品資材のIDのリスト
        List<Id> selectedShohinIdList = new List<Id>();
        for(ShohinShizaiM__c item :this.selectRecords){
            selectedShohinIdList.add(item.Id);
        }
        
        // 画面で選択した商品資材の内容を取得
        List<ShohinShizaiM__c> selectedShohinList = new List<ShohinShizaiM__c>();
        selectedShohinList = [SELECT Id, Name, AccountTankaMHuyouFlg__c, MeisaiChofukuKyokaFlg__c FROM ShohinShizaiM__c WHERE Id IN :selectedShohinIdList];

        /**取引先単価マスタが存在するかのチェック*/

        // 取引先objの単価マスタ不要フラグがfalseの場合
        if(!accountTankaMHuyouFlg){

            //画面で選択した商品資材を順に処理
            for(ShohinShizaiM__c item :selectedShohinList){

                // 商品資材objの単価マスタ不要フラグもfalseの場合
                if(!item.AccountTankaMHuyouFlg__c){

                    // 取引先から遷移した場合は、必ず納品日予定日と納品完了日がnullなので、todayを代入
                    Date tmpUrikakeDataShokaibi;
                    if(currentJuchu.NohinsakiShokai__c != null){
                      tmpUrikakeDataShokaibi = currentJuchu.urikakeDataShokaibi__c;
                    }else{
                      tmpUrikakeDataShokaibi = date.today();
                    }

                    // 画面で選択した商品資材の単価マスタ取得
                    List<AccountTankaM__c> accountTanka = new List<AccountTankaM__c>();
                    accountTanka = [SELECT Id FROM AccountTankaM__c WHERE ShohinShizaiM__c = :item.Id AND Account__c = :currentUrikake.SeikyuAccount__c AND TekiyoKikanKara__c <= :tmpUrikakeDataShokaibi AND TekiyoKikanMade__c >= :tmpUrikakeDataShokaibi LIMIT 1];

                    // 画面で選択した商品資材の単価マスタが存在しなかった場合
                    if(accountTanka.isEmpty()){                        
                        // ワーニングメッセージを精製
                        retErrorMessage += item.Name + TANKAM_ERROR_MESSAGE + '\n';
                    }
                }
            }
        }

        /**重複除外対象の受注明細データが存在するかのチェック*/

        //セッションデータを取得
        SessionsData__c sd = SessionsData__c.getInstance(this.userId);

        //受注データIDが存在した場合
        if(sd.JuchuDataId__c != 'null'){
            //受注データを取得
            JuchuData__c JuchuData = [SELECT Id, Name, Juchusaki__c, JuchusakiChofukuJogaiFlg__c FROM JuchuData__c WHERE Id = :sd.JuchuDataId__c LIMIT 1];
            //受注データの受注先重複除外モードがTRUEの場合
            if(JuchuData.JuchusakiChofukuJogaiFlg__c){
                //受注先を取得
                Account Juchusaki = [SELECT Id, Name FROM Account WHERE Id = :JuchuData.Juchusaki__c LIMIT 1];
                //受注先に紐づく全受注データを取得
                List<JuchuData__c> JuchuDataList  = [SELECT Id, Name FROM JuchuData__c WHERE Juchusaki__c = :Juchusaki.Id LIMIT :limitQueryRows];
                //全受注データに紐づく受注明細データを取得
                alreadyShohinShizaiList = [SELECT Id, Name, ShohinShizaiM__r.name FROM JuchuMeisaiData__c WHERE JuchuData__c IN :JuchuDataList LIMIT :limitQueryRows];
                isExistAlreadyShohinShizaiList = true;
            //受注データの受注先重複除外モードがFALSEの場合
            }else{
                //現在の受注データに紐づく受注明細データを取得
                alreadyShohinShizaiList = [SELECT Id, Name, ShohinShizaiM__r.name FROM JuchuMeisaiData__c WHERE JuchuData__c = :JuchuData.Id LIMIT :limitQueryRows];
                isExistAlreadyShohinShizaiList = true;
            }
        //取引先IDが存在した場合
        }else if(sd.AccountId__c != 'null'){
            //受注先を取得
            Account Juchusaki = [SELECT Id, Name FROM Account WHERE Id = :sd.AccountId__c LIMIT 1];
            //受注先に紐づく全受注データを取得
            List<JuchuData__c> JuchuDataList = [SELECT Id, Name, JuchusakiChofukuJogaiFlg__c FROM JuchuData__c WHERE Juchusaki__c = :Juchusaki.Id LIMIT :limitQueryRows];
            //受注データの受注先重複除外モードがTRUEの場合
            if(JuchuDataList[0].JuchusakiChofukuJogaiFlg__c){
                //全受注データに紐づく受注明細データを取得
                alreadyShohinShizaiList = [SELECT Id, Name, ShohinShizaiM__r.name FROM JuchuMeisaiData__c WHERE JuchuData__c IN :JuchuDataList LIMIT :limitQueryRows];                
                isExistAlreadyShohinShizaiList = true;
            //受注データの受注先重複除外モードがFALSEの場合
            }else{
                //受注データ未作成のため実行無
                isExistAlreadyShohinShizaiList = false;
            }
        }

        //既存の重複除外対象が存在していた場合
        if(isExistAlreadyShohinShizaiList){
            // 画面で選択した商品資材の内容を順に処理
            for(ShohinShizaiM__c selectedItem :selectedShohinList){
                //既に登録されている商品資材を順に処理
                for(JuchuMeisaiData__c alreadyItem :alreadyShohinShizaiList){
                    // IDが一緒で既に登録済みの場合
                    if(selectedItem.Id.equals(alreadyItem.ShohinShizaiM__r.Id)){

                        //受注明細作成対象外一覧に商品資材を追加
                        excludeShohinShizaiList.add(selectedItem);

                        //明細重複許可フラグTRUEの商品の場合
                        if(selectedItem.MeisaiChofukuKyokaFlg__c){
                            // 重複OKのワーニングメッセージ
                            retErrorMessage += selectedItem.Name + DUPLICATE_OK_ERROR_MESSAGE + '\n';                            
                        //明細重複許可フラグFALSEの商品の場合
                        }else{
                            // 重複NGのワーニングメッセージ
                            retErrorMessage += selectedItem.Name + DUPLICATE_NG_ERROR_MESSAGE + '\n';
                        }

                    }                    
                }
            }
        }

        /**画面で選択した商品資材を元に受注明細データを作成*/

        //画面で選択した商品資材の一覧を順に処理
        for(ShohinShizaiM__c item :selectedShohinList){
            
            Boolean isExcludedItem = false;

            //受注明細データ作成対象外一覧を順に処理
            for(ShohinShizaiM__c excludeitem : excludeShohinShizaiList){
                //画面で選択した商品資材が受注明細データ作成対象外の場合
                if(item.Id == excludeitem.Id){
                    isExcludedItem = true;
                }
            }
            
            //画面で選択した商品資材が受注明細データ作成対象外では無い場合
            if(!isExcludedItem){
                //受注明細データインサート用リストに追加
                insJuchuMeisaiList.add(new JuchuMeisaiData__c(name = 'XXX', JuchuData__c = currentJuchu.Id, ShohinShizaiM__c = item.Id));
            //画面で選択した商品資材が重複除外された場合で明細重複許可フラグTRUEの場合
            }else if(item.MeisaiChofukuKyokaFlg__c){
                //受注明細データインサート用リストに引当無TRUEで追加
                insJuchuMeisaiList.add(new JuchuMeisaiData__c(name = 'XXX', JuchuData__c = currentJuchu.Id, ShohinShizaiM__c = item.Id, HikiateFuyoFig__c = true));                
            }

        }

        try{
            //受注明細一括追加上限を超えない場合のみインサートを試行
            if(insJuchuMeisaiList.size() <= OrderDetailsBulkAddLimit){
                insert insJuchuMeisaiList;
            //追加上限を超える場合はワーニングメッセージを出力
            }else{
                retErrorMessage = TOOMANY_ERROR_MESSAGE;
            }
        }catch (DmlException e){
            System.debug('### ' + 'J02 insert insJuchuMeisaiList DmlException');
        }
       
        return retErrorMessage;

    }

}