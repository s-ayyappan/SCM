*** Settings ***
Library           QForce
Library           QWeb
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
${CONTACT_FIRST_NAME}         Robotics
${CONTACT_LAST_NAME}          contact
${CONTACT_FULL_NAME}          Robotics contact
${CONTACT_OBII_ID}            222343
${CONTACT_EMAIL}              test@elsevier.invalid.com
${CONTACT_ACCOUNT_NAME}       Aalborg University
${CASE_NUMBER}                00001694

*** Test Cases ***
Check Delete Contact And Case
    [Documentation]    Deleting a Contact removes that Contact's reference from a related Case
    [Tags]              Contacts    Cases

    Appstate         Home
    Sleep             ${WAIT_SHORT}
    LaunchApp         Contacts

    # Create a new Contact
    ClickText    New
    UseModal     On
    PickList     Salutation      Mr.
    TypeText     First Name      ${CONTACT_FIRST_NAME}
    TypeText     Last Name       ${CONTACT_LAST_NAME}
    TypeText     OBII Id         ${CONTACT_OBII_ID}
    PickList     Contact Role    All-round
    ComboBox     Search Accounts...    ${CONTACT_ACCOUNT_NAME}
    TypeText     Email           ${CONTACT_EMAIL}
    ClickText    Save    partial_match=False
    UseModal     Off
    VerifyField  Name    Mr. ${CONTACT_FULL_NAME}    partial_match=True
    Log          New Contact created successfully

    # Delete the Contact
    LaunchApp    Contacts
    ClickText    Select a List View: Contacts
    ClickText    My Contacts
    TypeText     Search this list...    ${CONTACT_FIRST_NAME}\n    anchor=Owner Last Name and Left Employment? aren't searchable. Use filters or sort on these fields instead.
    ClickText    ${CONTACT_FULL_NAME}
    UseModal     On
    ClickText    Delete
    Sleep        ${WAIT_SHORT}
    ClickText    Delete
    Sleep        ${WAIT_MEDIUM}
    UseModal     Off
    ${deleted}=    Is Text    Nothing to see here    timeout=${WAIT_SHORT}
    Log          Contact deletion redirect detected: ${deleted}

    # Check the Case no longer references the deleted Contact
    LaunchApp    Cases
    ClickItem    search-button
    TypeText     Search...    ${CASE_NUMBER}\n
    ClickText    Case Number
    VerifyText   ${CASE_NUMBER}
    ClickText    ${CASE_NUMBER}    anchor=Case Number
    VerifyField  Contact Name    ${EMPTY}
    Log          Case does not have deleted Contact reference