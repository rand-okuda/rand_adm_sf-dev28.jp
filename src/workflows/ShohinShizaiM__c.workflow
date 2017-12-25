<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>NameKinkyuShiireFalseUpdate</fullName>
        <field>Name</field>
        <formula>ShohinShizaiHyojunMei__c</formula>
        <name>08. 商品名緊急仕入FALSE追記</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NameKinkyuShiireTrueUpdate</fullName>
        <field>Name</field>
        <formula>ShohinShizaiHyojunMei__c  + &quot;・&quot;</formula>
        <name>08. 商品名緊急仕入TRUE追記</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ShohinMKeppinKeikokuYoteiFeedTRUEUpdate</fullName>
        <field>KeppinKeikokuYoteiFeed__c</field>
        <literalValue>1</literalValue>
        <name>04. 欠品警告フィードTRUE（予定込）</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ShohinMKeppinKeikokuYoteiFeedYoFAUpdate</fullName>
        <field>KeppinKeikokuYoteiFeed__c</field>
        <literalValue>0</literalValue>
        <name>06. 欠品警告フィードTRUE（予定込）</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ShohinShizaiHyojunMeiUpdate</fullName>
        <field>ShohinShizaiHyojunMei__c</field>
        <formula>Name</formula>
        <name>09. 商品資材標準名転記</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ShohinShizaiMHanbaiKanriKigenNissuUpdate</fullName>
        <field>HanbaiKanriKigenNissu__c</field>
        <formula>ShomiKigenNissu__c * 0.3</formula>
        <name>02. 販売管理期限日数更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ShohinShizaiMKeppinKeikokuFeedFALEUpdate</fullName>
        <field>KeppinKeikokuFeed__c</field>
        <literalValue>0</literalValue>
        <name>05. 欠品警告フィードFALES</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ShohinShizaiMKeppinKeikokuFeedTRUEUpdate</fullName>
        <field>KeppinKeikokuFeed__c</field>
        <literalValue>1</literalValue>
        <name>03. 欠品警告フィードTRUE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ShohinShizaiMTaniSoHenkansuUpdate</fullName>
        <field>BaiRitsuCT__c</field>
        <formula>BaiRitsuCS__c</formula>
        <name>01. 単位祖変換数更新</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>01%2E 単位祖変換数転記</fullName>
        <actions>
            <name>ShohinShizaiMTaniSoHenkansuUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(NOT(ISBLANK(BaiRitsuCS__c)),   NOT(ISNULL(BaiRitsuCS__c)),   OR(ISBLANK(BaiRitsuCT__c), ISNULL(BaiRitsuCT__c)) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>02%2E 販売管理期限日数転記</fullName>
        <actions>
            <name>ShohinShizaiMHanbaiKanriKigenNissuUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ShohinShizaiM__c.HanbaiKanriKigenNissu__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>03%2E 欠品警告フィードTRUE</fullName>
        <actions>
            <name>ShohinShizaiMKeppinKeikokuFeedTRUEUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ShohinShizaiM__c.KeppinKeikoku__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>04%2E 欠品警告フィードTRUE%EF%BC%88予定込%EF%BC%89</fullName>
        <actions>
            <name>ShohinMKeppinKeikokuYoteiFeedTRUEUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ShohinShizaiM__c.KeppinKeikokuSeisanchukomiYotei__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>05%2E 欠品警告フィードFALES</fullName>
        <actions>
            <name>ShohinShizaiMKeppinKeikokuFeedFALEUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ShohinShizaiM__c.KeppinKeikoku__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>06%2E 欠品警告フィードFALES%EF%BC%88予定込%EF%BC%89</fullName>
        <actions>
            <name>ShohinMKeppinKeikokuYoteiFeedYoFAUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ShohinShizaiM__c.KeppinKeikokuSeisanchukomiYotei__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>07%2E 欠品警告Todo</fullName>
        <actions>
            <name>ShohinShizaiMKeppinKeikoku</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>ShohinShizaiM__c.KeppinKeikoku__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>ShohinShizaiM__c.KeppinKeikokuSeisanchukomiYotei__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>08%2E 商品名緊急仕入FALSE追記</fullName>
        <actions>
            <name>NameKinkyuShiireFalseUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ShohinShizaiM__c.KinkyuShiireFlg__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>08%2E 商品名緊急仕入TRUE追記</fullName>
        <actions>
            <name>NameKinkyuShiireTrueUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ShohinShizaiM__c.KinkyuShiireFlg__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>09%2E 商品資材標準名転記</fullName>
        <actions>
            <name>ShohinShizaiHyojunMeiUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>ShohinShizaiM__c.ShohinShizaiHyojunMei__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <tasks>
        <fullName>ShohinShizaiMKeppinKeikoku</fullName>
        <assignedTo>rand_adm_sf@dev28.jp</assignedTo>
        <assignedToType>user</assignedToType>
        <description>欠品警告が発令されました。
商品資材の追加発注を検討してください。</description>
        <dueDateOffset>-1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>ShohinShizaiM__c.SaiChoHambaiKigenHizuke__c</offsetFromField>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>07. 商品資材マスタ欠品警告Todo</subject>
    </tasks>
</Workflow>
