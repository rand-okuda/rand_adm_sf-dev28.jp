<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>ShiharaiMeisaiDataShiharaiKakakuUpdate</fullName>
        <field>ShiharaiKakaku__c</field>
        <formula>HachuMeisaiData__r.KonyuKakaku__c</formula>
        <name>02. 支払価格更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ShiharaiMeisaiDataShohizeiritsuUpdate</fullName>
        <field>Shohizeiritsu__c</field>
        <formula>HachuMeisaiData__r.Shohizeiritsu__c</formula>
        <name>03. 消費税率更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>02%2E 支払価格転記</fullName>
        <actions>
            <name>ShiharaiMeisaiDataShiharaiKakakuUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(ISBLANK(ShiharaiKakaku__c), ISNULL(ShiharaiKakaku__c))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>03%2E 消費税率転記</fullName>
        <actions>
            <name>ShiharaiMeisaiDataShohizeiritsuUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(ISBLANK(Shohizeiritsu__c), ISNULL(Shohizeiritsu__c))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
