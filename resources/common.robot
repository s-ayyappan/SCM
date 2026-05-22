*** Settings ***
Documentation     Common keywords and setup for Salesforce test automation
...               This resource file contains login, navigation, and data cleanup utilities
Library           QForce
Library           QWeb
Library           String
Suite Setup       Setup Browser
Suite Teardown    End Suite

*** Variables ***
# Browser Configuration
${BROWSER}                chrome
${DEFAULT_TIMEOUT}        60s
${SEARCH_DELAY}           2s
${CLICK_DELAY}            1s

# Salesforce Configuration
${username}               pace.delivery1@qentinel.com.demonew
${login_url}              https://qentinel--demonew.my.salesforce.com/
${home_url}               ${login_url}/lightning/page/home

# MFA Configuration
${MFA_needed}             ${False}

*** Keywords ***
#----------------------------------
# Browser Setup and Teardown
#----------------------------------
Setup Browser
    [Documentation]    Initialize browser with QForce and QWeb configuration
    Set Library Search Order    QForce    QWeb
    Open Browser                about:blank    ${BROWSER}
    SetConfig                   LineBreak      ${EMPTY}
    SetConfig                   DefaultTimeout    ${DEFAULT_TIMEOUT}
    Log                         Browser setup completed with timeout: ${DEFAULT_TIMEOUT}

End Suite
    [Documentation]    Close all browser instances at suite completion
    Close All Browsers
    Log                         All browsers closed successfully

#----------------------------------
# Authentication Keywords
#----------------------------------
Login
    [Documentation]    Login to Salesforce instance with optional MFA support
    ...                Requires ${username1} and ${password1} variables to be set
    ...                If ${secret} is provided, MFA verification will be performed
    
    GoTo              ${login_url}
    TypeText          Username        ${username1}    delay=${CLICK_DELAY}
    TypeText          Password        ${password1}
    ClickText         Log In
    
    # Check if MFA is required
    ${mfa_required}=    Run Keyword And Return Status    Should Not Be Equal    ${None}    ${secret}
    Run Keyword If      ${mfa_required}    Fill MFA
    
    Log                 Login completed for user: ${username1}

Login As
    [Documentation]    Switch to a different persona in Salesforce
    ...                Requires admin rights to be logged in first
    ...                
    ...                Example:
    ...                | Login As | Chatter Expert |
    ...                | Login As | Sales Manager  |
    
    [Arguments]       ${persona}
    
    # Navigate to Setup
    ClickText         Setup
    ClickText         Setup for current app
    SwitchWindow      NEW
    
    # Search for persona
    TypeText          Search Setup    ${persona}    delay=${SEARCH_DELAY}
    ClickText         User            anchor=${persona}    delay=5s
    
    # Wait for user page to load and login as that user
    VerifyText        Freeze          timeout=45s
    ClickText         Login           anchor=Freeze    delay=${CLICK_DELAY}
    
    Log               Logged in as persona: ${persona}

Fill MFA
    [Documentation]    Fill Multi-Factor Authentication code
    ...                Requires ${username}, ${secret}, and ${login_url} to be set
    
    ${mfa_code}=      GetOTP          ${username}    ${secret}    ${login_url}
    TypeSecret        Verification Code    ${mfa_code}
    ClickText         Verify
    
    Log               MFA verification completed

#----------------------------------
# Navigation Keywords
#----------------------------------
Home
    [Documentation]    Navigate to Salesforce homepage
    ...                Automatically handles login if session expired
    
    GoTo              ${home_url}
    
    # Check if login is required
    ${needs_login}=   IsText          To access this page, you have to log in to Salesforce.    timeout=2s
    Run Keyword If    ${needs_login}    Login
    
    # Navigate to Home
    ClickText         Home
    VerifyTitle       Home | Salesforce
    
    Log               Successfully navigated to Home

Navigate To App
    [Documentation]    Navigate to a specific Salesforce app
    [Arguments]       ${app_name}
    
    ClickText         App Launcher
    TypeText          Search apps and items...    ${app_name}
    ClickText         ${app_name}
    VerifyText        ${app_name}
    
    Log               Navigated to app: ${app_name}

#----------------------------------
# Verification Keywords
#----------------------------------
Verify Stage
    [Documentation]    Verifies opportunity stage selection state
    ...                
    ...                Arguments:
    ...                - text: Stage name to verify
    ...                - selected: Expected state (true/false), default is true
    ...                
    ...                Example:
    ...                | Verify Stage | Qualification | true  |
    ...                | Verify Stage | Closed Won    | false |
    
    [Arguments]       ${text}    ${selected}=true
    
    VerifyElement     //a[@title\="${text}" and @aria-checked\="${selected}"]
    Log               Stage "${text}" verified with selected=${selected}

Verify No Data
    [Documentation]    Verify that specified data text is not present on page
    [Arguments]       ${data}    ${timeout}=3s
    
    VerifyNoText      ${data}    timeout=${timeout}    delay=${SEARCH_DELAY}
    Log               Verified no data found: ${data}

#----------------------------------
# Data Cleanup Keywords
#----------------------------------
Delete Accounts
    [Documentation]    Delete account record and verify deletion
    ...                Expects account to be visible in current list view
    
    [Arguments]       ${account_name}
    
    ClickText         ${account_name}
    ClickText         Delete
    VerifyText        Are you sure you want to delete this account?
    ClickText         Delete    2
    
    # Wait for undo notification and verify it disappears
    VerifyText        Undo
    VerifyNoText      Undo      timeout=10s
    
    # Return to Accounts list
    ClickText         Accounts    partial_match=False
    
    Log               Account deleted successfully: ${account_name}

