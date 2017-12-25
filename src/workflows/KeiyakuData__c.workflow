<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>KeiyakuKijunBiUpdate</fullName>
        <field>KeiyakuKijunBi__c</field>
        <formula>KeiyakuKijunBiSanshutsu__c</formula>
        <name>03. 契約基準日更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>KeiyakuKikanTsukiSuUpdate</fullName>
        <field>KeiyakuKikanTsukiSu__c</field>
        <formula>KeiyakuData__r.KeiyakuKikanTsukiSu__c</formula>
        <name>04. 契約期間月数更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>KeiyakuShuryoBiNamachiUpdate</fullName>
        <field>KeiyakuShuryoBiNamachi__c</field>
        <formula>KeiyakuShuryoBi__c</formula>
        <name>02. 契約終了日生値更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>KoshinBiNamachiUpdate</fullName>
        <field>KeiyakuKaishiBiNamachi__c</field>
        <formula>KeiyakuKaishiBi__c</formula>
        <name>01. 契約開始日生値更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>01%2E 契約開始日生値値更新</fullName>
        <actions>
            <name>KoshinBiNamachiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>02%2E 契約終了日生値更新</fullName>
        <actions>
            <name>KeiyakuShuryoBiNamachiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>03%2E 契約基準日更新</fullName>
        <actions>
            <name>KeiyakuKijunBiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>KeiyakuData__c.KeiyakuKijunBi__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>04%2E 契約期間月数更新</fullName>
        <actions>
            <name>KeiyakuKikanTsukiSuUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>KeiyakuData__c.ShokaiKeiyakuFlg__c</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
