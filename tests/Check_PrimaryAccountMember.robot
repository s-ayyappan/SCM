*** Settings ***
Library           QForce
Library           QWeb
Library           QVision
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End suite


*** Test Cases ***
Check Primary Account Team Member
    [tags]                    Accounts
    [Documentation]           Check the Primary Account Team Member logic
    Appstate                  Home
    Sleep                     1s
    LaunchApp                 Accounts
    

    TypeText    Search this list...    Robot Account\n    anchor=PRM Account, Owner Last Name, and Created Date aren't searchable. Use filters or sort on these fields instead.
#    ClickText    Search    partial_match=False
    ClickText   Robot Account
    Sleep       2s
    VerifyText  Robot Account
    ClickText    Related
    ClickText    Add Team Members
    Sleep        2s
    UseModal     On
 #   ClickText    Edit User: Item    anchor=User ID
    ClickText	 Edit User: Item	recognition_mode=vision
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
   
    
