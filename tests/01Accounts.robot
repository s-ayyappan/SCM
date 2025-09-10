*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Accounts Tab  UI
    [tags]                    Accounts
    [Documentation]           Accounts tab UI check
    Appstate                  Home
    LaunchApp                 Accounts
    Sleep                     2s

#capture the UI objects

#    HoverText    New
    VerifyText   New

#    HoverText    Import
    ClickText    New
    VerifyText    *Search Keyword
    ClickText    *Search Keyword
    VerifyText    New Account:
    HoverText    Search
    TypeText    Enter Keyword To Search For An Organisation...    sample
    ClickText    Search    partial_match=False
    HoverText    Create New Account
    HoverText    Cancel
    ClickText    Create New Account
    UseModal    On
    VerifyText    New Account: SCM Account
    VerifyText    Account Information
    VerifyPickList    *Account Currency    *
    VerifyText    Parent Account
    VerifyText    Account Owner
    VerifyText    Phone
    VerifyText    *Account Name
    VerifyText    PRM Account
    VerifyText    Publisher Display Name
    VerifyText    PRM Mem
    ClickCheckbox    PRM Member Updated    on
    VerifyPickList    Preferred CAR Supplier    Preferred CAR Supplier
    VerifyText    CM Member Updated
    ClickCheckbox    SCM Member Updated    on
    VerifyText    Website
    VerifyText    Is Sensitive
    VerifyText    OBII Id
    ClickText    OBII Id
    VerifyText    Imprint Publisher Account
    HoverText    Account Incomplete    on
    VerifyText    Account Incomplete
    ClickCheckbox    Account Incomplete    on
    VerifyText    Requires Welcome Ema
    VerifyPickList    Type of Content Provider    Type of Content Provider
    VerifyPickList    Disciplines    Disciplines
    VerifyText    Description
    HoverText    Select a date for Date
    VerifyText    illing Address
    VerifyText    Address Search
    VerifyPickList    Billing Country    Billing Country
    VerifyText    Billing Address\nAddress Search\n\nBilling Country
    VerifyText    Billing Street
    HoverText    Billing City
    VerifyText    Billing City
    VerifyPickList    Billing State/Province    Billing State/Province
    VerifyText    Billing State/Province\n\nBilling Zip/Postal Code
    VerifyText    ECH City
    VerifyText    ECR Id
    VerifyText    ECH Region
    VerifyPickList    ECH Registration State    ECH Registration State
    VerifyText    ECH Country
    ClickText    ECH Country
    VerifyText    ECH Send Date
    VerifyText    Date
    ClickText    Select a date for Date    anchor=Today
    VerifyText    Time
    VerifyText    ECH Postcode
    VerifyText    ECH Send To
    ClickCheckbox    ECH Send To    on
    VerifyPickList    ECH Customer Set    ECH Customer Set
    VerifyText    ECH Send Error
    ClickCheckbox    ECH Send Error    on
    VerifyText    ECH Created Date
    VerifyText    Dat
    ClickText    Date    anchor=ECH Created Date
    VerifyText    ECH Created Date\nDate\n\nSelect a date for Date\nFormat: 31/12/2024\nTime
    VerifyText    Tim
    ClickText    Time    anchor=ECH Sales Division
    VerifyPickList    ECH Sales Division    ECH Sales Division
    VerifyText    ECH Last Modified Date
    VerifyText    Date
    ClickText    Select a date for Date    anchor=ECH Last Modified Date
    VerifyText    Time
    ClickText    Time    anchor=ECH Classification
    VerifyText    ECH Classification
    VerifyText    ECH Update Date
    VerifyText    Date
    ClickText    Date    anchor=ECH Update Date
    VerifyText    Time
    ClickText    Time    anchor=ECH Actual Start Date
    VerifyText    ECH Actual Start Date
    VerifyText    ECH End Date
    VerifyPickList    ECH Business Division    ECH Business Division
    HoverText    Cancel
    HoverText    Save & New
    HoverText    Save
    ClickText    Cancel and close
    UseModal    Off
