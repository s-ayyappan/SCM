*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Check LWC Email in PR
    [tags]                    PR, Emails
    [Documentation]           Check the PR email LWC functionality objects are displaying as expected in UI
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Permission Requests

#check the UI components in the LWC email
    ClickText    PR-00024535
#navigate to email tab and check the email flow
    ClickText    Email    anchor=Related
    VerifyText   Role
    ClickText    Select an Option    anchor=Role
    ClickText    None    anchor=Skip to Navigation
    ClickText    Show All
    ClickText    Show All From Filter
    ClickText    Select All
    ClickText    Select All From Filter
    ClickText    Show Selected Rows
    SwipeDown
    ClickText    Next
    ClickText    Select Template    anchor=Email Templates
    ClickText    Renewal Notice Batch 2    anchor=Skip to Navigation
    ClickText    Select From Address    anchor=*From Address
    ClickText    Default No-Reply    anchor=Skip to Navigation
    ClickText    Next
    SwipeDown
    VerifyText   Send Email
    ScrollText   Recent Items
    ClickText    Next
    ScrollText   Recent Items
    ClickText    Email    anchor=Related
    ClickText    Related
    SwipeUp
    Sleep        5s
    RefreshPage
    Sleep        5s
#check email sent today is present
    VerifyText   Today
    VerifyText   Elsevier Permissions: Renewing your licence : {{{Permission_Contact_Role__c.PR_Name__c}}} Sent To 1 Recipients
    ClickText    Permission Requests
    Log          Email function objects present as expected