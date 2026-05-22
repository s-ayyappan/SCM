*** Settings ***
Documentation     Account Tab UI validation tests
Library           QForce
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End Suite
Test Teardown     Test Cleanup

*** Variables ***
# Wait Times
${WAIT_SHORT}                2s
${WAIT_MEDIUM}               3s
${WAIT_LONG}                 5s 

# Selectors
${NEW_BUTTON}                New
${CANCEL_BUTTON}             Cancel
${SEARCH_BUTTON}             Search

*** Test Cases ***
Accounts Tab UI Checks
    [Documentation]    Check Account UI
    [Tags]             New    Account    Critical
    
    Launch Account Application
    
    # Verify list view
    VerifyText        Import
    HoverText         New
    VerifyText        New
    
    # Open new account form
    ClickText         ${NEW_BUTTON}
    Sleep             ${WAIT_SHORT}
    VerifyText        New Account:
    VerifyText        *Search Keyword
    
    # Search for organization
    TypeText          Enter Keyword To Search For An Organisation...    sample
    Sleep             1s
    ClickText         Search    partial_match=False
    Sleep             ${WAIT_SHORT}
    
    # Open SCM Account form
    VerifyText        Create New Account
    VerifyText        Cancel
    ClickText         Create New Account
    UseModal          On
    Sleep             ${WAIT_SHORT}
    
    # Verify Account Information section
    VerifyText        New Account: SCM Account
    VerifyText        Account Information
    VerifyPickList    *Account Currency
    VerifyText        Parent Account
    VerifyText        Account Owner
    VerifyText        Phone
    VerifyText        *Account Name
    VerifyText        PRM Account
    VerifyText        Publisher Display Name
    VerifyText        PRM Member Updated
    VerifyPickList    Preferred CAR Supplier
    VerifyText        CM Member Updated
    VerifyText        Website
    VerifyText        Is Sensitive
    VerifyText        OBII Id
    VerifyText        Imprint Publisher Account
    VerifyText        Account Incomplete   
    VerifyText        Requires Welcome Ema
    VerifyPickList    Type of Content Provider
    VerifyPickList    Disciplines
    VerifyText        Description
    VerifyText        Select a date for Date
    
    # Verify Billing Address section
    VerifyText        Billing Address
    VerifyText        Address Search
    VerifyPickList    Billing Country
    VerifyText        Billing Street
    VerifyText        Billing City
    VerifyPickList    Billing State/Province
    VerifyText        Billing State
    
    # Verify ECH section
    VerifyText        ECH City
    VerifyText        ECR Id
    VerifyText        ECH Region
    VerifyText        ECH Registration State
    VerifyText        ECH Country
    VerifyText        ECH Send Date
    VerifyText        ECH Postcode
    VerifyText        ECH Send To
    VerifyPickList    ECH Customer Set
    VerifyText        ECH Send Error
    VerifyText        ECH Created Date
    VerifyText        Date
    VerifyText        Time
    VerifyPickList    ECH Sales Division
    VerifyText        ECH Last Modified Date
    VerifyText        ECH Classification
    VerifyText        ECH Update Date
    VerifyText        ECH Actual Start Date
    VerifyText        ECH End Date
    VerifyPickList    ECH Business Division
    
    # Verify action buttons
    VerifyText        Cancel
    VerifyText        Save & New
    VerifyText        Save
    
    # Close the form
    ClickText         Cancel
    Sleep             ${WAIT_SHORT}
    UseModal          Off

*** Keywords ***
Launch Account Application
    [Documentation]    Navigate to Accounts application
    Appstate          Home
    Sleep             ${WAIT_SHORT}
    LaunchApp         Accounts
    Sleep             ${WAIT_MEDIUM}
    Log               Account application launched

Test Cleanup
    [Documentation]    Cleanup after each test case
    Run Keyword If Test Failed    Capture Context
    Run Keyword And Ignore Error  Close Any Open Modals
    Log               Test cleanup completed

Close Any Open Modals
    [Documentation]    Attempt to close any open modals
    ${cancel_exists}=    Run Keyword And Return Status    ClickText    Cancel    timeout=2s
    Run Keyword If    ${cancel_exists}    UseModal    Off
    Log               Modals closed if any were open