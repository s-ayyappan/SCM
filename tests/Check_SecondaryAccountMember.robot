*** Settings ***
Library           QForce
Library           QWeb
Library           QVision
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End suite


*** Test Cases ***
Check Two Primary Account Team Member error
    [tags]                    Accounts
    [Documentation]           This test is to check secondary account member can be added to an account
    Appstate                  Home
    Sleep                     1s
    LaunchApp                 Accounts

#ClickText    Search    partial_match=False
    TypeText     Search this list...    Robot Account\n    anchor=PRM Account, Owner Last Name, and Created Date aren't searchable. Use filters or sort on these fields instead.
    ClickText    Robot Account
    Sleep        2s
    VerifyText   Robot Account
    ClickText    Related
    ClickText    Add Team Members
    Sleep        2s
    UseModal     On
#add a new team member and mark him as primary
    ClickText	 Edit User: Item	anchor=Team Role
    ComboBox     Search People...    Sundar Ayyappan
    ClickText    Edit Team Role: Item    anchor=Team Role
    PickList     Team Role    Publishing Relations Manager - Serial Content
    VerifyText   Primary
    ClickText    Edit Primary: Item    anchor=Delete item 1
    HotKey       Space
    ClickText    Save
    UseModal     Off
    ClickText    Details
#verify the team member
    VerifyField  Account Owner    Sundar Ayyappan    tag=a    partial_match=True
    Log          New account owner added
#add a second team member and mark him as primary for error trigger
    ClickText    Related
    ClickText    Add Team Members
    ClickText	 Edit User: Item	anchor=Team Role
    ComboBox     Search People...    Satheesh Selvaraj
    ClickText    Edit Team Role: Item    anchor=Team Role
    PickList     Team Role    Publishing Relations Manager - Serial Content
    ClickText    Save
#check secondary account member added to the account
    ClickText    Satheesh Selvaraj Team Member Record
    ClickCheckbox    Edit Primary    on
    VerifyText    Primary

   




    
