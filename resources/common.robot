*** Settings ***
Documentation     Common keywords and setup for Salesforce test automation
...               This resource file contains login, navigation, and data cleanup utilities
Library           QForce
Library           QWeb
Library           String

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
    [Documentation]    Initialize browser with disabled Chrome prompts
    
    # Chrome preferences to disable autofill popups
    ${prefs}=    Create Dictionary
    ...    autofill.profile_enabled=${False}
    ...    credentials_enable_service=${False}
    ...    profile.password_manager_enabled=${False}
    ...    profile.default_content_setting_values.notifications=2
    
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_experimental_option    prefs    ${prefs}
    Call Method    ${chrome_options}    add_argument    --disable-save-password-bubble
    Call Method    ${chrome_options}    add_argument    --disable-blink-features=AutomationControlled
    
    Open Browser    about:blank    chrome    options=${chrome_options}
    Set Library Search Order    QForce    QWeb
    Open Browser                about:blank    ${BROWSER}
    SetConfig                   LineBreak      ${EMPTY}
    SetConfig                   DefaultTimeout    ${DEFAULT_TIMEOUT}
    Log                         Browser setup completed

End Suite
    [Documentation]    Close all browser instances at suite completion
    Close All Browsers
    Log                         All browsers closed

#----------------------------------
# Authentication Keywords
#----------------------------------
Login
    [Documentation]    Login to Salesforce instance with optional MFA support
    
    GoTo              ${login_url}
    TypeText          Username        ${username1}    delay=${CLICK_DELAY}
    TypeText          Password        ${password1}
    ClickText         Log In
    
    # Check if MFA is required
    ${mfa_required}=    Run Keyword And Return Status    Should Not Be Equal    ${None}    ${secret}
    Run Keyword If      ${mfa_required}    Fill MFA
    
    Log                 Login completed

Login As
    [Documentation]    Switch to a different persona in Salesforce
    ...                Requires admin rights to be logged in first
    
    [Arguments]       ${persona}
    
    ClickText         Setup
    ClickText         Setup for current app
    SwitchWindow      NEW
    TypeText          Search Setup    ${persona}    delay=${SEARCH_DELAY}
    ClickText         User            anchor=${persona}    delay=5s
    VerifyText        Freeze          timeout=45s
    ClickText         Login           anchor=Freeze    delay=${CLICK_DELAY}
    
    Log               Logged in as persona: ${persona}

Fill MFA
    [Documentation]    Fill Multi-Factor Authentication code
    
    ${mfa_code}=      GetOTP          ${username}    ${secret}    ${login_url}
    TypeSecret        Verification Code    ${mfa_code}
    ClickText         Verify
    
    Log               MFA verification completed

#----------------------------------
# Navigation Keywords
#----------------------------------
Home
    [Documentation]    Navigate to Salesforce homepage
    
    GoTo              ${home_url}
    ${needs_login}=   IsText          To access this page, you have to log in to Salesforce.    timeout=2s
    Run Keyword If    ${needs_login}    Login
    ClickText         Home
    VerifyTitle       Home | Salesforce
    
    Log               Navigated to Home

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
    [Arguments]       ${text}    ${selected}=true
    
    VerifyElement     //a[@title\="${text}" and @aria-checked\="${selected}"]
    Log               Stage verified: ${text}

Verify No Data
    [Documentation]    Verify that specified data text is not present
    [Arguments]       ${data}    ${timeout}=3s
    
    VerifyNoText      ${data}    timeout=${timeout}    delay=${SEARCH_DELAY}
    Log               Verified no data: ${data}

#----------------------------------
# Data Cleanup Keywords
#----------------------------------
Delete Accounts
    [Documentation]    Delete account record and verify deletion
    [Arguments]       ${account_name}
    
    ClickText         ${account_name}
    ClickText         Delete
    VerifyText        Are you sure you want to delete this account?
    ClickText         Delete    2
    VerifyText        Undo
    VerifyNoText      Undo      timeout=10s
    ClickText         Accounts    partial_match=False
    
    Log               Account deleted: ${account_name}

Delete Leads
    [Documentation]    Delete lead record and verify deletion
    [Arguments]       ${lead_name}
    
    ClickText         ${lead_name}
    ClickText         Delete
    VerifyText        Are you sure you want to delete this lead?
    ClickText         Delete    2
    VerifyText        Undo
    VerifyNoText      Undo      timeout=10s
    ClickText         Leads    partial_match=False
    
    Log               Lead deleted: ${lead_name}

Delete Permission Request
    [Documentation]    Delete Permission Request record
    [Arguments]       ${pr_identifier}=L-010380
    
    HoverText         Fields
    ClickText         Delete
    UseModal          On
    ClickText         Delete
    UseModal          Off
    ClickText         ${pr_identifier}
    
    Log               Permission Request deleted

Delete Record Generic
    [Documentation]    Generic delete keyword for any Salesforce record
    [Arguments]       ${record_name}    ${object_name}    ${confirmation_text}=Are you sure you want to delete
    
    ClickText         ${record_name}
    ClickText         Delete
    VerifyText        ${confirmation_text}
    ClickText         Delete    2
    VerifyText        Undo
    VerifyNoText      Undo      timeout=10s
    ClickText         ${object_name}    partial_match=False
    
    Log               Record deleted: ${record_name}

Bulk Delete Records
    [Documentation]    Delete multiple records of the same type
    [Arguments]       ${record_list}    ${object_name}
    
    FOR    ${record}    IN    @{record_list}
        ${exists}=    Run Keyword And Return Status    IsText    ${record}    timeout=2s
        Run Keyword If    ${exists}    Delete Record Generic    ${record}    ${object_name}
    END
    
    Log               Bulk deletion completed

#----------------------------------
# Modal and Dialog Keywords
#----------------------------------
Handle Confirmation Dialog
    [Documentation]    Handle standard Salesforce confirmation dialogs
    [Arguments]       ${action}    ${verify_text}=${EMPTY}
    
    UseModal          On
    Run Keyword If    '${verify_text}' != '${EMPTY}'    VerifyText    ${verify_text}
    ClickText         ${action}
    UseModal          Off
    
    Log               Dialog handled: ${action}

#----------------------------------
# Wait and Retry Keywords
#----------------------------------
Wait For Salesforce
    [Documentation]    Wait for Salesforce page to fully load
    [Arguments]       ${timeout}=${DEFAULT_TIMEOUT}
    
    Sleep             2s
    ${spinner_present}=    Run Keyword And Return Status    IsText    Loading    timeout=1s
    Run Keyword If    ${spinner_present}    VerifyNoText    Loading    timeout=${timeout}
    
    Log               Page loaded

Click With Retry
    [Documentation]    Click element with retry logic for flaky elements
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
    
    ${current_url}=   Execute Javascript    return window.location.href
    Log               Current URL: ${current_url}
    
    ${page_title}=    GetTitle
    Log               Page Title: ${page_title}

Navigate Back
    [Documentation]    Navigate back using browser history
    ExecuteJavaScript    window.history.back();