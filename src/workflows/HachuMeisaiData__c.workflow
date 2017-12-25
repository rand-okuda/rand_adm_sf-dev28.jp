<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>HachuMeisaiDataHachuSuryoUpdate</fullName>
        <field>HachuSuryoPC__c</field>
        <formula>HachuSuryoSanshutsu__c</formula>
        <name>03. 発注数量更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>true</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>HachuMeisaiDataKonyuKakakuUpdate</fullName>
        <field>KonyuKakaku__c</field>
        <formula>ShohinShizaiM__r.HyojunGenka__c</formula>
        <name>02. 購入価格更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>HachuMeisaiDataNohinYoteibiUpdate</fullName>
        <field>NohinYoteibi__c</field>
        <formula>IF (
 TODAY()  +  ShohinShizaiM__r.NyukaLeadTime__c  &gt;  HachuData__r.NohinYoteibi__c ,
 TODAY()  +  ShohinShizaiM__r.NyukaLeadTime__c,
 HachuData__r.NohinYoteibi__c
)</formula>
        <name>01. 納品予定日更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>HatchuKatonJido</fullName>
        <field>HachuSuryoCT__c</field>
        <formula>ShohinShizaiM__r.HachuSuryoCTAuto__c</formula>
        <name>04. 発注カートン自動入力</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ShiiresakiMeiNamachiUpdate</fullName>
        <field>ShiiresakiMeiNamachi__c</field>
        <formula>HachuData__r.Shiiresaki__r.Name</formula>
        <name>05. 仕入先名生値更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>01%2E 納品予定日更新</fullName>
        <actions>
            <name>HachuMeisaiDataNohinYoteibiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>HachuMeisaiData__c.NohinYoteibi__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>02%2E 購入価格転記</fullName>
        <actions>
            <name>HachuMeisaiDataKonyuKakakuUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(ISBLANK(KonyuKakaku__c), ISNULL(KonyuKakaku__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>03%2E 発注数量更新</fullName>
        <actions>
            <name>HachuMeisaiDataHachuSuryoUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>HachuMeisaiData__c.HachuSuryoPC__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>04%2E 発注カートン自動入力</fullName>
        <actions>
            <name>HatchuKatonJido</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(  ShohinShizaiM__r.HachuSuryoCTAuto__c &gt;= 1,  ISBLANK(  HachuSuryoCT__c  )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>05%2E 仕入先名生値更新</fullName>
        <actions>
            <name>ShiiresakiMeiNamachiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
