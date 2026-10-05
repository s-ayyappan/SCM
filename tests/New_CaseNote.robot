*** Settings ***
Documentation     Case Notes creation and deletion tests
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
${CASE_NAME}                 Robotics Testing Case
${NOTE_TITLE}                Robotics note
${NOTE_BODY}                 This note is added by CRT script
${DELETE_TEXT}               Content Note "Robotics note" was deleted. 

*** Test Cases ***
New Note In Cases
    [Documentation]    Check that a new Note can be added to, and deleted from, a Case
    [Tags]             Cases    Notes    Regression

    Appstate         Home
    Sleep            ${WAIT_SHORT}
    LaunchApp        Cases

    # Open the existing case and verify its details
    ClickText    Select a List View: Cases
    ClickText    All cases
    TypeText     Search this list...    ${CASE_NAME}\n    anchor=Change Owner
    Sleep        ${WAIT_SHORT}
    ClickText    ${CASE_NAME}
    VerifyText   ${CASE_NAME}
    VerifyText   User Responded
    VerifyText	 Case Owner             partial_match=True
    VerifyText    Open
    VerifyField    Status    Open    partial_match=True
    VerifyText	 Case Origin		partial_match=True
    VerifyField    Case Origin    Email    partial_match=True
    VerifyText	 Priority	partial_match=True
    VerifyField    Priority    Medium    partial_match=True
    ClickText    Details
    ClickText    Related
    Log          Able to successfully open an existing case

    # Add a new note to the case
    ClickText    New Note
    TypeText     Untitled Note    ${NOTE_TITLE}
    TypeText     Compose text     ${NOTE_BODY}
    ClickText    Done
    ClickText    Related
    ClickText    Notes    anchor=New
    ClickText    ${NOTE_TITLE}
    UseModal     On
    VerifyText   ${NOTE_BODY}
    UseModal     Off
    ClickText    Close    partial_match=False
    Log          Able to successfully create a note on a case

    # Delete the newly created note and confirm removal
    ClickText    Show Actions
    ClickText    Delete    anchor=Last Modified By
    UseModal     On
    ClickText    Delete
    UseModal     Off
    Sleep        ${WAIT_SHORT}
    #VerifyNoText    ${DELETE_TEXT}    timeout=${WAIT_LONG}
    VerifyText    Content Note "Robotics note" was deleted.
    Log          Able to successfully delete a note from a case