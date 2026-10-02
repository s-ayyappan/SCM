*** Settings ***
Documentation     Contract Agreement 'Send with Conga Sign' Button on Contract Agreement for Multi-Source Permission Form
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
${CONTRACT_DYNAMIC_TYPE_ID}       CON-000005

*** Test Cases ***
Generate Agreement Button Visibility Based On Contract Agreement Type
    [Documentation]    Verify the "'Send with Conga Sign' Button on Contract Agreement for Multi-Source Permission Form is visible when the
    ...                Contract Agreement Type is "Multi Source Permission Form", 
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

    # Check changing the Agreement Type dynamically toggles the "Generate Agreement - Multi Title" button
    ClickText    ${CONTRACT_MULTI_SOURCE_ID} | Contract Agreement
    ClickText    Select a List View: Contract Agreements
    ClickText    All
    TypeText     Search this list...    ${CONTRACT_DYNAMIC_TYPE_ID}\n    anchor=Created By, Created Date, and Type of Title aren't searchable. Use filters or sort on these fields instead.
    ClickText    ${CONTRACT_DYNAMIC_TYPE_ID}
    VerifyText   Generate Agreement
    VerifyField  Type    License    partial_match=True
    VerifyNoText    Generate Agreement - Multi Title                     ${WAIT_LONG}

    Change Contract Agreement Type    Multi Source Permission Form
    VerifyText      Generate Agreement - Multi Title

    Change Contract Agreement Type    License
    VerifyNoText    Generate Agreement - Multi Title                     ${WAIT_LONG}
    VerifyText      Generate Agreement

    # Check "Generate Agreement - Multi Title" button is NOT visible for Permission Form type
    ClickText    ${CONTRACT_DYNAMIC_TYPE_ID} | Contract Agreement
    ClickText    Select a List View: Contract Agreements
    ClickText    All
    TypeText     Search this list...    ${CONTRACT_PERMISSION_FORM_ID}\n    anchor=Clear
    ClickText    ${CONTRACT_PERMISSION_FORM_ID}
    VerifyText   Contract Agreement
    VerifyText   ${CONTRACT_PERMISSION_FORM_ID}
    VerifyField  Type    Permission Form    partial_match=True
    VerifyText   Generate Agreement
    VerifyNoText    Generate Agreement - Multi Title                        ${WAIT_LONG}

*** Keywords ***
Launch Contract Agreement Application
    [Documentation]    Navigate to the Contract Agreements application
    Appstate          Home
    Sleep             ${WAIT_SHORT}
    LaunchApp         Contract Agreements
    Sleep             ${WAIT_MEDIUM}
    Log               Contract Agreement application launched

Change Contract Agreement Type
    [Documentation]    Edit the Contract Agreement's Type field to the given value and save
    [Arguments]    ${new_type}
    ClickText    Edit Type
    PickList     *Type    ${new_type}
    ClickText    Save
    Sleep        ${WAIT_SHORT}