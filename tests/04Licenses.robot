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
    VerifyText    Agreement Type   
    VerifyText    Is Sensitive    
    VerifyText    Currency    
    VerifyText    End Date                ${EMPTY}
    VerifyText    Description             ${EMPTY}
    VerifyText    Description             ${EMPTY}
    VerifyText    Do Not Renew  
    VerifyText    Status
    VerifyText    Origin       
    VerifyText    Negotiation License     ${EMPTY}
    VerifyText    Automatic Renewal    
    ClickText     Related
    ClickText     Source Link Management


