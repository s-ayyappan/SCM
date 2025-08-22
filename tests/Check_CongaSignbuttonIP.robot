*** Settings ***
Library    QForce
Library    QWeb
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Check No CongaSign button PRCR no Signers
    [tags]                    Contract Agreement, PR, PRCR
    [Documentation]           Send with CongaSign button should be hidden if there is no PRCR with "Signers"          
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Contract Agreements

#search contract agreement
    ClickText    Select a List View: Contract Agreements
    ClickText    All
    TypeText    Search this list...    CON-000258\n    anchor=Created By, Created Date, and Type of Title aren't searchable. Use filters or sort on these fields instead.
    ClickText    CON-000258

#check the Congasign button
    ClickText    Show more actions
    VerifyText    Show more actions
    VerifyText    Submit for Approval
    VerifyText    Edit
    VerifyText    My Approvals
    VerifyText    Preview & Submit Approvals

#click the PR and navigate to the PRCR
    ClickText    PR-00005621
    ClickText    Related

#click the PRCR
    SwipeDown
    ClickText    Permission Request Contact Roles
    VerifyText   Signer
