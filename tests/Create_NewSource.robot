*** Settings ***
Library    QForce
Library    String
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Check Sources
    [tags]                    Sources
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Sources

#create a new source by clicking New
              
    ClickText                     New
    UseModal                      On
    ClickText                     Next
    VerifyText                    New Source: Full
    TypeText                      *Title Name    New Robot Title
    ComboBox                      Search Accounts...    Aalborg University    index=1
    PickList                      Country    United Kingdom
    MultiPickList                 License/SourceLink creation Process    Manual
    ClickText                     Move selection to Chosen
    PickList                      Content Set    Complete Collection
#enter valid format ISSN and EISSN
    TypeText                      ISSN    1122334X
    TypeText                      E-ISSN    87654321
    TypeText                      Funding Body ID    11223344
#Save the source
    ClickText                     Save    partial_match=False
    UseModal                      Off
    ClickText                     Save    partial_match=False
    VerifyText                    New Robot Title

