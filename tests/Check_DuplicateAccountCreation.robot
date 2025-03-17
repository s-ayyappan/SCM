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
    [Documentation]           Check user not allowed to create duplication account with same ECR ID
    Appstate                  Home
    Sleep                     1s
    LaunchApp                 Accounts
        
    ClickText    New
    TypeText     Enter Keyword To Search For An Organisation...    Robot Duplicate account
    ClickText    Search    partial_match=False
    ClickText    Create New Account
    UseModal     On
    TypeText     *Account Name    Robot Duplicate account
    TypeText     Publisher Display Name    Robot Duplicate account
#enter the existing ECR id
    TypeText     ECR Id    ECR-102004186
    TypeText     ECH Country                United Kingdom
    Sleep        2s
#validation of duplicate ECR id is triggered    
    ClickText	 View Duplicates	recognition_mode=vision
    UseModal     On
    HoverText    ECR-102004186
    ClickText    Cancel and close    anchor=Requires Welcome Email
    ClickText    Cancel    anchor=Save & New
    Log          Duplicate account trigger is working as expected
    


  