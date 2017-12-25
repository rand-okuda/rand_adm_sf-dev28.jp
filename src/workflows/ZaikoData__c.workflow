<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>BaiTankaUpdate</fullName>
        <field>BaiTanka__c</field>
        <formula>IF ( ISBLANK(JuchuMeisai__c) ,
 ShohinShizaiM__r.HyojunBaika__c ,
 JuchuMeisai__r.ShohinBaika__c
)</formula>
        <name>31. 売単価転記</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>GenTankaUpdate</fullName>
        <field>KaiTanka__c</field>
        <formula>IF ( ISBLANK(ShiharaiMeisai__c) ,

 IF ( ISBLANK( ZenZaikoData__c ) , 
 ShohinShizaiM__r.HyojunGenka__c  ,
 ZenZaikoData__r.KaiTanka__c 
 ),

 ShiharaiMeisai__r.ShiharaiKakaku__c

)</formula>
        <name>31. 原単価転記</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NyukoZaikoDataSuryoUpdate</fullName>
        <field>NyukoSuryo__c</field>
        <formula>ZaikoSuryo__c</formula>
        <name>21. 入庫数量補完</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ShiiresakiMeiNamachiOyaUpdate</fullName>
        <field>ShiiresakiMeiNamachi__c</field>
        <formula>ZenZaikoData__r.ShiiresakiMeiNamachi__c</formula>
        <name>28. 仕入先名（親入出庫）生値記入</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ShiiresakiMeiNamachiUpdate</fullName>
        <field>ShiiresakiMeiNamachi__c</field>
        <formula>HachuMeisai__r.ShiiresakiMeiNamachi__c</formula>
        <name>28. 仕入先名（発注明細）生値記入</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ShohiKigenKinyu</fullName>
        <field>ShomiKigen__c</field>
        <formula>ShomiKigenSanshutsu__c</formula>
        <name>20. デフォルト消費期限記入</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ShukkoZaikoDataSuryoUpdate</fullName>
        <field>NyukoSuryo__c</field>
        <formula>ZenShukkoSuryo__c</formula>
        <name>06. 入庫数量出庫数量転記</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TanaoroshiKakuninNichijiDel</fullName>
        <field>TanaoroshiKakuninNichiji__c</field>
        <name>30. 棚卸確認日時クリア</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataAiteShohinShizaimeiUpdate</fullName>
        <field>AiteShohinShizaimei__c</field>
        <formula>JuchuMeisai__r.TorihikisakiTanka__r.AiteShohinShizaimei__c</formula>
        <name>13. 相手商品資材名更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataHambaiKigenBiUpdate</fullName>
        <field>HambaiKigenBiNamachi__c</field>
        <formula>HambaiKigenBi__c</formula>
        <name>27. 販売期限日生値記入</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataHikiateKanoFlgNamaTrueUpdate</fullName>
        <field>HikiateKanoFlgNamachi__c</field>
        <literalValue>1</literalValue>
        <name>34. 引当可能フラグ生値TRUE更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataHikiateKanoFlgNamaTrueUpdateFal</fullName>
        <field>HikiateKanoFlgNamachi__c</field>
        <literalValue>0</literalValue>
        <name>34. 引当可能フラグ生値FALSE更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataHikiateKensakuFlgNamaFalsUpdate</fullName>
        <field>HikiateKensakuFlgNamachi__c</field>
        <literalValue>0</literalValue>
        <name>29. 引当対象フラグ生値FALSE更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataHikiateKensakuFlgNamaTrueUpdate</fullName>
        <field>HikiateKensakuFlgNamachi__c</field>
        <literalValue>1</literalValue>
        <name>29. 引当対象フラグ生値TRUE更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataJuchusakiCodeUpdate</fullName>
        <field>JuchusakiCode__c</field>
        <formula>JuchuData__r.Juchusaki__r.TorihikisakiCode__c</formula>
        <name>11. 受注先コード更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataKanshutsuNichijiUpdate</fullName>
        <field>KanshutsuNichiji__c</field>
        <formula>NOW()</formula>
        <name>33. 完出日時記入</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataLotBangoUpdate</fullName>
        <field>LotBango__c</field>
        <formula>LotBangoShokai__c</formula>
        <name>01. ロット番号更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataNameKoshin</fullName>
        <field>Name</field>
        <formula>ZaikoDataNameSanshutsu__c</formula>
        <name>12. 入出庫データ名更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataNarabiJunUpdate</fullName>
        <field>NarabiJun__c</field>
        <formula>JuchuMeisai__r.NarabiJunNamachi__c</formula>
        <name>02. 並び順更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataNohinsakiCodeUpdate</fullName>
        <field>NohinsakiCode__c</field>
        <formula>JuchuData__r.Nohinsaki__r.TorihikisakiCode__c</formula>
        <name>11. 納品先コード更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataNyukoFlgTrueUpdate</fullName>
        <field>NyukoFlg__c</field>
        <literalValue>1</literalValue>
        <name>23. 入庫フラグTRUE更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataNyukoNichijiNohinBiUpdate</fullName>
        <field>NyukoNichiji__c</field>
        <formula>DATETIMEVALUE( HachuMeisai__r.NohinYoteibi__c )</formula>
        <name>22. 入庫日時納品日反映</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataNyukoNichijiNowUpdate</fullName>
        <field>NyukoNichiji__c</field>
        <formula>NOW()</formula>
        <name>08. 入庫日時転記（現時刻）</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataNyukoNichijiUpdate</fullName>
        <field>NyukoNichiji__c</field>
        <formula>ZenShukkoNichiji__c</formula>
        <name>07. 入庫日時転記（出庫日時）</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataSaidaiShomiKigenFlgFALSEUpdate</fullName>
        <field>SaidaiShomiKigenFlgNamachi__c</field>
        <literalValue>0</literalValue>
        <name>19. 最大賞味期限フラグFALSE設定</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataSaidaiShomiKigenFlgTRUEUpdate</fullName>
        <field>SaidaiShomiKigenFlgNamachi__c</field>
        <literalValue>1</literalValue>
        <name>19. 最大賞味期限フラグTRUE設定</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataShohinShizaiM_NameUpdate</fullName>
        <field>ShohinShizaiM_Name__c</field>
        <formula>ShohinShizaiM__r.Name</formula>
        <name>13. 商品資材名更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataShomiKigenKakuhoFALSEUpdate</fullName>
        <field>HambaiKanoNamachi__c</field>
        <literalValue>0</literalValue>
        <name>18. 賞味期限確保FALSE生値更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataShomiKigenKakuhoTRUEUpdate</fullName>
        <field>HambaiKanoNamachi__c</field>
        <literalValue>1</literalValue>
        <name>17. 賞味期限確保TRUE設定</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataSuiiHizukeUpdate</fullName>
        <field>SuiiHizukeNamachi__c</field>
        <formula>ZenZaikoData__r.NyukoNichiji__c</formula>
        <name>25. 推移日付生値記入</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataSuryoCSNamachiUpdate</fullName>
        <field>SuryoCSNamachi__c</field>
        <formula>SuryoCS__c</formula>
        <name>05. 数量CS生値記入</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataSuryoCTNamachiUpdate</fullName>
        <field>SuryoCTNamachi__c</field>
        <formula>SuryoCT__c</formula>
        <name>05. 数量CT生値転記</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataSuryoPCNamachiUpdate</fullName>
        <field>SuryoPCNamachi__c</field>
        <formula>SuryoPC__c</formula>
        <name>05. 数量PC生値記入</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataSuryoSuiiSuryoNamachiUpdate</fullName>
        <field>SuiiSuryoNamachi__c</field>
        <formula>SuiiSuryo__c</formula>
        <name>32. 推移数量生値記入</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataYosokuTaisyoFFalseUpdate</fullName>
        <field>YosokuTaisyoFlgNamachi__c</field>
        <literalValue>0</literalValue>
        <name>03. 予測対象外フラグFALSE更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataYosokuTaisyoFTrueUpdate</fullName>
        <field>YosokuTaisyoFlgNamachi__c</field>
        <literalValue>1</literalValue>
        <name>04. 予測対象外フラグTRUE更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataYoteiZaikoFlgFalseUpdate</fullName>
        <field>YoteiZaikoFlg__c</field>
        <literalValue>0</literalValue>
        <name>24. 予定入庫フラグFALSE更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataYoteiZaikoFlgTrueUpdate</fullName>
        <field>YoteiZaikoFlg__c</field>
        <literalValue>1</literalValue>
        <name>24. 予定入庫フラグTRUE更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataYoteiZaikoNichijiUpdate</fullName>
        <field>YoteiNyukoBi__c</field>
        <formula>DATEVALUE( NyukoNichiji__c )</formula>
        <name>24. 予定入庫日更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataZaikoSuryoUpdate</fullName>
        <field>ZaikoSuryo__c</field>
        <formula>NyukoSuryo__c</formula>
        <name>14. 入庫数量在庫数量転記</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataZenShukkoNichijiUpdate</fullName>
        <field>ZenShukkoNichiji__c</field>
        <formula>DATETIMEVALUE(HachuMeisai__r.NohinYoteibi__c)</formula>
        <name>10. 前出庫日時更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZaikoDataZenShukkoSuryoUpdate</fullName>
        <field>ZenShukkoSuryo__c</field>
        <formula>HachuMeisai__r.HachuSuryoPC__c</formula>
        <name>09. 前出庫数量更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>01%2E ロット番号転記</fullName>
        <actions>
            <name>ZaikoDataLotBangoUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>02%2E 並び順転記</fullName>
        <actions>
            <name>ZaikoDataNarabiJunUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ZaikoData__c.NarabiJun__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>03%2E 予測対象外フラグFALSE設定</fullName>
        <actions>
            <name>ZaikoDataYosokuTaisyoFFalseUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ZaikoData__c.YosokuTaisyoFlg__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>04%2E 予測対象外フラグTRUE設定</fullName>
        <actions>
            <name>ZaikoDataYosokuTaisyoFTrueUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ZaikoData__c.YosokuTaisyoFlg__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>05%2E 数量CS生値記入</fullName>
        <actions>
            <name>ZaikoDataSuryoCSNamachiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(  SuryoCT__c  =  SuryoCTNamachi__c,  NOT( ISBLANK(SuryoCTNamachi__c ) ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>05%2E 数量CT生値記入</fullName>
        <actions>
            <name>ZaikoDataSuryoCTNamachiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(  SuryoCT__c  &lt;&gt;  SuryoCTNamachi__c,  ISBLANK(SuryoCTNamachi__c ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>05%2E 数量PC生値記入</fullName>
        <actions>
            <name>ZaikoDataSuryoPCNamachiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(  SuryoCT__c  =  SuryoCTNamachi__c,  SuryoCS__c  =  SuryoCSNamachi__c,  NOT( ISBLANK(SuryoCTNamachi__c ) ),  NOT( ISBLANK(SuryoCSNamachi__c ) ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>06%2E 入庫数量出庫数量転記</fullName>
        <actions>
            <name>ShukkoZaikoDataSuryoUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ShukkoZumiMinyukoFlg__c, OR(ISBLANK(NyukoSuryo__c), ISNULL(NyukoSuryo__c)))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>07%2E 入庫日時転記%EF%BC%88出庫日時%EF%BC%89</fullName>
        <actions>
            <name>ZaikoDataNyukoNichijiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ZaikoData__c.NohinFlg__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>ZaikoData__c.ShukkoZumiMinyukoFlg__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>08%2E 入庫日時転記%EF%BC%88現時刻%EF%BC%89</fullName>
        <actions>
            <name>ZaikoDataNyukoNichijiNowUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ZaikoData__c.ShukkoNyukoZumiFlg__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>09%2E 前出庫数量転記</fullName>
        <actions>
            <name>ZaikoDataZenShukkoSuryoUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(ISBLANK(ZenShukkoSuryo__c), ISNULL(ZenShukkoSuryo__c))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>10%2E 前出庫日時転記</fullName>
        <actions>
            <name>ZaikoDataZenShukkoNichijiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(ISBLANK(ZenShukkoNichiji__c), ISNULL(ZenShukkoNichiji__c))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>11%2E 各値転記</fullName>
        <actions>
            <name>ZaikoDataJuchusakiCodeUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ZaikoDataNohinsakiCodeUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>12%2E 在庫データ名設定</fullName>
        <actions>
            <name>ZaikoDataNameKoshin</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>13%2E 商品資材名相手商品資材名転記</fullName>
        <actions>
            <name>ZaikoDataAiteShohinShizaimeiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ZaikoDataShohinShizaiM_NameUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>14%2E 入庫数量在庫数量転記</fullName>
        <actions>
            <name>ZaikoDataZaikoSuryoUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(  ShukkoNyukoZumiFlg__c ,  ISBLANK( JuchuMeisai__c ) , OR(  ISBLANK(ZaikoSuryo__c),   ISNULL(ZaikoSuryo__c) ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>17%2E 賞味期限確保TRUE設定</fullName>
        <actions>
            <name>ZaikoDataShomiKigenKakuhoTRUEUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ZaikoData__c.HambaiKano__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>18%2E 賞味期限確保FALES設定</fullName>
        <actions>
            <name>ZaikoDataShomiKigenKakuhoFALSEUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ZaikoData__c.HambaiKano__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>19%2E 最大賞味期限フラグFALSE設定</fullName>
        <actions>
            <name>ZaikoDataSaidaiShomiKigenFlgFALSEUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ZaikoData__c.SaidaiShomiKigenFlg__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>19%2E 最大賞味期限フラグTRUE設定</fullName>
        <actions>
            <name>ZaikoDataSaidaiShomiKigenFlgTRUEUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ZaikoData__c.SaidaiShomiKigenFlg__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>20%2E デフォルト消費期限記入</fullName>
        <actions>
            <name>ShohiKigenKinyu</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ZaikoData__c.ShomiKigen__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>ZaikoData__c.ShukkoFlg__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>ShohinShizaiM__c.ShohiKigenJidoFlg__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>21%2E 入庫数量補完</fullName>
        <actions>
            <name>NyukoZaikoDataSuryoUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ZaikoData__c.NyukoFlg__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>ZaikoData__c.NyukoSuryo__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>22%2E 入庫日時納品日反映</fullName>
        <actions>
            <name>ZaikoDataNyukoNichijiNohinBiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(  NOT(ISBLANK( HachuMeisai__c ))  ,  NOT(NyukoFlg__c)   )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>23%2E 入庫フラグTRUE更新</fullName>
        <actions>
            <name>ZaikoDataNyukoFlgTrueUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(  ShohinShizaiM__r.HatchuJidoNyuko__c ,  NOT( ISBLANK( HachuMeisai__c ) )  )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>24%2E 予定入庫フラグFALSE更新</fullName>
        <actions>
            <name>ZaikoDataYoteiZaikoFlgFalseUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ZaikoData__c.YoteiZaikoFlg__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>ZaikoData__c.YoteiNyukoBi__c</field>
            <operation>lessOrEqual</operation>
            <value>今日</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>24%2E 予定入庫日%EF%BC%86フラグTRUE更新</fullName>
        <actions>
            <name>ZaikoDataYoteiZaikoFlgTrueUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ZaikoDataYoteiZaikoNichijiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ZaikoData__c.NyukoNichiji__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>ZaikoData__c.NyukoFlg__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>25%2E 推移日付生値記入</fullName>
        <actions>
            <name>ZaikoDataSuiiHizukeUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>27%2E 販売期限日生値記入</fullName>
        <actions>
            <name>ZaikoDataHambaiKigenBiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>28%2E 仕入先名%EF%BC%88発注明細%EF%BC%89生値記入</fullName>
        <actions>
            <name>ShiiresakiMeiNamachiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ZaikoData__c.ShisoZaikoFlg__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>28%2E 仕入先名%EF%BC%88親入出庫%EF%BC%89生値記入</fullName>
        <actions>
            <name>ShiiresakiMeiNamachiOyaUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ZaikoData__c.ShisoZaikoFlg__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>29%2E 引当対象フラグ生値FALSE更新</fullName>
        <actions>
            <name>ZaikoDataHikiateKensakuFlgNamaFalsUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ZaikoData__c.HikiateKensakuFlg__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>29%2E 引当対象フラグ生値TRUE更新</fullName>
        <actions>
            <name>ZaikoDataHikiateKensakuFlgNamaTrueUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ZaikoData__c.HikiateKensakuFlg__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>30%2E 棚卸確認日時クリア</fullName>
        <actions>
            <name>TanaoroshiKakuninNichijiDel</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ZaikoData__c.TanaoroshiKakuninNichiji__c</field>
            <operation>lessThan</operation>
            <value>今日</value>
        </criteriaItems>
        <criteriaItems>
            <field>ZaikoData__c.KanshutsuZaikoFlg__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>ZaikoData__c.HakiZaikoFlg__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>31%2E 売単価転記</fullName>
        <actions>
            <name>BaiTankaUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ZaikoData__c.BaiTanka__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>31%2E 買単価転記</fullName>
        <actions>
            <name>GenTankaUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ZaikoData__c.KaiTanka__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>32%2E 推移数量生値記入</fullName>
        <actions>
            <name>ZaikoDataSuryoSuiiSuryoNamachiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>33%2E 完出日時記入</fullName>
        <actions>
            <name>ZaikoDataKanshutsuNichijiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ZaikoData__c.ZaikoSuryo__c</field>
            <operation>equals</operation>
            <value>0</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>34%2E 引当可能フラグ生値FALSE更新</fullName>
        <actions>
            <name>ZaikoDataHikiateKanoFlgNamaTrueUpdateFal</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ZaikoData__c.HikiateKanoFlg__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>34%2E 引当可能フラグ生値TRUE更新</fullName>
        <actions>
            <name>ZaikoDataHikiateKanoFlgNamaTrueUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ZaikoData__c.HikiateKanoFlg__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
