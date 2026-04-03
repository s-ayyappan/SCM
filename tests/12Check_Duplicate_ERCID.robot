*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Duplicate Account Creation Error
    [tags]                    Accounts
    [Documentation]           Prevent Duplicate Account creation using ECRID
    Appstate                  Home
    LaunchApp                 Accounts
    Sleep                     2s

#capture the UI objects
    VerifyText    Import
    HoverText     New
    VerifyText    New
#    TypeText      Search this list...    SCM CRT Account\n    anchor=PRM Account, Owner Last Name, and Created Date aren't searchable. Use filters or sort on these fields instead.
    ClickText     New
    ClickText     New    anchor=Search this list...
    VerifyText    *Search Keyword
    ClickText     *Search Keyword
    VerifyText    New Account:
    VerifyText    Search
    TypeText      Enter Keyword To Search For An Organisation...    SCM CRT Account
    ClickText     Search    partial_match=False
    VerifyText    Create New Account
    VerifyText    Cancel
    ClickText     Create New Account
    UseModal    On
    ComboBox    Search Accounts...    AACE International
    TypeText    *Account Name    CRT SCM Account
    TypeText    Website    www.google.com
    PickList    Type of Content Provider    Taxonomy / Vocabulary Office
    TypeText    ECR Id    ECR-100843701
    VerifyText    ECH City
    TypeText    ECH City    oxford
    
#check whether duplicate or similar contact already exists
#    Log To Console     \n=== Starting Error Modal Check ===

    # Wait for page to settle
    Sleep              3s

    UseModal           On
    Log To Console     Modal mode activated

    # Try to find the error
    ${has_error}=      IsText    We hit a snag    timeout=5s

    # Debug logging
    Log To Console     Result from IsText: ${has_error}
    Log To Console     Result type: ${has_error.__class__.__name__}
    Log                Has error value: ${has_error}    level=WARN

    # Try multiple IF syntaxes
    IF    ${has_error}
        Log To Console     IF condition ENTERED (direct boolean)
        ClickText          Close
        Sleep              1s
    ELSE
        Log To Console     IF condition NOT entered - no error found
    END

    UseModal           Off
    Log To Console     === Error Modal Check Complete ===\n



















    Sleep              2s    # Wait for modal to fully render
    UseModal           On

    ${error_displayed}=    IsText    We hit a snag    timeout=5

    IF    ${error_displayed}
        Log To Console     Error value: ${has_error}
        Log To Console     Error type: ${has_error.__class__}
        ClickText          Close
        Sleep              1s
    END

    UseModal           Off

    ${error_exists}=   IsText    We hit a snag    timeout=5s
    IF    ${error_exists}
        VerifyText    We hit a snag.
        Log    Error popup detected!
        #ClickText    Close error dialog
        ClickElement      //button[contains(@class,'slds-modal__close')]
    ELSE
        Log    >>> No duplicates found
        #ClickText    Save    partial_match=False
    END
    ClickText    Cancel    anchor=Save & New

    ClickElement      //button[contains(@class,'slds-modal__close')]




    UseModal           On
    ${has_error}=      IsText    We hit a snag    timeout=5s
    Log To Console     Error value: ${has_error}
    Log To Console     Error type: ${has_error.__class__}
    Log                ${has_error}
    UseModal           Off


    
    VerifyText    We hit a snag.
    VerifyText    View Duplicates
    ClickText     View Duplicates
    Log           SF Duplicate ECRID identification error successfully displayed, abort the flow         
    ClickText    Cancel    anchor=Save & New
    UseModal      Off
    ClickText     Cancel and close
