*** Settings ***
Library    QForce
Library    String
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Funding Body Validations
    [tags]                    Sources   Funding body 
    [Documentation]           Validation for the funding body ID where it only accept the numeric inputs
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Sources

#Search for the source
    TypeText      Search this list...    New Robot Title\n    anchor=Account Manager, Created Date, and Content Provider aren't searchable. Use filters or sort on these fields instead.
    VerifyText    New Robot Title        
    ClickText     Show Actions
    ClickText     Edit
    
#set the source to Funding Body id
    ClickText    Show more actions
    ClickText    Edit
    UseModal     On
    PickList     Type of Title    Funding Org Opportunity
    #VerifyText   11223344
    #HoverText    Funding Body ID
    TypeText     Funding Body ID    12345567890
    ClickText    Save    partial_match=False
    UseModal     Off

#check for various validations in the funding body id
    ClickText    T-55852
    ClickText    Edit Funding Body ID
    VerifyText   12345567890
    TypeText     Funding Body ID    sampletestid
    ClickText    Save
#error should be thrown for the text input
    ClickText    Funding Body ID    anchor=Review the following fields
    VerifyText   The Funding body Id is not valid , it should contain numbers
#enter alphnumeric input
    TypeText     Funding Body ID    abced9409040
    ClickText    Save
    ClickText    Funding Body ID    anchor=CHEM
    VerifyText   The Funding body Id is not valid , it should contain numbers
#enter special character input
    TypeText     Funding Body ID    &&*(()()LKMNM:K
    ClickText    Save
    ClickText    Funding Body ID    anchor=CPX
    VerifyText   The Funding body Id is not valid , it should contain numbers
#enter valid numeric inputs for successful save
    TypeText     Funding Body ID    123456789101112
    ClickText    Save
    VerifyField  Funding Body ID    123456789101112    partial_match=True
