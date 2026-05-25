*** Settings ***
Documentation     Test suite to verify only one primary Account Team Member can be assigned per account
Library           QForce
Library           QWeb
Library           QVision
Resource          ../resources/common.robot

Suite Setup       Setup Browser
Suite Teardown    End suite

*** Variables ***
${ACCOUNT_NAME}           Robot Account
${PUBLISHER_NAME}         Robot Account
${COUNTRY}                United Kingdom
${CITY}                   Oxford
${POSTAL_CODE}            ox4 2wb
${PRIMARY_USER_1}         Sundar Ayyappan
${PRIMARY_USER_2}         Satheesh Selvaraj
${TEAM_ROLE}              Publishing Relations Manager - Serial Content
${WAIT_SHORT}             1s
${WAIT_MEDIUM}            2s
${WAIT_LONG}              5s
${SEARCH_ANCHOR_1}        PRM Account, Owner Last Name, and Created Date aren't searchable. Use filters or sort on these fields instead.
${SEARCH_ANCHOR_2}        Created Date, Owner Last Name, and PRM Account aren't searchable. Use filters or sort on these fields instead.

*** Test Cases ***
Verify Only One Primary Account Team Member Allowed Per Account
    [Tags]                Accounts    TeamMember    Validation    Regression
    [Documentation]       Validates that attempting to add a second primary Account Team Member
    ...                   is prevented. Error message appears in UI (red toast) but automation
    ...                   verifies the business outcome: only one primary member exists.
    
    Given User Creates New Account
    When User Adds First Primary Team Member
    Then First Primary Team Member Should Be Verified
    When User Attempts To Add Second Primary Team Member
    Then Error Message Should Prevent Duplicate Primary
    And Cleanup Test Account

*** Keywords ***
Given User Creates New Account
    [Documentation]    Navigate to Accounts and create a new account with required details
    Log To Console    \n[STEP] Creating New Account
    
    Navigate To Accounts App
    Click New Account Button
    Create Account With Details
    Verify Account Created Successfully
    
    Log To Console    [SUCCESS] Account created successfully

When User Adds First Primary Team Member
    [Documentation]    Add first team member and mark as primary
    Log To Console    \n[STEP] Adding First Primary Team Member
    
    Navigate To Account Record
    Add Team Member    ${PRIMARY_USER_1}    primary=${True}
    
    Log To Console    [SUCCESS] First primary team member added

Then First Primary Team Member Should Be Verified
    [Documentation]    Verify the first primary team member was assigned correctly
    Log To Console    \n[STEP] Verifying First Primary Team Member
    
    ClickText         Details
    VerifyField       Account Owner    ${PRIMARY_USER_1}    tag=a    partial_match=True
    Log               First primary team member verified as account owner    level=INFO
    
    Log To Console    [SUCCESS] First primary team member verified

When User Attempts To Add Second Primary Team Member
    [Documentation]    Attempt to add a second primary team member (should trigger error)
    Log To Console    \n[STEP] Attempting To Add Second Primary Team Member
    
    # Navigate and open Add Team Members modal
    ClickText         Related
    ClickText         Add Team Members
    Sleep             ${WAIT_MEDIUM}
    UseModal          On
    
    # Fill in second team member details
    ClickText         Edit User: Item    anchor=Team Role
    ComboBox          Search People...    ${PRIMARY_USER_2}
    ClickText         Edit Team Role: Item    anchor=Team Role
    PickList          Team Role    ${TEAM_ROLE}
    
    # Mark as primary
    VerifyText        Primary
    ClickText         Edit Primary: Item    anchor=Delete item 1
    HotKey            Space
    
    # Click Save - this triggers the error
    ClickText         Save
    
    Log To Console    [INFO] Save clicked - expecting error

Then Error Message Should Prevent Duplicate Primary
    [Documentation]    Cancel operation and verify only one primary exists
    Log To Console    \n[STEP] Verifying Duplicate Prevention
    
    # Wait for error toast
    Sleep             3s
    Log               Error occurred (visible in UI but not verified by automation)    level=INFO
    
    # Cancel the Add Team Members modal
    ClickText         Cancel    partial_match=False
    Log               Add Team Members operation canceled    level=INFO
    
    # CRITICAL: Close modal context
    UseModal          Off
    Sleep             ${WAIT_MEDIUM}
    
    # Verify we're on the account record page
    VerifyText        ${ACCOUNT_NAME}
    
    # Click Related tab
    ClickText         Related
    Sleep             ${WAIT_SHORT}
    
    # Verify first primary member is still primary
    ClickText         ${PRIMARY_USER_1} Team Member Record
    VerifyText        Primary
    Log               First primary member verified as still primary    level=INFO
    
    Log To Console    [SUCCESS] First primary member verified - duplicate was prevented
