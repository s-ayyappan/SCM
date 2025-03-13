
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
    [Documentation]           This test is to delete a account which was created as part of the automated regression.
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Accounts
#search the account selected for deletion
    TypeText                  Search this list...    Robot Account\n    anchor=Created Date, Owner Last Name, and PRM Account aren't searchable. Use filters or sort on these fields instead.
    Sleep                     2s
    VerifyText                Robot Account
    ClickText                 Show Actions
    HoverText                 Show more actions
    HoverText                 Delete
#select the 
    ClickText                 Delete
    Sleep                     5s
    UseModal                  On
    VerifyText                Are you sure you want to delete this account?
    ClickText                 Delete
    UseModal                  Off
    Sleep                     5s

   # TypeText                  Search this list...    Robot Account\n    anchor=Created Date, Owner Last Name, and PRM Account aren't searchable. Use filters or sort on these fields instead.
   # Sleep                     5s
   # VerifyText                No items to display.
   

