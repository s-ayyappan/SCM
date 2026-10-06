*** Settings ***
Library           QForce
Library           QVision
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End Suite

*** Variables ***
# Wait Times
${WAIT_SHORT}                2s
${WAIT_MEDIUM}               3s
${WAIT_LONG}                 5s

# Test Data
${PR_NUMBER}                  PR-00025645
${LICENSE_ID}                 L-011296
${RP_ID}                      RP-011085

*** Test Cases ***
Create New Obligation in PR
    [Documentation]    Test to check PRCR under Permission Request is loading as normal
    [Tags]             Permission Request

    Appstate         Home
    Sleep             ${WAIT_SHORT}
    LaunchApp         Permission Requests

    ClickText    Select a List View: Permission Requests
    ClickText    Recently Viewed
    TypeText     Search this list...    ${PR_NUMBER}\n    anchor=Clear
    Sleep        ${WAIT_SHORT}
    ClickText    ${PR_NUMBER}
    VerifyText   ${PR_NUMBER}
    ClickText    Related
    Sleep        ${WAIT_SHORT}

    # Create a new Obligation for the License
    ClickText    ${LICENSE_ID}
    ClickText    Rights and Permissions
    ClickText    ${RP_ID}
    ClickText    Obligations    partial_match=False

    VerifyText    New
    ClickText     New
    UseModal      On
    PickList      Type      Attribution
    PickList      Status    Pending
    ClickText     Save    partial_match=False
    UseModal      Off
    Sleep         ${WAIT_SHORT}
    Log           New Obligation created successfully

    # Breadcrumb back up to the License via the RP's Related tab, then drill back down to Obligations
    ClickText    ${RP_ID}
    ClickText    Related
    ClickText    ${LICENSE_ID}
    ClickText    Rights and Permissions
    ClickText    ${RP_ID}
    ClickText    Obligations    partial_match=False

    # Select the last created Obligation using hotkeys and delete it
    VerifyText    New
    ${exists}=    Is Text    Select Item 1    timeout=${WAIT_SHORT}
    IF    ${exists}
        ClickCheckbox    Select Item 1    on    partial_match=False
        HotKey       Tab
        ClickText    O    anchor=Select Item 1
        ClickText    Delete
        UseModal     On
        ClickText    Delete
        UseModal     Off
        VerifyText   was deleted. Undo
        Log          Newly created Obligation deleted successfully
    ELSE
        Log    Checkbox not found, skipping delete step
    END