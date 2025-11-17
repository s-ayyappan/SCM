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

#create new account
    VerifyText    Accounts
    ClickText    Select a List View: Accounts
    ClickText    All Accounts
    ClickText    New    anchor=Import
    TypeText     Enter Keyword To Search For An Organisation...    Robot account
    ClickText    Search    partial_match=False
    ClickText    Create New Account
    UseModal     On
    TypeText     *Account Name    Robot Account
    TypeText     Publisher Display Name    Robot Account
#input the Country and City 
    TypeText    ECH Country                United Kingdom
    TypeText    ECH City                   Oxford    
#input the billing address         
    ComboBox     Search Address    Oxford
    TypeText     Billing Zip/Postal Code    ox4 2wb
    SwipeDown    1
    ClickText    Save    partial_match=False
    Sleep        2s
    UseModal     Off
#Check the successfull creation of account 
    VerifyText    Robot Account             anchor=Account
    VerifyField   Account Name    Robot Account    partial_match=True
    VerifyField   Publisher Display Name    Robot Account    partial_match=True
    Log           New Account successfully created  

    Appstate      Home
    Sleep         1s
    LaunchApp     Accounts

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
    VerifyText   Primary
    ClickText    Edit Primary: Item    anchor=Delete item 1
    HotKey       Space
    ClickText    Save
#check whether error msg is displayed
#    ${duplicate_exists}=    Set Variable    Can't save records with errors
#    IF    '${duplicate_exists}' == 'Can't save records with errors'
#        Log    >>> Cannot have more than one primary contact
#        ClickText    Cancel    partial_match=False
#        ClickText    Cancel
#    ELSE
#        Log    >>> No duplicate primary contact found
#        ClickText    Save    partial_match=False
#    END
    VerifyText    Can't save records with errors.
    #\nItem 1 has an error: there is already primary/secondary Account Team Member for this account
    HoverText    Close
    ClickText    Close
    ClickText    Cancel    partial_match=False
    Log          Correct error message is triggered.  
#check secondary account member added to the account
    ClickText    Sundar Ayyappan Team Member Record
    VerifyText    Primary
    LaunchApp                 Accounts
    Sleep                     2s
#search the account selected for deletion
    TypeText                  Search this list...    Robot Account\n    anchor=Created Date, Owner Last Name, and PRM Account aren't searchable. Use filters or sort on these fields instead.
    Sleep                     2s
    VerifyText                Robot Account
    ClickText                 Show Actions
    HoverText                 Show more actions
    HoverText                 Delete
#select the 
    ClickText                 Delete
    Sleep                     5s
    UseModal                  On
    VerifyText                Are you sure you want to delete this account?
    ClickText                 Delete
    UseModal                  Off
    Sleep                     5s


    
