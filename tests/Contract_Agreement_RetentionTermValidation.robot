# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Library    QForce
Library    QWeb
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Check Contract Agreement Retnetion Term validation
    [tags]                    Contract Agreement, Rights and Restrictions
    [Documentation]           Contract agreements retention term updates the Rights and Restrictions term             
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Contract Agreements

#search contract agreement
    ClickText    Select a List View: Contract Agreements
    ClickText    All
    TypeText    Search this list...    CON-000023\n    anchor=Created By, Created Date, and Type of Title aren't searchable. Use filters or sort on these fields instead.
    ClickText    CON-000023
#edit the retention term
    ClickText    Edit Retention Term (Years)
    TypeText    Retention Term (Years)    2
    ClickText    Save
    VerifyText    24

#click the PR related to the contract agreement
    ClickText    PR-00010177
    ClickText    Related
    SwipeDown
    VerifyText    Rights and Restrictions
    ClickText    Rights and Restrictions
    
#click the Rights and restrictions
    ClickText    RR-047411
#verify the rention month equal to the months entered in the contract agreement
    SwipeDown
    VerifyText    24           anchor= Retention Term
    SwipeUp
    back

#clean up the retention month back to original value
    ClickText    PR-00010177
    ClickText    Related
    VerifyText   Contract Agreements
    ClickText    CON-000023    partial_match=False
    ClickText    Edit Retention Term (Years)
    TypeText    Retention Term (Years)    1
    ClickText    Save
