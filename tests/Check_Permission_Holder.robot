# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Check Permission Holder
    [tags]                    Permission Holder
    Appstate                  Home
    LaunchApp                 Sources
  
    ClickText    Select a List View
    ClickText    All Titles
    RefreshPage
    Sleep        2s
    TypeText    Search this list...    T-54421\n
    ClickText    T-54421
    VerifyText   Title Id
    VerifyText    Permission Holder
    VerifyText    American Association of Colleges of Pharmacy
    IsText       text='American Association of Colleges of Pharmacy'
