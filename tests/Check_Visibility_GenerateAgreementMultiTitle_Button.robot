*** Settings ***
Documentation     Contract Agreement "Generate Agreement" button visibility tests
Library           QForce
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End Suite

*** Variables ***
# Wait Times
${WAIT_SHORT}                     2s
${WAIT_MEDIUM}                    3s
${WAIT_LONG}                      5s

# Selectors
${NEW_BUTTON}                     New
${CANCEL_BUTTON}                  Cancel
${SEARCH_BUTTON}                  Search

# Test Data
${CONTRACT_MULTI_SOURCE_ID}       CON-000002
${CONTRACT_PERMISSION_FORM_ID}    CON-000003

*** Test Cases ***
Generate Agreement Button Visibility Based On Contract Agreement Type
    [Documentation]    Verify the "Generate Agreement - Multi Title" button is visible when the
    ...                Contract Agreement Type is "Multi Source Permission Form", and that only
    ...                the standard "Generate Agreement" button (without the Multi Title variant)
    ...                is visible when the Type is "Permission Form".
    [Tags]             Contract Agreement    Generate Agreement    Critical

    Launch Contract Agreement Application

    # Check "Generate Agreement - Multi Title" button is visible for Multi Source Permission Form type
    ClickText    Select a List View: Contract Agreements
    ClickText    All
    TypeText     Search this list...    ${CONTRACT_MULTI_SOURCE_ID}\n    anchor=Created By, Created Date, and Type of Title aren't searchable. Use filters or sort on these fields instead.
    ClickText    ${CONTRACT_MULTI_SOURCE_ID}
    VerifyText   ${CONTRACT_MULTI_SOURCE_ID}
    VerifyField  Type    Multi Source Permission Form    partial_match=True
    VerifyText   Generate Agreement - Multi Title

    # Check "Generate Agreement - Multi Title" button is NOT visible for Permission Form type
    ClickText    ${CONTRACT_MULTI_SOURCE_ID} | Contract Agreement
    ClickText    Select a List View: Contract Agreements
    ClickText    All
    TypeText     Search this list...    ${CONTRACT_PERMISSION_FORM_ID}\n    anchor=Clear
    ClickText    ${CONTRACT_PERMISSION_FORM_ID}
    VerifyText   Contract Agreement\n${CONTRACT_PERMISSION_FORM_ID}
    VerifyField  Type    Permission Form    partial_match=True
    VerifyText   Generate Agreement
    VerifyNoText    Generate Agreement - Multi Title

*** Keywords ***
Launch Contract Agreement Application
    [Documentation]    Navigate to the Contract Agreements application
    Appstate          Home
    Sleep             ${WAIT_SHORT}
    LaunchApp         Contract Agreements
    Sleep             ${WAIT_MEDIUM}
    Log               Contract Agreement application launched