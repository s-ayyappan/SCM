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
#input the Country and City 
    TypeText    ECH Country                United Kingdom
    TypeText    ECH City                   Oxford    
#input the billing address         
    ComboBox     Search Address    Oxford
    TypeText     Billing Zip/Postal Code    ox4 2wb
    SwipeDown    1
    ClickText    Save    partial_match=False
    UseModal     Off
#ClickItem    search-button
    LaunchApp   Accounts
    TypeText    Search this list...    Robot Account\n    anchor=PRM Account, Owner Last Name, and Created Date aren't searchable. Use filters or sort on these fields instead.
    ClickText   Robot Account
    VerifyText  Robot Account
    Log         New Account successfully created  

    


  