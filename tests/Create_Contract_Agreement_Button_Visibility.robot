*** Settings ***
Documentation     Create Contract Agreement button visibility
Library           QForce
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End Suite

*** Variables ***
# Wait Times
${WAIT_SHORT}                2s
${WAIT_MEDIUM}               3s
${WAIT_LONG}                 5s 

# Selectors
${NEW_BUTTON}                New
${CANCEL_BUTTON}             Cancel
${SEARCH_BUTTON}             Search

*** Test Cases ***
Create Contract Agreement button visibility
    [Documentation]     Create Contract Agreement button visibility based on License template
    [Tags]             New    License  Permission Request    Critical

    Launch Account Application

#Search for specific permission request with status contacted


    ClickText    Select a List View: Permission Requests
    ClickText    All Permission Requests
    

    ClickText    Select a List View: Permission Requests
    ClickText    My Open Permission Requests
    TypeText    Search this list...    New OA Lice\n    anchor=Permission Holder, Title Id, Title Name, Reviewed, and Created Date aren't searchable. Use filters or sort on these fields instead.
    VerifyText    New OA Lice
    TypeText    Search this list...    26225\n    anchor=Clear
    ClickText    Recently Viewed (Pinned list)
    TypeText    Search this list...    26225\n    anchor=Title Id, Title Name, Subscription End Date, Created Date, Is PRM, Owner Last Name, and Stop Reminder Emails aren't searchable. Use filters or sort on these fields instead.
    ClickText    PR-00026225
    VerifyText    PR-00026225
    VerifyField    Status    Contacted    partial_match=True
    VerifyField    Type Code    OpenAccess Agreement    partial_match=True
    HoverText    Create Contract Agreement
    ClickText    Create Contract Agreement
    UseModal    On
    ClickText    Cancel    partial_match=False
    TypeText    Search this list...    PR-00026225\n    anchor=License, Title Id, Title Name, End Date, Created Date, Is PRM, Owner Last Name, Stop Reminder Emails, and Created By aren't searchable. Use filters or sort on these fields instead.












*** Keywords ***
Launch Account Application
    [Documentation]    Navigate to Accounts application
    Appstate          Home
    Sleep             ${WAIT_SHORT}
    LaunchApp         Permission Requests
    Sleep             ${WAIT_MEDIUM}
    Log               Permission Request application launched