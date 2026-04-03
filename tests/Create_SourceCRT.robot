*** Settings ***
Library    QForce
Library    String
Library    QWeb
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Create New Source
    [tags]                    Sources    New    
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Sources

#create a new source by clicking New       
    ClickText                     New
    UseModal                      On
    ClickText                     Next
    VerifyText                    New Source: Full
    TypeText                      *Title Name    New CRT Title
    ComboBox                      Search Accounts...    Aalborg University    index=1
    PickList                      Country    United Kingdom
    PickList                      Content Set    Complete Collection
    MultiPickList                 License/SourceLink creation Process    Manual
#   ClickText                     Move selection to Chosen

#    ClickText    Move to Chosen    anchor=Manual
    PickList                      Content Set    Complete Collection
    MultiPickList    Content Type    Full Content Type Collection
#enter valid format ISSN and EISSN
#Generate random text (7 intergers)
    ${rand_issn}=                 Generate Random String  7    [NUMBERS]
    ${number_with_x}=    Catenate    SEPARATOR=    ${rand_issn}    X
  #  TypeText                      ISSN     ${number_with_x}
#    TypeText                      ISSN    1122334X
  #  TypeText                      E-ISSN    87654321
  #  TypeText                      Funding Body ID    11223344
#Save the source
    ClickText                     Save    partial_match=False
    Sleep                         2s
    UseModal                      Off
    VerifyText                    New CRT Title

