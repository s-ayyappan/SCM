*** Settings ***
Documentation     Create Contract Agreement button visibility
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
Create Contract Agreement button visibility
    [Documentation]     Create Contract Agreement button visibility based on License template
    [Tags]             New    License  Permission Request    Critical

    Launch Account Application











*** Keywords ***
Launch Account Application
    [Documentation]    Navigate to Accounts application
    Appstate          Home
    Sleep             ${WAIT_SHORT}
    LaunchApp         Accounts
    Sleep             ${WAIT_MEDIUM}
    Log               Account application launched