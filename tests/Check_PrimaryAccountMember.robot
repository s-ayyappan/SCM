*** Settings ***
Library           QForce
Library           QWeb
Library           DataDriver    reader_class=TestDataApi    name=TestDATA.csv
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End suite


*** Test Cases ***
Check New Account Creation
    [tags]                    Accounts
    [Documentation]           Check the Primary Account Team Member logic
    Appstate                  Home
    Sleep                     1s
    LaunchApp                 Accounts
        
    ClickText    New
    TypeText     Enter Keyword To Search For An Organisation...    Robot account
    ClickText    Search    partial_match=False
    
    ClickText    Related
    ClickText    Add Team Members
    UseModal     On
    ClickText    Edit User: Item    anchor=User ID
    ComboBox     Search People...    Sundar Ayyappan
    ClickText    Edit Team Role: Item    anchor=--None--
    PickList     Team Role    Publishing Relations Manager - Serial Content
    ClickText    Edit Primary: Item    anchor=Delete item 1
    ClickCheckbox    Publishing Relations Manager - Serial ContentEdit Team Role: Item 1 Edited    on    partial_match=False
    ClickText    Save
    UseModal     Off
    ClickText    Details
    ClickText    Related
    ClickText    Sundar Ayyappan Team Member Record
