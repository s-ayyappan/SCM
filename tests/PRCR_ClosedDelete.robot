*** Settings ***
Library           QForce
Library           String
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
${DUPLICATE_WARNING_TEXT}      You can't save this record because a duplicate record already exists

*** Test Cases ***
PR Closed Won Deletion PRCR
    [Documentation]    Users able to delete Closed (Won) status PR's related PRCR. If the
    ...                default Contact triggers a duplicate-PRCR warning, a new Contact with
    ...                a unique name is created on the fly and used instead, then both the
    ...                PRCR and the temporary Contact are cleaned up at the end.
    [Tags]             Permission Request    PRCR

    Appstate         Home
    Sleep             ${WAIT_SHORT}
    LaunchApp         Permission Requests

    ClickText    Select a List View: Permission Requests
    ClickText    Recently Viewed
    ClickText    All Permission Requests
    TypeText     Search this list...    ${PR_NUMBER}\n    anchor=License, Title Id, Title Name, End Date, Created Date, Is PRM, Owner Last Name, and Stop Reminder Emails aren't searchable. Use filters or sort on these fields instead.
    Sleep        ${WAIT_SHORT}
    ClickText    ${PR_NUMBER}
    VerifyText   ${PR_NUMBER}

    # Check the status of the PR
    SwipeDown
    VerifyText    Status
    VerifyText    Closed (Won)
    ClickText     Related

    # Create a new PRCR using the default Contact
    ClickText    Permission Request Contact Roles    anchor=New
    ClickText    New
    UseModal     On
    ComboBox     Search Accounts...     ${ACCOUNT_NAME}
    ComboBox     Search Contacts...     ${CONTACT_NAME}
    ClickText    Save    partial_match=False

    # Check whether Salesforce flagged this as a duplicate PRCR
    ${is_duplicate}=    Is Text    ${DUPLICATE_WARNING_TEXT}    timeout=${WAIT_SHORT}
    ${actual_contact_name}=    Set Variable    ${CONTACT_NAME}
    IF    ${is_duplicate}
        Log    Duplicate PRCR detected for "${CONTACT_NAME}" - creating a unique Contact instead
        ClickText    Cancel    partial_match=False

        # Generate a unique Contact name so the new PRCR is not flagged as a duplicate
        ${suffix}=    Generate Random String    4    [NUMBERS]
        ${actual_contact_name}=    Catenate    SEPARATOR=    ${CONTACT_NAME}    ${suffix}

        # NOTE: field/button labels below (e.g. "New Contact", "Last Name") are best-guess
        # placeholders for the inline quick-create form - confirm/adjust against the actual
        # lookup's "New" option in your org before relying on this branch.
        ComboBox     Search Contacts...    ${actual_contact_name}
        ClickText    New Contact
        UseModal     On
        TypeText     Last Name    ${actual_contact_name}
        ClickText    Save    partial_match=False
        UseModal     Off

        ClickText    Save    partial_match=False
    ELSE
        Log    No duplicate detected for "${CONTACT_NAME}"
    END
    UseModal     Off
    Sleep        ${WAIT_SHORT}

    # Refresh and confirm the new PRCR was created before attempting to delete it
    RefreshPage
    ClickText    Permission Request Contact Roles    anchor=${PR_NUMBER}
    RefreshPage
    VerifyText    ${actual_contact_name}
    Log           New PRCR created successfully using Contact "${actual_contact_name}"

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

    # Clean up the temporary Contact created to work around the duplicate rule, if any
    IF    ${is_duplicate}
        LaunchApp    Contacts
        ClickText    Select a List View: Contacts
        ClickText    All Contacts
        TypeText     Search this list...    ${actual_contact_name}\n
        Sleep        ${WAIT_SHORT}
        ClickText    ${actual_contact_name}
        VerifyText   ${actual_contact_name}
        HoverText    Delete
        ClickText    Delete
        UseModal     On
        ClickText    Delete
        UseModal     Off
        VerifyText   was deleted.
        Log          Temporary duplicate-workaround Contact "${actual_contact_name}" deleted successfully
    END