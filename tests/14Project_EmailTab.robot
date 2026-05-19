*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Check Project Email Tab Loading
    [tags]                    Project
    [Documentation]           Check the Project Email Tab is loading with all necessary objects
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Projects

#check the UI components for project app
    ClickText    CRT Project
#navigate to Project tab and check the default objects
    
    VerifyText     Project
    ClickText      Details
    VerifyField    Project Name    CRT Project    partial_match=True
    VerifyField    Description    Do not delete as this is used for CRT automated regression    partial_match=True
    VerifyField    Renewal Project    Renewal Project    partial_match=True
#navigate to the Project Email tab and check the filters
    ClickText      Email    anchor=Details
    VerifyText    Role__c
    VerifyText    Permission_Request_Status__c
    VerifyText    false    anchor=Show All
    VerifyText    PR_Owner__c
    VerifyText    false    anchor=Show All
    VerifyText    Stop_Reminder_Emails__c
    VerifyText    false    anchor=Show All
    HoverText     Remove false
    VerifyText    Contact_Email_Bounced__c
    VerifyText    false    anchor=Show All
    VerifyText    License_Template__c
    VerifyText    false    anchor=Show All
    VerifyText    Contact_Inactive__c
    VerifyText    false    anchor=Show All
    VerifyText    Permission_Holder_Name__c
    VerifyText    false    anchor=Show All
    HoverText     Contact Name
    VerifyText    Contact Name
    VerifyText    Contact Email
    VerifyText    Role
    VerifyText    Permission Request Name
    VerifyText    Permission Request Status
    VerifyText    PR Owner
    VerifyText    Stop Reminder Emails
    VerifyText    Contact Email Bounced
    VerifyText    License Template
    VerifyText    Contact Inactive
    VerifyText    Permission Holder Name
    SwipeDown    
    ClickText    Next
    Log            All Project Email tab objects displayed as expected

