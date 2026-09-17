*** Settings ***
Library    QForce
Library    QWeb
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Licenses Tab UI Checks
    [tags]                    Licenses
    [Documentation]           Licenses tab UI check
    Appstate                  Home
    LaunchApp                 Licenses
    Sleep                     2s    

#capture the UI objects for an existing License 
   
    ClickText    Select a List View: Licenses
    ClickText    All
    TypeText       Search this list...    L-011841\n
    ClickText      L-011841
    VerifyText     L-011841
    VerifyText     Status
    VerifyText     Agreement Date
    VerifyText     License Template
    VerifyField    Agreement Type    License agreement    partial_match=True
    VerifyField    Is Sensitive    Is Sensitive    partial_match=True
    VerifyField    Currency    EUR - Euro    partial_match=True
    VerifyField    End Date    ${EMPTY}
    VerifyField    Description    ${EMPTY}
    VerifyField    Description    ${EMPTY}
    VerifyField    Do Not Renew    Do Not Renew    partial_match=True
    VerifyField    Status    Draft    partial_match=True
    VerifyField    Origin    Salesforce    partial_match=True
    VerifyField    Negotiation License    ${EMPTY}
    VerifyField    Automatic Renewal    Automatic Renewal    partial_match=True
    ClickText     Related
    ClickText     Source Link Management


