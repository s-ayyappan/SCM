*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Check Project Tab Loading
    [tags]                    Project
    [Documentation]           Check the Project Tab is loading with all necessary objects
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Projects

#check the UI components for project app
    ClickText    CRT Project
#navigate to Project tab and check the default objects
    
    VerifyText     Project
    ClickText      Details
    VerifyField    Project Name    CRT Project    partial_match=True
    VerifyField    Description    Do not delete as this is used for CRT automated regression    partial_match=True
    VerifyField    Renewal Project    Renewal Project    partial_match=True
    ClickText      Email    anchor=Details
    ClickText      Related
    VerifyText     Permission Requests                   parial_match = True
    ClickText      Communication Email
    HoverText      New Contact
    HoverText      Edit
    HoverText      New Opportunity
    ClickText      Edit    partial_match=False
    UseModal       On
    TypeText       *Project Name    CRT Project edit
    VerifyText    Description
    HoverText    Renewal Project    on
    ClickText    Cancel and close
    #ClickText    Cancel    anchor=Save & New
    Log            All objects displayed as expected