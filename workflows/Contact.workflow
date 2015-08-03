<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Approval</fullName>
        <description>here is new mail for manager to approve a leave for a employee</description>
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
        <template>unfiled$public/SupportCaseResponse</template>
    </alerts>
    <tasks>
        <fullName>Test_Task</fullName>
        <assignedTo>monali.nagpure@eternussolutions.com</assignedTo>
        <assignedToType>user</assignedToType>
        <description>This is a Test Task</description>
        <dueDateOffset>30</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Contact.Birthdate</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>In Progress</status>
        <subject>Test Task</subject>
    </tasks>
</Workflow>
