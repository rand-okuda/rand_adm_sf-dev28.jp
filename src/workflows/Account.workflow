<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>AccountSeikyuBikoJuchusakiFlgTRUEUpdate</fullName>
        <field>SeikyuBikoJuchusakiFlg__c</field>
        <literalValue>1</literalValue>
        <name>04. 請求書備考表示TRUE更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AccountSeishikiMeishoUpdate</fullName>
        <field>SeishikiMeisho__c</field>
        <formula>Name</formula>
        <name>01. 取引先正式名称更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AccountTankaMHuyouFlgTRUEUpdate</fullName>
        <field>AccountTankaMHuyouFlg__c</field>
        <literalValue>1</literalValue>
        <name>03. 取引先条件マスタ不要フラグTRUE更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FumeiNyukinCounterNamachUpdate</fullName>
        <field>FumeiNyukinCounterNamachi__c</field>
        <formula>FumeiNyukinCounter__c</formula>
        <name>05. 不明入金カウンタ生値更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FumeiNyukinSaidaiGakuNamachiUpdate</fullName>
        <field>FumeiNyukinSaidaiGakuNamachi__c</field>
        <formula>NyukinSaidaiGaku__c</formula>
        <name>07. 不明入金最大額生値更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FumeiNyukinSaishoGakuNamachiUpdate</fullName>
        <field>FumeiNyukinSaishoGakuNamachi__c</field>
        <formula>NyukinSaishoGaku__c</formula>
        <name>08. 不明入金最小額生値更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FumeiNyukinZengakuNamachiUpdate</fullName>
        <field>FumeiNyukinZengakuNamachi__c</field>
        <formula>NyukinZengaku__c</formula>
        <name>06. 不明入金残額計生値更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SeikyusakiShokaiNamachiUpdate</fullName>
        <field>SeikyusakiShokaiNamachi__c</field>
        <formula>SeikyusakiShokai__c</formula>
        <name>02. 請求先照会生値更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>01%2E 取引先正式名称転記</fullName>
        <actions>
            <name>AccountSeishikiMeishoUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(ISBLANK(SeishikiMeisho__c), ISNULL(SeishikiMeisho__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>02%2E 請求先照会生値転記</fullName>
        <actions>
            <name>SeikyusakiShokaiNamachiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>03%2E 取引先条件マスタ不要フラグ転記</fullName>
        <actions>
            <name>AccountTankaMHuyouFlgTRUEUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.AccountTankaMHuyouFlg__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.SeikyusakiTankaMHuyouFlg__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>04%2E 請求書備考表示TRUE更新</fullName>
        <actions>
            <name>AccountSeikyuBikoJuchusakiFlgTRUEUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Seikyusaki__r.SeikyuBikoJuchusakiFlg__c</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>05%2E 不明入金カウンタ生値更新</fullName>
        <actions>
            <name>FumeiNyukinCounterNamachUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>06%2E 不明入金残額計生値更新</fullName>
        <actions>
            <name>FumeiNyukinZengakuNamachiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>07%2E 不明入金最大額生値更新</fullName>
        <actions>
            <name>FumeiNyukinSaidaiGakuNamachiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>08%2E 不明入金最小額生値更新</fullName>
        <actions>
            <name>FumeiNyukinSaishoGakuNamachiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
