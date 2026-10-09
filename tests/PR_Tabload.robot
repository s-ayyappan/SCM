*** Settings ***
Library           QForce
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End Suite

*** Variables ***
# Wait Times
${WAIT_SHORT}                2s
${WAIT_MEDIUM}                3s
${WAIT_LONG}                 5s

# Test Data
${PR_NUMBER}                  PR-00003481
${TITLE_ID}                   T-21025

*** Test Cases ***
Check Permission Requests
    [Documentation]    Test to check Permission Request Tab is loading as normal
    [Tags]             Permission Request

    Appstate         Home
    Sleep             ${WAIT_SHORT}
    LaunchApp         Permission Requests

    # Navigate to and open the Permission Request record
    ClickText    Select a List View: Permission Requests
    ClickText    Recently Viewed (Pinned list)
    TypeText     Search this list...    ${PR_NUMBER}\n
    Sleep        ${WAIT_MEDIUM}
    ClickText    ${PR_NUMBER}
    VerifyText   ${PR_NUMBER}
    ClickText    Related
    ClickText    Details
    Log          Able to successfully open the Permission Request record

    # Verify core Permission Request fields are present
    VerifyText    Permission Request
    VerifyText    License
    VerifyText    Version
    VerifyText    Permission Holder
    VerifyText    Status
    VerifyField   Permission Request Name    ${PR_NUMBER}    partial_match=True
    VerifyField   Title Id    ${TITLE_ID}    tag=a    partial_match=True
    Log           Permission Request fields verified

    # Verify the related Contract Agreements section loads correctly
    ClickText    Related
    VerifyText    Contract Agreements
    ClickText    Email    anchor=Contract Agreements
    ClickText    Details
    Log          Related Contract Agreements section verified