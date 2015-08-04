<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Approval</fullName>
        <description>If opportunity amount is greater than 5000 then it will send email to owner</description>
        <protected>false</protected>
        <recipients>
            <recipient>monali.nagpure@eternussolutions.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/For_opportunity</template>
    </alerts>
    <alerts>
        <fullName>Approval_by_Manager</fullName>
        <description>Here is new mail for manager that opportunity amount is greater than 5000</description>
        <protected>false</protected>
        <recipients>
            <recipient>monali.nagpure@eternussolutions.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>nmkshelar@gmail.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/For_opportunity</template>
    </alerts>
    <alerts>
        <fullName>Stage_Oppor</fullName>
        <description>If your opportunity stage is in &apos;negotiation/review&apos; stage, send an email to the opportunity owner indicating a big deal is being created.</description>
        <protected>true</protected>
        <recipients>
            <recipient>monali.nagpure@eternussolutions.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Opportunity_Stage_Template</template>
    </alerts>
    <alerts>
        <fullName>opportunity_amount_is_greater_than_5000</fullName>
        <description>opportunity amount is greater than 5000</description>
        <protected>true</protected>
        <recipients>
            <recipient>monali.nagpure@eternussolutions.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/For_opportunity</template>
    </alerts>
    <rules>
        <fullName>Big Deal Alert</fullName>
        <actions>
            <name>Stage_Oppor</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Negotiation/Review</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Amount</field>
            <operation>greaterThan</operation>
            <value>5000</value>
        </criteriaItems>
        <description>if your opportunity stage is in &apos;negotiation/review&apos; stage, send an email to the opportunity owner indicating a big deal is being created.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
