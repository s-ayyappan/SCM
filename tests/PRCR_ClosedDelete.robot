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
${PR_NUMBER}                  PR-00024935
${ACCOUNT_NAME}                Avignon University
${CONTACT_NAME}                Auto CRT

*** Test Cases ***
PR Closed Won Deletion PRCR
    [Documentation]    Users able to delete Closed (Won) status PR's related PRCR
    [Tags]             Permission Request    PRCR

    Appstate         Home
    Sleep             ${WAIT_SHORT}
    LaunchApp         Permission Requests

    ClickText    Select a List View: Permission Requests
    ClickText    Recently Viewed
    TypeText     Search this list...    ${PR_NUMBER}\n    anchor=License, Title Id, Title Name, End Date, Created Date, Is PRM, Owner Last Name, and Stop Reminder Emails aren't searchable. Use filters or sort on these fields instead.
    Sleep        ${WAIT_SHORT}
    ClickText    ${PR_NUMBER}
    VerifyText   ${PR_NUMBER}

    # Check the status of the PR
    SwipeDown
    VerifyText    Status
    VerifyText    Closed (Won)
    ClickText     Related

    # Create a new PRCR
    ClickText    Permission Request Contact Roles    anchor=New
    ClickText    New
    UseModal     On
    ComboBox     Search Accounts...     ${ACCOUNT_NAME}
    ComboBox     Search Contacts...     ${CONTACT_NAME}
    ClickText    Save    partial_match=False
    UseModal     Off
    Sleep        ${WAIT_SHORT}

    # Refresh and confirm the new PRCR was created before attempting to delete it
    RefreshPage
    ClickText    Permission Request Contact Roles    anchor=${PR_NUMBER}
    RefreshPage
    VerifyText    ${CONTACT_NAME}
    Log           New PRCR created successfully

    # Clean up the newly created PRCR
    ClickText    Permission Request Contact Roles    anchor=New
    ${exists}=    Is Text    Select Item 1    timeout=${WAIT_SHORT}
    IF    ${exists}
        ClickCheckbox    Select Item 1    on    partial_match=False
        ClickText    Show Actions    anchor=Show Contact Inactive column actions
        ClickText    Delete
        UseModal     On
        VerifyText   Delete Permission Request Contact Role
        ClickText    Delete
        Sleep        ${WAIT_MEDIUM}
        VerifyText   was deleted.
        UseModal     Off
        Log          User able to delete PRCR of Closed (Won) status PR
    ELSE
        Log    Checkbox not found, skipping this step
    END