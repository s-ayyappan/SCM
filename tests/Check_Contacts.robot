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
${CONTACT_NAME}              Aaron Miller

*** Test Cases ***
Check Contacts Tab UI Checks
    [Documentation]    Contacts tab loading check
    [Tags]             Contacts

    Appstate         Home
    LaunchApp         Contacts
    Sleep             ${WAIT_SHORT}

    # Search for and open the contact record
    ClickText     Select a List View: Contacts
    ClickText     All Contacts
    TypeText      Search this list...    ${CONTACT_NAME}\n
    Sleep         ${WAIT_SHORT}
    ClickText     ${CONTACT_NAME}
    VerifyText    Contact
    VerifyText    ${CONTACT_NAME}
    VerifyText    Account Name
    VerifyText    Title
    Log           Contact record opened successfully

    # Verify Contact header and detail fields
    VerifyText    Phone
    VerifyText    Email
    VerifyText    Contact Owner
    VerifyText    Name
    VerifyText    ${CONTACT_NAME}
    VerifyText    Initials
    VerifyText    Account Name
    VerifyText    Title
    VerifyText    Email
    VerifyText    Department
    VerifyText    Reports To
    VerifyText    Contact Role
    VerifyText    Edit Reports
    VerifyText    Left Employment?
    VerifyText    Inactive
    VerifyText    OBII Id
    VerifyText    Contact Owner
    VerifyText    Phone
    VerifyText    Mobile
    VerifyText    Home Phone
    VerifyText    Other Phone
    VerifyText    Description
    VerifyText    Do Not Call
    HoverText     Edit
    HoverText     Delete
    Log           Contact detail fields verified

    # Verify Related tab sections load
    ClickText     Related
    # VerifyText    Opportunities
    VerifyText    Related Accounts
    VerifyText    Notes
    VerifyText    Cases
    VerifyText    Permission Request Contact Roles
    Log           Contact related sections verified