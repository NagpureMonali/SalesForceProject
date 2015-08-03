<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Deactivation_of_account</fullName>
        <description>if employee is not active then send a mail to project manager</description>
        <protected>true</protected>
        <recipients>
            <recipient>monali.nagpure@eternussolutions.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Email</template>
    </alerts>
    <fieldUpdates>
        <fullName>Update</fullName>
        <description>it will update role unique field</description>
        <field>Unique_for_role__c</field>
        <formula>Role__r.Role_Id__c</formula>
        <name>Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_record_type</fullName>
        <description>here is rule to set record type as technical</description>
        <field>RecordTypeId</field>
        <lookupValue>Technical_Employee</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update record type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>change_Recordtype</fullName>
        <description>here is rule to update value of recordtype to nontechanical when ‘Current Employee’ is false</description>
        <field>RecordTypeId</field>
        <lookupValue>Nontechnical_Employee</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>change Recordtype</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>New Role</fullName>
        <actions>
            <name>Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>here is new role for employee</description>
        <formula>TRUE</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Nontechnical Record Type</fullName>
        <actions>
            <name>change_Recordtype</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Employee__c.Current_Employee__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>here is rule to set the record type to Non technical when ‘Current Employee’ is false</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Owner Update</fullName>
        <active>true</active>
        <description>It will update owner of object</description>
        <formula>TRUE</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Record Deactivate</fullName>
        <actions>
            <name>Deactivation_of_account</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Employee__c.Is_Active__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>when record is not active then send mail to project manager</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Technical Record Type</fullName>
        <actions>
            <name>Update_record_type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Employee__c.Current_Employee__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>here is rule to to set record type as technical when current employee is true</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
