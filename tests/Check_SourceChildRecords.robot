*** Settings ***
Library    QForce
Library    String
Library    QWeb
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

    ComboBox    Search Accounts...    Avignon University
    ComboBox    Search Accounts...    Avignon University
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
#    ClickText                     Save    partial_match=False
    Sleep                         2s
    UseModal                      Off
    VerifyText                    Source Child CRT

#Check new PR is created
    ClickText    Related
    VerifyText    Permission Requests
    ClickText     Permission Requests
    ClickCheckbox    Select Item 1    on    partial_match=False
    ClickElement    xpath=//*[@id="window"]/span/slot/span/slot/span    timeout=10s




    VerifyField    Permission Request Name    PR    partial_match=True
    VerifyField    Title Name    Source Child CRT    partial_match=True
    ClickText    Related


    VerifyText     Source Links             partial_match=True
    ClickText    Source Links
#click the source link
    ClickCheckbox                 Select Item 1      on       partial_match=Name
    ClickText                     SL                 
    VerifyText                    Source Link
    Log                        Source Link present
#click the right and permission
    ClickText                     RP
    Log                        Right and Permission present
    ClickText    Rights and Restrictions (6)
    VerifyText    Rights and Restrictions
    ExecuteJavaScript    window.history.back();
    Sleep                2s
    ClickText    Right and Permission History (5)
    ExecuteJavaScript    window.history.back();
    Sleep                2s
#navigate back to the source
    ClickText    T-56220    anchor=Related

#clean up - delete the created source
    ClickFieldValue    Title Id
    ClickText    Show more actions    anchor=Change Permission Holder
    ClickText    Delete
    UseModal    On
    ClickText    Delete
    VerifyText    was deleted.
    Log           Source delete successfully
#delete the source link
    ClickText    Delete
    ClickText    Delete
    Log          Source Link delete successfully
