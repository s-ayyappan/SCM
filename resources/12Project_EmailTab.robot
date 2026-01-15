*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Check Project Email Tab
    [tags]                    Project, Emails
    [Documentation]           Check the Project email functionality objects are displaying as expected in UI
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Projects
    
#Navigate to project and click the first record
    ClickText    Clinical Drug Development (CDD) Solution/ Clinical Trial Data
    ClickText    Email    anchor=Details
    ClickCheckbox    Select Item 1    on    partial_match=False
    SwipeDown
    ClickText    Next
#Navigate to email tab and check the UI and templates visibility
    ClickText    Select Template    anchor=Email Templates
    VerifyText    Renewal Notice Batch 2
    VerifyText    Request to stop deliveries of printed items
    VerifyText    Chinese content reminder template
    VerifyText    Request to stop deliveries of printed items    anchor=Skip to Navigation
    VerifyText    Renewal Notice Reminder
    VerifyText    General Annual License Renewal Notice
    ClickText    Select From Address    anchor=*From Address
    ClickText    Default No-Reply    anchor=Skip to Navigation
    SwipeDown
    ClickText    Next
    VerifyText    Recipients
    ScrollText    Recent Items
    ClickText    Cancel
    ClickText    Projects
    Log          Email function objects present as expected