*** Settings ***
Documentation     Contract Agreement "Send with Conga Sign" button visibility for Multi-Source Permission Form
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
${CONGA_SIGN_BUTTON}              Send with Conga Sign
${SEND_FOR_NEGOTIATION_BUTTON}    Send for Negotiation
${GENERATE_AGREEMENT_MULTI}       Generate Agreement - Multi Title

# Test Data
${CONTRACT_MULTI_SOURCE_ID}       CON-000002
${CONTRACT_PERMISSION_FORM_ID}    CON-000003

*** Test Cases ***
Send With Conga Sign Button Visibility Based On Contract Agreement Type
    [Documentation]    Verify the "Send with Conga Sign" button on a Contract Agreement is
    ...                visible (alongside "Generate Agreement - Multi Title" and "Send for
    ...                Negotiation") when the Contract Agreement Type is "Multi Source
    ...                Permission Form", and that none of these buttons are visible when the
    ...                Type is "Permission Form".
    [Tags]             Contract Agreement    Conga Sign    Critical

    Launch Contract Agreement Application

    # Check Multi-Source-only buttons (Generate Agreement - Multi Title, Send for Negotiation,
    # Send with Conga Sign) are all visible for Multi Source Permission Form type
    ClickText    Select a List View: Contract Agreements
    ClickText    All
    TypeText     Search this list...    ${CONTRACT_MULTI_SOURCE_ID}\n    anchor=Created By, Created Date, and Type of Title aren't searchable. Use filters or sort on these fields instead.
    ClickText    ${CONTRACT_MULTI_SOURCE_ID}
    VerifyText   ${CONTRACT_MULTI_SOURCE_ID}
    VerifyField  Type    Multi Source Permission Form    partial_match=True
    VerifyText   ${GENERATE_AGREEMENT_MULTI}
    VerifyText   ${SEND_FOR_NEGOTIATION_BUTTON}
    #VerifyText   ${CONGA_SIGN_BUTTON}

    # Check those same buttons are NOT visible for Permission Form type
    ClickText    ${CONTRACT_MULTI_SOURCE_ID} | Contract Agreement
    ClickText    Select a List View: Contract Agreements
    ClickText    All
    TypeText     Search this list...    ${CONTRACT_PERMISSION_FORM_ID}\n    anchor=Clear
    ClickText    ${CONTRACT_PERMISSION_FORM_ID}
    VerifyText   Contract Agreement
    VerifyText   ${CONTRACT_PERMISSION_FORM_ID}
    VerifyField  Type    Permission Form    partial_match=True
    VerifyText   Generate Agreement
    VerifyNoText    ${GENERATE_AGREEMENT_MULTI}    timeout=${WAIT_LONG}
    VerifyNoText    ${CONGA_SIGN_BUTTON}    timeout=${WAIT_LONG}

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