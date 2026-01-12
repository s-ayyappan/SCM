*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Accounts Tab UI Checks
    [tags]                    Accounts
    [Documentation]           Accounts tab UI check
    Appstate                  Home
    LaunchApp                 Accounts
    Sleep                     2s

#capture the UI objects

    VerifyText    Import
    HoverText     New
    VerifyText    New
    TypeText      Search this list...    xyz\n    anchor=PRM Account, Owner Last Name, and Created Date aren't searchable. Use filters or sort on these fields instead.
    ClickText     New
    ClickText     New    anchor=Search this list...
    VerifyText    *Search Keyword
    ClickText     *Search Keyword
    VerifyText    New Account:
    VerifyText    Search
    TypeText      Enter Keyword To Search For An Organisation...    sample
    ClickText     Search    partial_match=False
    VerifyText    Create New Account
    VerifyText    Cancel
    ClickText     Create New Account
    UseModal      On
    VerifyText    New Account: SCM Account
    VerifyText    Account Information
    VerifyPickList    *Account Currency
    VerifyText    Parent Account
    VerifyText    Account Owner
    VerifyText    Phone
    VerifyText    *Account Name
    VerifyText    PRM Account
    VerifyText    Publisher Display Name
    VerifyText    PRM Member Updated
    VerifyPickList    Preferred CAR Supplier
    VerifyText    CM Member Updated
    VerifyText    Website
    VerifyText    Is Sensitive
    VerifyText    OBII Id
    VerifyText    Imprint Publisher Account
    VerifyText    Account Incomplete   
    VerifyText    Requires Welcome Ema
    VerifyPickList    Type of Content Provider
    VerifyPickList    Disciplines
    VerifyText    Description
    VerifyText    Select a date for Date
    VerifyText    Billing Address
    VerifyText    Address Search
    VerifyPickList    Billing Country
    VerifyText    Billing Address
    VerifyText    Billing Street
    VerifyText    Billing City
    VerifyPickList    Billing State/Province
    VerifyText    Billing State
    VerifyText    ECH City
    VerifyText    ECR Id
    VerifyText    ECH Region
    VerifyPickList    ECH Registration State   
    VerifyText    ECH Country
    VerifyText    ECH Send Date
    VerifyText    ECH Postcode
    VerifyText    ECH Send To
    VerifyPickList    ECH Customer Set
    VerifyText    ECH Send Error
    VerifyText    ECH Created Date
    VerifyText    Date
    VerifyText    ECH Created Date
    VerifyText    Time
    VerifyPickList    ECH Sales Division
    VerifyText    ECH Last Modified Date
    VerifyText    Date
    VerifyText    Time
    VerifyText    ECH Classification
    VerifyText    ECH Update Date
    VerifyText    Date
    VerifyText    Time
    VerifyText    ECH Actual Start Date
    VerifyText    ECH End Date
    VerifyPickList    ECH Business Division
    VerifyText    Cancel
    VerifyText    Save & New
    VerifyText    Save
    UseModal      Off
    ClickText     Cancel and close

