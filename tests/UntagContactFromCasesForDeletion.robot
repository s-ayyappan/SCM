*** Settings ***
Library           QForce
Library           QWeb
Library           QVision
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End suite


*** Test Cases ***
Un-tag contacts from related cases before deletion
#scms-911 ticket functionality
    [tags]                    Cases
    [Documentation]           Un-tag Contacts from related cases before deletion     
    Appstate                  Home
    Sleep                     1s
    LaunchApp                 Cases

#create a case for automation
    ClickText    New
    UseModal     On
    HoverText    Next
    ClickText    Next
    ClickText    Search Contacts...
    ClickText    New Contact
    PickList     Salutation    Mr.
    TypeText     First Name    CRT
    TypeText     Middle Name    Automation
    TypeText     Last Name    Automation
    ComboBox     Search Accounts...    Codogno Hospital
    TypeText     Email    crt@elsevier.invalid.com
    ClickText    Save    anchor=Save & New
    UseModal     Off
    ClickText    Save    partial_match=False
    PickList     *Case Origin    Email

#save the new case with new contact created
    ClickText    Save    partial_match=False
    ClickText    Related
    ScrollText   Recent Items
    ClickText    Details
    ScrollText   /html[1]/head[1]/link[1]

#new case with newly create contact tagged
    HoverText    CRT Automation Automation
    VerifyField   Contact Name    CRT Automation Automation    tag=a    partial_match=True
    ClickFieldValue    Contact Name
    ClickText    Related
    VerifyText   Cases\n(1)
    
#delete the contact
    VerifyText   Contact\nMr. CRT Automation Automation
    ClickText    Delete
    UseModal     On
    ClickText    Delete
    UseModal     Off

#contact name removed from the case
    VerifyField  Contact Name    ${EMPTY}

#delete the case created for automation purpose
    ClickText    Delete
    UseModal     On
    ClickText    Delete
    UseModal     Off
    VerifyText   was deleted. Undo
    

