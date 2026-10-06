*** Settings ***
Library           QForce
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End Suite

*** Variables ***
# Wait Times
${WAIT_SHORT}                2s
${WAIT_MEDIUM}               3s
${WAIT_LONG}                 5s

# Test Data
${CONTRACT_ID}                CON-000003
${LINKED_PR}                  PR-00004669
${OWNER_NAME}                  Elavenhil PallipattiMohan

*** Test Cases ***
Load Contract Agreement
    [Documentation]    Test to check loading of Contract Agreement
    [Tags]             Permission Request    Contract Agreement

    Appstate         Home
    Sleep             ${WAIT_SHORT}
    LaunchApp         Contract Agreements

    # Navigate to a Contract Agreement
    ClickText    Select a List View: Contract Agreements
    ClickText    All
    TypeText     Search this list...    ${CONTRACT_ID}\n    anchor=Import
    ClickText    ${CONTRACT_ID}    partial_match=False
    Log          Contract Agreement record opened successfully

    # Load the Contract Agreement and check the UI
    VerifyText    Contract Agreement
    VerifyField   Contract Agreement Name    ${CONTRACT_ID}    partial_match=True
    VerifyField   Status    Active    partial_match=True
    VerifyField   Permission Request    ${LINKED_PR}    tag=a    partial_match=True
    VerifyField   Owner    ${OWNER_NAME}    tag=a    partial_match=True
    ClickText     Related
    VerifyText    Conga Sign Transactions
    ScrollText    View All
    VerifyText    Files
    ClickText     Details
    Log           Contract Agreement UI verified successfully