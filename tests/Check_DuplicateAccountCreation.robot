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
#input the Country and City 
    TypeText     ECH Country                United Kingdom
    TypeText     ECH City                   Oxford    
#input the billing address         
    ComboBox     Search Address    Oxford
    TypeText     Billing Zip/Postal Code    ox4 2wb
    SwipeDown    1
    ClickText    Save    partial_match=False
#validation of duplicate ECR id is triggered    
    VerifyText    You can't save this record because a duplicate record already exists. To save, use different information.
    ClickText    View Duplicates
    UseModal     On
    VerifyPageHeader    ECR-102004186
    ClickText    ECR-102004186
    ClickText    Cancel and close    anchor=ECH Registration State
    UseModal     Off
    ClickText    Cancel    anchor=Save & New
    UseModal     Off
    log          Duplicate account trigger is working as expected
    


  