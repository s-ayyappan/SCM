*** Settings ***
Library    QForce
Library    String
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Create New Source Child Records
    [tags]                    Sources    New    
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Sources

#create a new source by clicking New       
    ClickText                     New
    UseModal                      On
    ClickText                     Next
    VerifyText                    New Source: Full
    TypeText                      *Title Name    Source Child CRT
    ComboBox                      Search Accounts...    Aalborg University    index=1
    PickList                      Country    United Kingdom
    MultiPickList                 License/SourceLink creation Process    Manual
#   ClickText                     Move selection to Chosen
    ClickText                     Move to Chosen    anchor=Manual
    PickList                      Content Set    Complete Collection
    MultiPickList                 Content Type    Funding & Grants
    ClickText                     Move to Chosen    anchor=Funding & Grants
#    TypeText                      Funding Body ID    7987979
    ClickText                     Save    partial_match=False
#enter valid format ISSN and EISSN
    TypeText                      ISSN    1122334X
    TypeText                      E-ISSN    87654321
    TypeText                      Funding Body ID    11223344

#select a new license


    ClickCheckbox    Select Item 2    on    partial_match=False
    VerifyText    Elsevier License Template
    ClickText    Confirm
#Save the source
    ClickText                     Save    partial_match=False
    Sleep                         2s
    UseModal                      Off
    VerifyText                    New Robot Title