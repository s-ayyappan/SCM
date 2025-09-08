*** Settings ***
Library           QForce
Library           QWeb
Library           QVision
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End suite


*** Test Cases ***
Check Email Navigations
    [tags]                    Cases
    [Documentation]           Check the Email Navigation options are available for the user
    Appstate                  Home
    Sleep                     1s
    LaunchApp                 Cases

#open Serial Content cases
    ClickText    Select a List View: Cases
    ClickText    All cases
    TypeText     Search this list...    00001867\n    anchor=Change Owner
    Sleep        1s

#Chcek the email list from releated tab

    HoverText    Acta Botanica Boreali-Occidentalia Sinica/965239705/T-60775
    ClickText    00001867
    ClickText    Related
    ClickText    Emails
    VerifyText    Emails
    ClickText    Show Actions
#    VerifyText    Delete    commented on 08/09 based on SF winter release
    VerifyText    Reply               
    VerifyText    Reply All
    VerifyText    Forward
    ClickText    00001867
    Log          Email Navigation buttons are found as expected
#end of script