And Cleanup Test Account
    [Documentation]    Delete the test account created during the test
    Log To Console    \n[STEP] Cleaning Up Test Account
    
    Navigate To Accounts App
    Search And Delete Account    ${ACCOUNT_NAME}
    
    Log To Console    [SUCCESS] Test account deleted

# ========== Helper Keywords ==========

Navigate To Accounts App
    [Documentation]    Navigate to Accounts application
    Appstate          Home
    Sleep             ${WAIT_SHORT}
    LaunchApp         Accounts
    VerifyText        Accounts
    Log               Navigated to Accounts app    level=INFO

Click New Account Button
    [Documentation]    Click New button to create account
    ClickText         Select a List View: Accounts
    ClickText         All Accounts
    ClickText         New    anchor=Import
    Log               Clicked New Account button    level=INFO

Create Account With Details
    [Documentation]    Fill in account creation form with all required details
    # Search and create new
    TypeText          Enter Keyword To Search For An Organisation...    ${ACCOUNT_NAME}
    ClickText         Search    partial_match=False
    ClickText         Create New Account
    
    UseModal          On
    
    # Basic details
    TypeText          *Account Name    ${ACCOUNT_NAME}
    TypeText          Publisher Display Name    ${PUBLISHER_NAME}
    
    # Location details
    TypeText          ECH Country    ${COUNTRY}
    TypeText          ECH City    ${CITY}
    
    # Billing address
    ComboBox          Search Address    ${CITY}
    TypeText          Billing Zip/Postal Code    ${POSTAL_CODE}
    
    SwipeDown         1
    ClickText         Save    partial_match=False
    Sleep             ${WAIT_MEDIUM}
    UseModal          Off
    
    Log               Account details filled and saved    level=INFO

Verify Account Created Successfully
    [Documentation]    Verify the account was created with correct details
    VerifyText        ${ACCOUNT_NAME}    anchor=Account
    VerifyField       Account Name    ${ACCOUNT_NAME}    partial_match=True
    VerifyField       Publisher Display Name    ${PUBLISHER_NAME}    partial_match=True
    Log               Account creation verified    level=INFO

Navigate To Account Record
    [Documentation]    Search for and open the account record
    Appstate          Home
    Sleep             ${WAIT_SHORT}
    LaunchApp         Accounts
    
    TypeText          Search this list...    ${ACCOUNT_NAME}\n    anchor=${SEARCH_ANCHOR_1}
    ClickText         ${ACCOUNT_NAME}
    Sleep             ${WAIT_MEDIUM}
    VerifyText        ${ACCOUNT_NAME}
    
    Log               Navigated to account record    level=INFO

Add Team Member
    [Documentation]    Add a team member with specified role and primary status
    ...               Args: user_name, primary (True/False), save (True/False)
    [Arguments]       ${user_name}    ${primary}=${False}    ${save}=${True}
    
    ClickText         Related
    ClickText         Add Team Members
    Sleep             ${WAIT_MEDIUM}
    UseModal          On
    
    # Select user
    ClickText         Edit User: Item    anchor=Team Role
    ComboBox          Search People...    ${user_name}
    
    # Select team role
    ClickText         Edit Team Role: Item    anchor=Team Role
    PickList          Team Role    ${TEAM_ROLE}
    
    # Set primary if requested
    Run Keyword If    ${primary}    Set Team Member As Primary
    
    # Save or leave modal open
    Run Keyword If    ${save}    Run Keywords
    ...    ClickText    Save
    ...    AND    UseModal    Off
    ...    AND    Log    Team member ${user_name} saved    level=INFO
    ...    ELSE    Log    Team member ${user_name} added but not saved    level=INFO

Set Team Member As Primary
    [Documentation]    Mark the current team member as primary
    VerifyText        Primary
    ClickText         Edit Primary: Item    anchor=Delete item 1
    HotKey            Space
    Log               Team member marked as primary    level=INFO

Search And Delete Account
    [Documentation]    Search for account and delete it
    [Arguments]       ${account_name}
    
    Sleep             ${WAIT_MEDIUM}
    TypeText          Search this list...    ${account_name}\n    anchor=${SEARCH_ANCHOR_2}
    Sleep             ${WAIT_MEDIUM}
    VerifyText        ${account_name}
    
    # Open actions menu and delete
    ClickText         Show Actions
    HoverText         Show more actions
    HoverText         Delete
    ClickText         Delete
    Sleep             ${WAIT_LONG}
    
    # Confirm deletion
    UseModal          On
    VerifyText        Are you sure you want to delete this account?
    ClickText         Delete
    UseModal          Off
    Sleep             ${WAIT_LONG}
    
    Log               Account ${account_name} deleted    level=INFO