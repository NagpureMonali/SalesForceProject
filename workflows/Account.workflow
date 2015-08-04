<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>New_Value</fullName>
        <description>if value of type is prospect then it will set value of type as other</description>
        <field>Type</field>
        <literalValue>Other</literalValue>
        <name>New Value</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update</fullName>
        <description>will update field value</description>
        <field>Type</field>
        <literalValue>Other</literalValue>
        <name>Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update1</fullName>
        <description>update type value filed</description>
        <field>Type</field>
        <literalValue>Other</literalValue>
        <name>Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Field</fullName>
        <description>it will update filed value</description>
        <field>Type</field>
        <literalValue>Prospect</literalValue>
        <name>Update Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Value</fullName>
        <description>value of tyep will be updated to other</description>
        <field>Type</field>
        <literalValue>Other</literalValue>
        <name>Update Value</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Value_field</fullName>
        <description>it will update field value</description>
        <field>Type</field>
        <literalValue>Other</literalValue>
        <name>Update Value field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>change_value</fullName>
        <description>value of type field will get changed to prospect</description>
        <field>Type</field>
        <literalValue>Prospect</literalValue>
        <name>change value</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Update Value Field</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Account.Type</field>
            <operation>equals</operation>
            <value>Prospect</value>
        </criteriaItems>
        <description>it will update value field</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Update1</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Account.CreatedDate</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <tasks>
        <fullName>change_value</fullName>
        <assignedToType>owner</assignedToType>
        <description>value should change to other</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Account.CreatedDate</offsetFromField>
        <priority>High</priority>
        <protected>true</protected>
        <status>Not Started</status>
        <subject>change value</subject>
    </tasks>
</Workflow>
