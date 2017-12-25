<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>MiKaishuAlertNamachiFALSEUpdate</fullName>
        <field>TokusokuAlertNamachi__c</field>
        <literalValue>0</literalValue>
        <name>10. 未回収アラート生値FALSE更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MiKaishuAlertNamachiTRUEUpdate</fullName>
        <field>TokusokuAlertNamachi__c</field>
        <literalValue>1</literalValue>
        <name>10. 未回収アラート生値TRUE更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MikomiMikaishuZandakaNamachiUpdate</fullName>
        <field>MikomiMikaishuZandakaNamachi__c</field>
        <formula>MikomiMikaishuZandaka__c</formula>
        <name>09. 見込未回収額生値更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SaishuSeikyuKingakuNamachiUpd</fullName>
        <field>KaishuKanryoBiNamachi__c</field>
        <formula>KaishuKanryoBi__c</formula>
        <name>03. 回収完了日生値更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UrikakeDataKahenSeikyuFlgTrueUpdate</fullName>
        <field>KahenSeikyuFlg__c</field>
        <literalValue>1</literalValue>
        <name>05. 可変請求フラグTRUE更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UrikakeDataNameUpdate</fullName>
        <field>Name</field>
        <formula>UrikakeDataNameSanshutsu__c</formula>
        <name>02. 売掛データ名更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UrikakeDataNyukinKijitsuUpdate</fullName>
        <field>SeikyuKaishuKigen__c</field>
        <formula>SeikyuKaishuKigenSanshutsu__c</formula>
        <name>08. 入金期日更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>true</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UrikakeDataSaishuSeikyuKingakuNamachiUpd</fullName>
        <field>SaishuSeikyuKingakuNamachi__c</field>
        <formula>SaishuSeikyuKingaku__c</formula>
        <name>01. 最終請求金額生値更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UrikakeDataShimeKikanKaraNamachiUpdate</fullName>
        <field>ShimeKikanKaraNamachi__c</field>
        <formula>ShimeKikanKara__c</formula>
        <name>01. 締期間から生値更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UrikakeDataShimeKikanKaraShudoUpdate</fullName>
        <field>ShimeKikanKaraShudo__c</field>
        <formula>ShimeHizuke__c</formula>
        <name>06. 締期間から手動更新（締基準日）</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UrikakeDataShimeKikanMadeNamachiUpdate</fullName>
        <description>締期間までの値を、締期間まで生値にコピーする</description>
        <field>ShimeKikanMadeNamachi__c</field>
        <formula>ShimeKikanMade__c</formula>
        <name>01. 締期間まで生値更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UrikakeDataShimeKikanMadeShudo365Update</fullName>
        <field>ShimeKikanMadeShudo__c</field>
        <formula>TODAY()  + 365</formula>
        <name>06. 締期間まで手動更新（一年後仮）</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UrikakeDataShimeKikanMadeShudoTODAYUpdat</fullName>
        <field>ShimeKikanMadeShudo__c</field>
        <formula>IF (  ShimeKikanKaraShudo__c  &gt;  TODAY() ,
 ShimeKikanKaraShudo__c,
 TODAY() 
)</formula>
        <name>07. 締期間まで手動更新（ロック時）</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UrikakeDataShimekikanTsukisuUpdate</fullName>
        <field>ShimekikanTsukisu__c</field>
        <formula>SeikyuAccount__r.ShimekikanTsukisu__c</formula>
        <name>04. 請求締期間月数更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>01%2E 各値転記</fullName>
        <actions>
            <name>UrikakeDataSaishuSeikyuKingakuNamachiUpd</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UrikakeDataShimeKikanKaraNamachiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UrikakeDataShimeKikanMadeNamachiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>02%2E 売掛データ名設定</fullName>
        <actions>
            <name>UrikakeDataNameUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>03%2E 回収完了日生値更新</fullName>
        <actions>
            <name>SaishuSeikyuKingakuNamachiUpd</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>04%2E 請求締期間月数更新</fullName>
        <actions>
            <name>UrikakeDataShimekikanTsukisuUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(   ISBLANK( ShimekikanTsukisu__c ) ,   ISNULL(ShimekikanTsukisu__c )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>05%2E 可変請求フラグ転記</fullName>
        <actions>
            <name>UrikakeDataKahenSeikyuFlgTrueUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Account.KahenSeikyuFlg__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>UrikakeData__c.TsudoSeikyuFlg__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>06%2E 締期間まで手動更新%EF%BC%88未ロック時%EF%BC%89</fullName>
        <actions>
            <name>UrikakeDataShimeKikanKaraShudoUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UrikakeDataShimeKikanMadeShudo365Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>UrikakeData__c.KahenSeikyuFlg__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>UrikakeData__c.SeikyuKakuteiFlg__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>07%2E 締期間まで手動更新%EF%BC%88ロック時%EF%BC%89</fullName>
        <actions>
            <name>UrikakeDataShimeKikanMadeShudoTODAYUpdat</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>UrikakeData__c.KahenSeikyuFlg__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>UrikakeData__c.SeikyuKakuteiFlg__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>08%2E 入金期日更新</fullName>
        <actions>
            <name>UrikakeDataNyukinKijitsuUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>UrikakeData__c.SeikyuKaishuKigen__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>UrikakeData__c.KaishuKigenShift__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>09%2E 見込未回収額生値更新</fullName>
        <actions>
            <name>MikomiMikaishuZandakaNamachiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>10%2E 未回収アラート生値FALSE更新</fullName>
        <actions>
            <name>MiKaishuAlertNamachiFALSEUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>UrikakeData__c.TokusokuAlertFlg__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>10%2E 未回収アラート生値TRUE更新</fullName>
        <actions>
            <name>MiKaishuAlertNamachiTRUEUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>UrikakeData__c.TokusokuAlertFlg__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
