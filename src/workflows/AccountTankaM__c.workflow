<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>AccountTankaMGenzaiYukoFlgNamachiFALSEUp</fullName>
        <field>GenzaiYukoFlgNamachi__c</field>
        <literalValue>0</literalValue>
        <name>01. 現在有効フラグ生値FALSE更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AccountTankaMGenzaiYukoFlgNamachiTRUEUpd</fullName>
        <field>GenzaiYukoFlgNamachi__c</field>
        <literalValue>1</literalValue>
        <name>02. 現在有効フラグ生値TRUE更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AccountTankaMNohinKakakuUpdate</fullName>
        <field>NohinKakaku__c</field>
        <formula>ShohinShizaiM__r.HyojunBaika__c</formula>
        <name>05. 販売価格転記</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AccountTankaMShomiKigenKakuhoNissuUpdate</fullName>
        <field>ShomiKigenKakuhoNissu__c</field>
        <formula>ShohinShizaiM__r.HanbaiKanriKigenNissu__c</formula>
        <name>03. 賞味期限確保日数更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>AccountTankaMTekiyoKikanMadeUpdate</fullName>
        <field>TekiyoKikanMade__c</field>
        <formula>ShohinShizaiM__r.Shubaibi__c</formula>
        <name>04. 適用期間まで更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>01%2E 現在有効フラグ生値FALSE設定</fullName>
        <actions>
            <name>AccountTankaMGenzaiYukoFlgNamachiFALSEUp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>AccountTankaM__c.GenzaiYukoFlg__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>02%2E 現在有効フラグ生値TRUE設定</fullName>
        <actions>
            <name>AccountTankaMGenzaiYukoFlgNamachiTRUEUpd</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>AccountTankaM__c.GenzaiYukoFlg__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>03%2E 賞味期限確保日数転記</fullName>
        <actions>
            <name>AccountTankaMShomiKigenKakuhoNissuUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>AccountTankaM__c.ShomiKigenKakuhoNissu__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>04%2E 適用期間まで転記</fullName>
        <actions>
            <name>AccountTankaMTekiyoKikanMadeUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ShohinShizaiM__r.ShubaiFlg__c</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>05%2E 販売価格転記</fullName>
        <actions>
            <name>AccountTankaMNohinKakakuUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>AccountTankaM__c.NohinKakaku__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
