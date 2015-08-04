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
        <template>unfiled$public/For_opportunity</template>
    </alerts>
</Workflow>
