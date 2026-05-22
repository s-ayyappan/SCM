*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite
Test Teardown                 Test Cleanup

*** Variables ***
# Wait Times
${WAIT_SHORT}                2s
${WAIT_MEDIUM}               3s
${WAIT_LONG}                 5s 

# Selectors
${NEW_BUTTON}                New
${CANCEL_CLOSE_BUTTON}             Cancel and close

*** Test Cases ***
Accounts Tab UI Checks
    [Documentation]    Check Account UI
    [Tags]             New    Account  Critical
    Launch Account Application

#capture the UI objects
    VerifyText    Import
    HoverText     New
    VerifyText    New
    TypeText      Search this list...    xyz\n    anchor=PRM Account, Owner Last Name, and Created Date aren't searchable. Use filters or sort on these fields instead.
    ClickText     ${NEW_BUTTON}
    ClickText     New    anchor=Search this list...
    VerifyText    *Search Keyword
    ClickText     *Search Keyword
    VerifyText    New Account:
    VerifyText    Search
    TypeText      Enter Keyword To Search For An Organisation...    sample
    ClickText     Search    partial_match=False
    VerifyText    Create New Account
    VerifyText    Cancel
    ClickText     Create New Account
    UseModal      On
    VerifyText    New Account: SCM Account
    VerifyText    Account Information
    VerifyPickList    *Account Currency
    VerifyText    Parent Account
    VerifyText    Account Owner
    VerifyText    Phone
    VerifyText    *Account Name
    VerifyText    PRM Account
    VerifyText    Publisher Display Name
    VerifyText    PRM Member Updated
    VerifyPickList    Preferred CAR Supplier
    VerifyText    CM Member Updated
    VerifyText    Website
    VerifyText    Is Sensitive
    VerifyText    OBII Id
    VerifyText    Imprint Publisher Account
    VerifyText    Account Incomplete   
    VerifyText    Requires Welcome Ema
    VerifyPickList    Type of Content Provider
    VerifyPickList    Disciplines
    VerifyText    Description
    VerifyText    Select a date for Date
    VerifyText    Billing Address
    VerifyText    Address Search
    VerifyPickList    Billing Country
    VerifyText    Billing Address
    VerifyText    Billing Street
    VerifyText    Billing City
    VerifyPickList    Billing State/Province
    VerifyText    Billing State
    VerifyText    ECH City
    VerifyText    ECR Id
    VerifyText    ECH Region
    VerifyText   ECH Registration State   
    PickList    ECH Registration State    NOT_REGISTERED
    VerifyText    ECH Country
    VerifyText    ECH Send Date
    VerifyText    ECH Postcode
    VerifyText    ECH Send To
    VerifyPickList    ECH Customer Set
    VerifyText    ECH Send Error
    VerifyText    ECH Created Date
    VerifyText    Date
    VerifyText    ECH Created Date
    VerifyText    Time
    VerifyPickList    ECH Sales Division
    VerifyText    ECH Last Modified Date
    VerifyText    Date
    VerifyText    Time
    VerifyText    ECH Classification
    VerifyText    ECH Update Date
    VerifyText    Date
    VerifyText    Time
    VerifyText    ECH Actual Start Date
    VerifyText    ECH End Date
    VerifyPickList    ECH Business Division
    VerifyText    Cancel
    VerifyText    Save & New
    VerifyText    Save
    UseModal      Off
    ClickText     ${CANCEL_CLOSE_BUTTON} 

*** Keywords ***
#----------------------------------
# Test Cleanup
#----------------------------------
Launch Account Application
    [Documentation]    Navigate to Accounts application
    Appstate          Home
    Sleep             ${WAIT_SHORT}
    LaunchApp         Accounts
    Sleep             ${WAIT_SHORT}
    Log               Account application launched

Test Cleanup
    [Documentation]    Cleanup after each test case
    Run Keyword If Test Failed    Capture Context
    ${cleanup_status}=    Run Keyword And Return Status    Cleanup Created Records
    Run Keyword Unless    ${cleanup_status}    Log    Cleanup may have failed    WARN