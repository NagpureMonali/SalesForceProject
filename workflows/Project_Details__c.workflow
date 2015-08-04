<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email</fullName>
        <description>To notify project manager That project end date is after 5 days</description>
        <protected>true</protected>
        <recipients>
            <recipient>monali.nagpure@eternussolutions.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Reminder_Mail_Template</template>
    </alerts>
    <alerts>
        <fullName>Proj_Created</fullName>
        <description>Here is new mail for project manager that new project is created</description>
        <protected>true</protected>
        <recipients>
            <recipient>HR_Manager</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Project_Assignment</template>
    </alerts>
    <fieldUpdates>
        <fullName>Status</fullName>
        <description>to set the Project status as Closed if the End Date is today.</description>
        <field>Status__c</field>
        <literalValue>Closed</literalValue>
        <name>Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>New Project</fullName>
        <actions>
            <name>Proj_Created</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>New_project_is_created_and_it_is_assigned_to_you_Project_manager</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project_Details__c.CreatedById</field>
            <operation>equals</operation>
            <value>Monali Nagpure</value>
        </criteriaItems>
        <description>here is new mail for project manager that new project is created</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Reminder Mail</fullName>
        <active>true</active>
        <description>it is mail to project manager that project end date is after 5 days</description>
        <formula>End_Date__c  &lt;&gt; NULL</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Email</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Project_Details__c.End_Date__c</offsetFromField>
            <timeLength>-5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Status Closed</fullName>
        <actions>
            <name>Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>to set the project status as closed if the end date is today.</description>
        <formula>IF(  End_Date__c == TODAY() , TRUE, FALSE)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>New_project_is_created_and_it_is_assigned_to_you_Project_manager</fullName>
        <assignedTo>HR_Manager</assignedTo>
        <assignedToType>role</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Project_Details__c.CreatedDate</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>New project is created and it is assigned to you(Project manager)</subject>
    </tasks>
</Workflow>
