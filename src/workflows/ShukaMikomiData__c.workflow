<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>ShukaMikomiDataKijunShohisuUpdate</fullName>
        <field>KijunShohisu__c</field>
        <formula>JuchuMeisaiData__r.JuchuSuryo__c</formula>
        <name>01. 基準消費数更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ShukaMikomiDataMotoHizukeUpdate</fullName>
        <field>MotoHizuke__c</field>
        <formula>JuchuMeisaiData__r.JuchuData__r.NohinYoteibi__c</formula>
        <name>01. 元日付更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ShukaMikomiDataShohisuUpdate</fullName>
        <field>ShohisuNamachi__c</field>
        <formula>CEILING(Shohisu__c)</formula>
        <name>01. 02. 03. 消費数更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ShukaMikomiDataYosokuTaishoFlgFalseUpd</fullName>
        <field>YosokuTaishoFlgNamachi__c</field>
        <literalValue>0</literalValue>
        <name>02. 予測対象フラグFALSE更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ShukaMikomiDataYosokuTaishoFlgTrueUpdate</fullName>
        <field>YosokuTaishoFlgNamachi__c</field>
        <literalValue>1</literalValue>
        <name>03. 予測対象フラグTRUE更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>01%2E 受注明細データ転記</fullName>
        <actions>
            <name>ShukaMikomiDataKijunShohisuUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ShukaMikomiDataMotoHizukeUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ShukaMikomiDataShohisuUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>NOT( ISBLANK( JuchuMeisaiData__c ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>02%2E 予測対象フラグFALSE設定</fullName>
        <actions>
            <name>ShukaMikomiDataShohisuUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ShukaMikomiDataYosokuTaishoFlgFalseUpd</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ShukaMikomiData__c.YosokuTaishoHantei__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>03%2E 予測対象フラグTRUE設定</fullName>
        <actions>
            <name>ShukaMikomiDataShohisuUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ShukaMikomiDataYosokuTaishoFlgTrueUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ShukaMikomiData__c.YosokuTaishoHantei__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
