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
${SAVE_BUTTON}               Save
${CANCEL_BUTTON}             Cancel
${SEARCH_BUTTON}             Search

*** Test Cases ***
Accounts Tab UI Checks
    [Documentation]    Verify all UI elements are present on Account creation form
    [Tags]             UI    Account    Critical    Smoke
    
    Launch Account Application
    Verify Account List View Elements
    Open New Account Form
    Verify Account Search Modal
    Open SCM Account Creation Form
    Verify Account Information Section
    Verify Billing Address Section
    Verify ECH Section
    Close Account Form

*** Keywords ***
#----------------------------------
# Application Navigation
#----------------------------------
Launch Account Application
    [Documentation]    Navigate to Accounts application
    Appstate          Home
    Sleep             ${WAIT_SHORT}
    LaunchApp         Accounts
    Sleep             ${WAIT_MEDIUM}
    Log               Account application launched

#----------------------------------
# UI Verification Keywords
#----------------------------------
Verify Account List View Elements
    [Documentation]    Verify elements on Account list view
    VerifyText        Import
    VerifyText        New
    VerifyText        Search this list...
    HoverText         New
    Log               Account list view elements verified

Open New Account Form
    [Documentation]    Open new account creation flow
    ClickText         ${NEW_BUTTON}
    Sleep             ${WAIT_SHORT}
    VerifyText        New Account:
    Log               New account form opened

Verify Account Search Modal
    [Documentation]    Verify search modal elements
    VerifyText        *Search Keyword
    VerifyText        Search
    TypeText          Enter Keyword To Search For An Organisation...    sample
    Sleep             1s
    ClickText         ${SEARCH_BUTTON}    partial_match=False
    Sleep             ${WAIT_SHORT}
    
    # Verify search results modal
    VerifyText        Create New Account
    VerifyText        Cancel
    Log               Search modal verified

Open SCM Account Creation Form
    [Documentation]    Open SCM Account creation form from search results
    ClickText         Create New Account
    UseModal          On
    Sleep             ${WAIT_SHORT}
    VerifyText        New Account: SCM Account
    Log               SCM Account form opened

Verify Account Information Section
    [Documentation]    Verify all fields in Account Information section
    
    # Section header
    VerifyText        Account Information
    
    # Required fields
    VerifyText        *Account Name
    VerifyPickList    *Account Currency
    
    # Standard fields
    VerifyText        Parent Account
    VerifyText        Account Owner
    VerifyText        Phone
    VerifyText        Website
    
    # Custom fields
    VerifyText        PRM Account
    VerifyText        Publisher Display Name
    VerifyText        PRM Member Updated
    VerifyText        CM Member Updated
    VerifyText        Is Sensitive
    VerifyText        OBII Id
    VerifyText        Imprint Publisher Account
    VerifyText        Account Incomplete   
    VerifyText        Requires Welcome Ema
    
    # Picklists
    VerifyPickList    Preferred CAR Supplier
    VerifyPickList    Type of Content Provider
    VerifyPickList    Disciplines
    
    # Other fields
    VerifyText        Description
    VerifyText        Select a date for Date
    
    Log               Account Information section verified

Verify Billing Address Section
    [Documentation]    Verify all fields in Billing Address section
    
    # Section header
    VerifyText        Billing Address
    
    # Address fields
    VerifyText        Address Search
    VerifyPickList    Billing Country
    VerifyText        Billing Street
    VerifyText        Billing City
    VerifyPickList    Billing State/Province
    VerifyText        Billing State
    
    Log               Billing Address section verified

Verify ECH Section
    [Documentation]    Verify all ECH (Enterprise Customer Hub) fields
    
    # ECH fields - General
    VerifyText        ECH City
    VerifyText        ECR Id
    VerifyText        ECH Region
    VerifyText        ECH Registration State   
    VerifyText        ECH Country
    VerifyText        ECH Postcode
    VerifyText        ECH Send To
    
    # ECH Picklists
    VerifyPickList    ECH Customer Set
    VerifyPickList    ECH Sales Division
    VerifyPickList    ECH Business Division
    
    # ECH Status fields
    VerifyText        ECH Send Date
    VerifyText        ECH Send Error
    VerifyText        ECH Classification
    
    # ECH Date fields
    VerifyText        ECH Created Date
    VerifyText        ECH Last Modified Date
    VerifyText        ECH Update Date
    VerifyText        ECH Actual Start Date
    VerifyText        ECH End Date
    
    # Date/Time labels (appear multiple times)
    VerifyText        Date
    VerifyText        Time
    
    Log               ECH section verified

Close Account Form
    [Documentation]    Close the account creation form without saving
    
    # Verify action buttons exist
    VerifyText        Cancel
    VerifyText        Save & New
    VerifyText        ${SAVE_BUTTON}
    
    # Close modal
    UseModal          Off
    Sleep             1s
    ClickText         Cancel
    Sleep             ${WAIT_SHORT}
    
    Log               Account form closed

#----------------------------------
# Test Cleanup
#----------------------------------
Test Cleanup
    [Documentation]    Cleanup after each test case
    
    Run Keyword If Test Failed    Capture Context
    Run Keyword And Ignore Error  Close Any Open Modals
    ${cleanup_status}=    Run Keyword And Return Status    Cleanup Created Records
    Run Keyword Unless    ${cleanup_status}    Log    Cleanup may have failed    WARN

Close Any Open Modals
    [Documentation]    Attempt to close any open modals
    ${cancel_exists}=    Run Keyword And Return Status    ClickText    Cancel    timeout=2s
    Run Keyword If    ${cancel_exists}    UseModal    Off

Cleanup Created Records
    [Documentation]    Cleanup any created test data (if applicable)
    # This test only checks UI, no data is created
    # Add cleanup logic here if test evolves to create accounts
    Log    No records to cleanup - UI check only