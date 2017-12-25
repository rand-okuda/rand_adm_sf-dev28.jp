<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>HatchuDataNohinYoteibiKinyu</fullName>
        <field>NohinYoteibi__c</field>
        <formula>TODAY()</formula>
        <name>01. 納品予定日記入</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>01%2E 納品予定日記入</fullName>
        <actions>
            <name>HatchuDataNohinYoteibiKinyu</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>HachuData__c.NohinYoteibi__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
