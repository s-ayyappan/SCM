*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Permission Requests UI Check
    [tags]                    Permission Request
    [Documentation]           Test to check Permission Request edit UI                    
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Permission Requests

    ClickText    Select a List View: Permission Requests
    ClickText    All Permission Requests
    TypeText     Search this list...    PR-00025133\n    anchor=Clear
    ClickText    PR-00025133
    VerifyText   PR-00025133


    HoverText    Edit
    HoverText    Cancel Permission Request
    HoverText    Create Contract Amendment
    HoverText    Create Contract Agreement
    HoverText    Send with DS.
    HoverText    Delete
    HoverText    Clone
    ClickText    Edit    partial_match=False
    UseModal     On
    VerifyText   Information
    VerifyText   Edit
    VerifyText   Permission Request Name
    VerifyText   Owner
    HoverText    Title Id
    VerifyText   Title Id
    ClickText    Title Id    partial_match=False
    VerifyText   Project
    VerifyText    Title Name
    VerifyText    PRM License Approved
    VerifyText    *Permission Holder
    VerifyText    Is PRM
    VerifyText    Start Date
    VerifyText    Remark
    VerifyText    End Date
    VerifyText    Type Code
    VerifyText    OBII Id
    VerifyText    Renewal Generated
    VerifyText    Last Refresh Date
    VerifyText    Version
    VerifyText    Previous version
    VerifyPickList    Type of Title    Type of Title
    VerifyPickList    Currency    Currency
    VerifyText    Requires Welcome Email
    VerifyText    Communication Project
    VerifyText    Contact
    VerifyText    Clear Selection\nContact Email
    VerifyText    Status
    VerifyText    Reject Remark
    VerifyText    Reviewed
    VerifyText    Cancellation Status
    VerifyText    Additional Details for Cancellation
    VerifyText    Cancellation Reason
    VerifyText    Reminder Settings
    VerifyText    Reminder due Sending
    VerifyText    Stop Reminder Emails
    VerifyText    Initial Contact Date Stamp
    VerifyText    Next Reminder Date
    VerifyText    Next Step Name
    VerifyText    Reminder Override Flag
    VerifyText    License
    VerifyText    Is Sensitive
    VerifyText    Key
    VerifyText    Form Content Delivery
    VerifyText    Content Delivery
    VerifyText    Web Access
    VerifyText    SubmitMethodURL
    VerifyText    Content Delivery Provided By
    VerifyText    Web Access Credentials Receive
    VerifyText    WA Credentials Request Email Sent
    VerifyText    Welcome Emails
    VerifyText    First Welcome Email Sent Date
    VerifyText    Second Welcome Email Date
    VerifyText    Third Welcome Email Sent Date
    VerifyText    Second Welcome Email Sen
    VerifyText    Requires Welcome Email
    VerifyText    Permission Holder Requires Welcome Email
    VerifyText    Conga Signer Fields
    VerifyText    Signer Contact Email
    VerifyText    Signer Contact Name
    VerifyText    Signer Contact Job Title
    VerifyText    Signed Date
    VerifyText    Audit Fields
    VerifyText    Contacted Permission Holder Date\nDate\n\nSelect a date for Date
    VerifyText    Permission Granted Date
    VerifyText    Reviewed Date
    VerifyText    Permission Request Send Date
    VerifyText    PRM Approved Date
    VerifyText    Invoiceable Value
    VerifyText    Signer Added Date/Time
    VerifyText    Content Delivery Submitted Date/Time
    VerifyText    PR Contact Role Created Date
    VerifyText    System Information
    VerifyText    Created By
    VerifyText    Last Modified By
    VerifyText    Lock Record
    VerifyText    Date Locked
    HoverText    Cancel
    HoverText    Save & New
    HoverText    Save
    UseModal    Off
    