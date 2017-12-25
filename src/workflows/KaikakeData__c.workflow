<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>KaikakeDataNameUpdate</fullName>
        <field>Name</field>
        <formula>KaikakeDataNameSanshutsu__c</formula>
        <name>02. 買掛データ名更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>KaikakeDataShimeKikanKaraNamachiUpdate</fullName>
        <field>ShimeKikanKaraNamachi__c</field>
        <formula>ShimeKikanKara__c</formula>
        <name>03. 締期間から生値更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>KaikakeDataShimeKikanMadeNamachiUpdate</fullName>
        <description>締期間までの値を、締期間まで生値にコピーする</description>
        <field>ShimeKikanMadeNamachi__c</field>
        <formula>ShimeKikanMade__c</formula>
        <name>01. 締期間まで生値更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>01%2E 締期間まで転記</fullName>
        <actions>
            <name>KaikakeDataShimeKikanMadeNamachiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>02%2E 買掛データ名設定</fullName>
        <actions>
            <name>KaikakeDataNameUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>03%2E 締期間から生値更新</fullName>
        <actions>
            <name>KaikakeDataShimeKikanKaraNamachiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
