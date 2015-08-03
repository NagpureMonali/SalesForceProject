<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Followup_date</fullName>
        <description>If follow up date is older than today, send a email to the Lead Owner to follow up the lead</description>
        <protected>false</protected>
        <recipients>
            <recipient>monali.nagpure@eternussolutions.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Follow_Up_Date_Template</template>
    </alerts>
    <fieldUpdates>
        <fullName>DNC</fullName>
        <description>it will fire this type of workflow when Do not call field is inactive</description>
        <field>RecordTypeId</field>
        <lookupValue>DNC</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>DNC</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mobile</fullName>
        <description>It will update the field mobile number</description>
        <field>RecordTypeId</field>
        <lookupValue>Mobile_Number</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Mobile</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>No_number_is_given</fullName>
        <description>if this is true then it will fire this workflow</description>
        <field>RecordTypeId</field>
        <lookupValue>No_Number</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>No number is given</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Phone</fullName>
        <description>It will update phone number field</description>
        <field>RecordTypeId</field>
        <lookupValue>Landline</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Phone</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>DNC</fullName>
        <actions>
            <name>DNC</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>do not call rule for user to specify if give a call or not</description>
        <formula>AND( DoNotCall ==TRUE)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Landline Number</fullName>
        <actions>
            <name>Update_Phone</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>if landline number is specified it will fire this type of workflow</description>
        <formula>AND( MobilePhone ==NULL, Phone  &lt;&gt; NULL, DoNotCall ==FALSE)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Mobile Number</fullName>
        <actions>
            <name>Mobile</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If mobile number is not specified then it will fire this type of workflow</description>
        <formula>AND( MobilePhone &lt;&gt; NULL , Phone ==NULL, DoNotCall==FALSE )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>No Number</fullName>
        <actions>
            <name>No_number_is_given</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>if this no number field is not selected then then it will fire this workflow</description>
        <formula>AND(  ISBLANK( MobilePhone), ISBLANK( Phone ) , DoNotCall ==FALSE  )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Time Based Follow Up</fullName>
        <actions>
            <name>Followup_date</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>if follow up time is elapsed then will send a email</description>
        <formula>Follow_up_of_date__c &lt; TODAY()</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
