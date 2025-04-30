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

#create a new contact for this session
    ${ed}=       Set Variable     error dialog
    ClickText    Contacts
    ClickText    New
    UseModal    On
    PickList    Salutation    --None--
    TypeText    First Name    Automation
    TypeText    Last Name    CRT
    ComboBox    Search Accounts...    Codogno Hospital
    TypeText    Email    crt@elsevier.invalid.com
    ClickText   Save    partial_match=False

    ${ed} = Run Keyword And Return Status Page Should Contain error dialog
    Run Keyword If  ${ed}   ClickText    Cancel    partial_match=False  level=INFO
    Run Keyword Unless  ${ed}   ClickText   Save    partial_match=Fals  level=INFO

#     ${status} =   Run Keyword And Return Status  Page Should Contain  Nothing to see here
#    Run Keyword If  ${status}  Log  "Login successful"  level=INFO
#    Run Keyword Unless  ${status}  Log  "Nothing to see here"  level=ERROR
#    ClickText    Show more actions



#    VerifyText    Email\n\nFax\n\nDepartment\n\nHome Phone\n\nReports To\n\nOther Phone\n\nLeft Employment?\n\nDescription\n\nContact Role\n\n--None--\nDo Not Call\n\nInactive\n\n\nError\nCancel\nSave & New\nSave\n\nClose error dialog\nSimilar Records Exist\nThis record looks like an existing record. Make sure to check any potential duplicate records before saving.\nView Duplicates
#    ClickText    Close error dialog
#    VerifyText          'Similar Records Exist' visible= False
#    GetText             error dialog
#    Log                 ${text}          

#    ${Errormsg}   QForce.Get Text      error dialog
    
#        Run Keyword If ${Errormsg} == 'Similar Records Exist' 
#                ClickText    Cancel    partial_match=False
#            Else             
#                 ClickText   Save    partial_match=False
#                 UseModal    Off   

VerifyText    Similar Records Exist
    ClickText    Cancel    partial_match=False
    

    UseModal    Off


#create a case for automation
    HoverText    New
    ClickText    New
    UseModal     On
    ClickText    Next
    VerifyText   Contact Name
    ComboBox     Search Contacts...    Automation CRT
    PickList     *Case Origin    Email

#save the new case with new contact created
    ClickText    Save    partial_match=False
    ClickText    Related
    ScrollText   Recent Items
    ClickText    Details
    ScrollText   /html[1]/head[1]/link[1]

#new case with newly create contact tagged
    HoverText    Automation CRT
    VerifyField   Contact Name    Automation CRT    tag=a    partial_match=True
    ClickFieldValue    Contact Name
    ClickText    Related
#    VerifyText   Cases\n(1)
    
#delete the contact
    VerifyText   Contact\nAutomation CRT
    ClickText    Delete
    UseModal     On
    ClickText    Delete
    UseModal     Off
    VerifyText   Contact "Automation CRT"


#contact name removed from the case
    VerifyField  Contact Name    ${EMPTY}

#delete the case created for automation purpose
    ClickText    Delete
    UseModal     On
    ClickText    Delete
    UseModal     Off
    VerifyText   was deleted. Undo
    

#clickelement  //*[text()\='${DelOpp}']/../..//div[3]//button[2]//span