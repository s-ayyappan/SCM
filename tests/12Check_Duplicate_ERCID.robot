*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Duplicate Account Creation Error
    [tags]                    Accounts
    [Documentation]           Prevent Duplicate Account creation using ECRID
    Appstate                  Home
    LaunchApp                 Accounts
    Sleep                     2s

#capture the UI objects

    VerifyText    Import
    HoverText     New
    VerifyText    New
#    TypeText      Search this list...    SCM CRT Account\n    anchor=PRM Account, Owner Last Name, and Created Date aren't searchable. Use filters or sort on these fields instead.
    ClickText     New
    ClickText     New    anchor=Search this list...
    VerifyText    *Search Keyword
    ClickText     *Search Keyword
    VerifyText    New Account:
    VerifyText    Search
    TypeText      Enter Keyword To Search For An Organisation...    SCM CRT Account
    ClickText     Search    partial_match=False
    VerifyText    Create New Account
    VerifyText    Cancel
    ClickText     Create New Account
    UseModal    On
    ComboBox    Search Accounts...    AACE International
    TypeText    *Account Name    CRT SCM Account
    TypeText    Website    www.google.com
    PickList    Type of Content Provider    Taxonomy / Vocabulary Office
    TypeText    ECR Id    ECR-100843701
    VerifyText    ECH City
    TypeText    ECH City    oxford
    VerifyText    We hit a snag.
    VerifyText    View Duplicates
    ClickText     View Duplicates
    Log           SF Duplicate ECRID identification error successfully displayed, abort the flow         
    ClickText    Cancel    anchor=Save & New
    UseModal      Off
    ClickText     Cancel and close
