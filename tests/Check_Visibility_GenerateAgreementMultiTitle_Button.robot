*** Settings ***
Documentation     Account Tab UI validation tests
Library           QForce
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End Suite

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
    
    Launch Contract Agreement Application







*** Keywords ***
Launch Contract Agreement Application
    [Documentation]    Navigate to Accounts application
    Appstate          Home
    Sleep             ${WAIT_SHORT}
    LaunchApp         Contract Agreements
    Sleep             ${WAIT_MEDIUM}
    Log               Account application launched
