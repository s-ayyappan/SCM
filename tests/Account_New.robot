# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Library           QForce
Library           QWeb
Library           DataDriver    reader_class=TestDataApi    name=TestDATA.csv
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End suite


*** Test Cases ***
Check New Account Creation
    [tags]                    Accounts
    Appstate                  Home
    Sleep                     1s
    LaunchApp                 Accounts
        
    ClickText    New
    TypeText     Enter Keyword To Search For An Organisation...    Robot account
    ClickText    Search    partial_match=False
    ClickText    Create New Account
    UseModal     On
    TypeText     *Account Name    Robot Account
    TypeText     Publisher Display Name    Robot Account
  
    TypeText    ECH Country   
    TypeText    ECH City    
         
    ComboBox     Search Address    Oxford
    TypeText     Billing Zip/Postal Code    ox4 2wb
    SwipeDown    1
    ClickText    Save    partial_match=False
    UseModal     Off
    ClickItem    search-button
    TypeText     Search...    Robot Account\n    tag=input
    Sleep        4s
    HoverText    Robot Account
    Sleep        4s
    HoverText    Show Actions
    HoverText    Robot Account
    Sleep        4s
    VerifyText   Robot Account


  