Delete Leads
    [Documentation]    Delete lead record and verify deletion
    ...                Expects lead to be visible in current list view
    
    [Arguments]       ${lead_name}
    
    ClickText         ${lead_name}
    ClickText         Delete
    VerifyText        Are you sure you want to delete this lead?
    ClickText         Delete    2
    
    # Wait for undo notification and verify it disappears
    VerifyText        Undo
    VerifyNoText      Undo      timeout=10s
    
    # Return to Leads list
    ClickText         Leads    partial_match=False
    
    Log               Lead deleted successfully: ${lead_name}

Delete Permission Request
    [Documentation]    Delete Permission Request record
    ...                Expects to be on the Permission Request detail page
    
    [Arguments]       ${pr_identifier}=L-010380
    
    HoverText         Fields
    ClickText         Delete
    UseModal          On
    ClickText         Delete
    UseModal          Off
    
    # Navigate back to list or specified record
    ClickText         ${pr_identifier}
    
    Log               Permission Request deleted successfully

Delete Record Generic
    [Documentation]    Generic delete keyword for any Salesforce record
    ...                Works for most standard and custom objects
    ...                
    ...                Arguments:
    ...                - record_name: Name/identifier of record to delete
    ...                - object_name: Object type (e.g., Accounts, Contacts, Sources)
    ...                - confirmation_text: Expected confirmation dialog text (optional)
    
    [Arguments]       ${record_name}    ${object_name}    ${confirmation_text}=Are you sure you want to delete
    
    ClickText         ${record_name}
    ClickText         Delete
    VerifyText        ${confirmation_text}
    ClickText         Delete    2
    
    # Wait for deletion to complete
    VerifyText        Undo
    VerifyNoText      Undo      timeout=10s
    
    # Return to object list view
    ClickText         ${object_name}    partial_match=False
    
    Log               ${object_name} record deleted: ${record_name}

Bulk Delete Records
    [Documentation]    Delete multiple records of the same type
    ...                
    ...                Example:
    ...                | @{records}= | Create List | Account 1 | Account 2 | Account 3 |
    ...                | Bulk Delete Records | ${records} | Accounts |
    
    [Arguments]       ${record_list}    ${object_name}
    
    FOR    ${record}    IN    @{record_list}
        ${exists}=    Run Keyword And Return Status    IsText    ${record}    timeout=2s
        Run Keyword If    ${exists}    Delete Record Generic    ${record}    ${object_name}
    END
    
    Log               Bulk deletion completed for ${object_name}

#----------------------------------
# Modal and Dialog Keywords
#----------------------------------
Handle Confirmation Dialog
    [Documentation]    Handle standard Salesforce confirmation dialogs
    ...                
    ...                Arguments:
    ...                - action: Button to click (e.g., Delete, Save, Cancel)
    ...                - verify_text: Text to verify in dialog (optional)
    
    [Arguments]       ${action}    ${verify_text}=${EMPTY}
    
    UseModal          On
    Run Keyword If    '${verify_text}' != '${EMPTY}'    VerifyText    ${verify_text}
    ClickText         ${action}
    UseModal          Off
    
    Log               Confirmation dialog handled with action: ${action}

#----------------------------------
# Wait and Retry Keywords
#----------------------------------
Wait For Salesforce
    [Documentation]    Wait for Salesforce page to fully load
    ...                Useful after navigation or record creation
    
    [Arguments]       ${timeout}=${DEFAULT_TIMEOUT}
    
    Sleep             2s
    # Wait for loading spinners to disappear
    ${spinner_present}=    Run Keyword And Return Status    IsText    Loading    timeout=1s
    Run Keyword If    ${spinner_present}    VerifyNoText    Loading    timeout=${timeout}
    
    Log               Salesforce page loaded

Click With Retry
    [Documentation]    Click element with retry logic for flaky elements
    ...                Useful for elements that may not be immediately clickable
    
    [Arguments]       ${text}    ${retries}=3    ${anchor}=${EMPTY}
    
    FOR    ${i}    IN RANGE    ${retries}
        ${success}=    Run Keyword And Return Status    
        ...            Run Keyword If    '${anchor}' != '${EMPTY}'    
        ...            ClickText    ${text}    anchor=${anchor}    
        ...            ELSE    
        ...            ClickText    ${text}
        Return From Keyword If    ${success}
        Sleep         1s
    END
    
    Fail              Failed to click "${text}" after ${retries} attempts

#----------------------------------
# Utility Keywords
#----------------------------------
Capture Context
    [Documentation]    Capture current page context for debugging
    ...                Useful in test teardown when failures occur
    
    ${current_url}=   Execute Javascript    return window.location.href
    Log               Current URL: ${current_url}
    
    ${page_title}=    Get Title
    Log               Page Title: ${page_title}
    
    Log               Context captured for debugging

Generate Unique Name
    [Documentation]    Generate unique name with timestamp for test data
    ...                
    ...                Example:
    ...                | ${account_name}= | Generate Unique Name | Test Account |
    
    [Arguments]       ${base_name}
    
    ${timestamp}=     Get Current Date    result_format=%Y%m%d_%H%M%S
    ${unique_name}=   Set Variable    ${base_name}_${timestamp}
    
    [Return]          ${unique_name}