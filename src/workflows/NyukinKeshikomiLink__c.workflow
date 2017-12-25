<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>KeshikomiDataBikoUpdate</fullName>
        <field>Biko__c</field>
        <formula>Biko__c</formula>
        <name>02. 消込値引データ備考上書</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>KeshikomiData__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>KeshikomiKingakuNamachiUpd</fullName>
        <field>KeshikomiKingakuNamachi__c</field>
        <formula>KeshikomiKingaku__c</formula>
        <name>01. 消込入金額生値更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>KeshikomiMikakuteiSuNamachiUpdate</fullName>
        <field>KeshikomiMikakuteiSuNamachi__c</field>
        <formula>KeshikomiMikakuteiSu__c</formula>
        <name>03. 消込未確定数生値更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>01%2E 消込入金額生値更新</fullName>
        <actions>
            <name>KeshikomiKingakuNamachiUpd</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>02%2E 消込値引データ備考上書</fullName>
        <actions>
            <name>KeshikomiDataBikoUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>03%2E 消込未確定数生値更新</fullName>
        <actions>
            <name>KeshikomiMikakuteiSuNamachiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
