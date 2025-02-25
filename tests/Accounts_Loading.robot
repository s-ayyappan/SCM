#script to check whether the accounts tab is loading
# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Check Accounts Loading Tab    
    [tags]                    Accounts
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Accounts

    TypeText     Search this list...    Aalborg university\n    anchor=Created Date, Owner Last Name, and PRM Account aren't searchable. Use filters or sort on these fields instead.
    ClickText    Aalborg University
    VerifyText   Aalborg University
    VerifyField  Account Name    Aalborg University    partial_match=True
    ClickText    Related
    ClickText    Invoice Report
    ClickText    Details
