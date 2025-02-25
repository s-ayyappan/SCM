
# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Delete New Account 
    [tags]                    Delete Accounts
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Accounts

    TypeText                  Search this list...    Robot Account\n    anchor=Created Date, Owner Last Name, and PRM Account aren't searchable. Use filters or sort on these fields instead.
    Sleep                     2s
    VerifyText                Robot Account
    ClickText                 Show Actions
    HoverText                 Show more actions
    HoverText                 Delete
    ClickText                 Delete
    UseModal                  On
    VerifyText                Are you sure you want to delete this account?
    ClickText                 Delete
    UseModal                  Off
    TypeText                  Search this list...    Robot Account\n    anchor=Created Date, Owner Last Name, and PRM Account aren't searchable. Use filters or sort on these fields instead.
    VerifyText                No items to display.
   

