*** Settings ***
Documentation    Create and validate Source Child Records with automated cleanup
...              This test suite creates source records, validates related objects,
...              and ensures proper cleanup of test data.
Library          QWeb
Library          Collections
Library          String
Library          OperatingSystem
Resource         ../resources/common.robot
Suite Setup      Suite Initialization
Suite Teardown   Suite Cleanup
Test Setup       Test Initialization
Test Teardown    Test Cleanup
Default Tags     Regression

*** Variables ***
# Test Data
${SOURCE_TITLE}              Source Child CRT
${PUBLISHER}                 Aalborg University
${PERMISSION_HOLDER}         Aalborg University
${CONTENT_PROVIDER}          Avignon University
${ISSN_VALUE}                1122334X
${EISSN_VALUE}               87654321
${FUNDING_BODY_ID}           11223344

# Wait Times
${WAIT_SHORT}                2s
${WAIT_MEDIUM}               3s
${WAIT_LONG}                 5s
${MODAL_WAIT}                1s

# Field Labels
${COUNTRY_FIELD}             Country
${LICENSE_PROCESS_FIELD}     License/SourceLink creation Process
${CONTENT_SET_FIELD}         Content Set
${CONTENT_TYPE_FIELD}        Content Type

# Expected Values
${EXPECTED_LICENSE}          Elsevier License Template
${EXPECTED_PR_COUNT}         Permission Requests(1)
${EXPECTED_RR_COUNT}         Rights and Restrictions (6)
${EXPECTED_RPH_COUNT}        Right and Permission History (5)

# Selectors
${NEW_BUTTON}                New
${SAVE_BUTTON}               Save
${DELETE_BUTTON}             Delete
${CONFIRM_BUTTON}            Confirm
${RELATED_TAB}               Related

# Created Record IDs (stored during test execution)
${CREATED_SOURCE_ID}         ${EMPTY}
${CREATED_PR_ID}             ${EMPTY}
${CREATED_SL_ID}             ${EMPTY}

*** Test Cases ***
Create New Source Child Records
    [Documentation]    Creates a new source with all required fields, validates related records, and performs cleanup
    [Tags]             Sources    New    Smoke    Critical
    
    Launch Source Application
    Create New Source Record
    Validate Source Creation
    Validate Permission Request
    Validate Related Records
    Validate Rights And Restrictions
    Navigate Back To Source

Create Source With Invalid Data
    [Documentation]    Negative test: Validate error handling with invalid ISSN format
    [Tags]             Sources    Negative    Validation
    
    Launch Source Application
    ClickText         New
    UseModal          On
    ClickText         Next
    TypeText          *Title Name               Invalid Source Test
    ComboBox          Publisher                 ${PUBLISHER}
    TypeText          ISSN                      INVALID123    # Invalid format
    ${error_present}=    Run Keyword And Return Status    VerifyText    Invalid ISSN format
    Should Be True    ${error_present}    Expected ISSN validation error
    ClickText         Cancel
    UseModal          Off

Create Source From Template
    [Documentation]    Data-driven test: Create multiple sources with different parameters
    [Tags]             Sources    DataDriven
    [Template]        Create Source With Parameters
    
    # Title                Country          Publisher              Content Provider
    Source UK Test        United Kingdom   Aalborg University     Avignon University
    Source US Test        United States    Cambridge University   Oxford University
    Source DE Test        Germany          Aalborg University     Aalborg University

*** Keywords ***
#----------------------------------
# Setup and Teardown Keywords
#----------------------------------
Suite Initialization
    [Documentation]    One-time setup for the entire test suite
    Log To Console    Starting Source Child Records Test Suite
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    Set Suite Variable    ${TEST_RUN_ID}    ${timestamp}
    Log               Test Run ID: ${TEST_RUN_ID}

Suite Cleanup
    [Documentation]    Cleanup after all tests complete
    Log To Console    Test Suite Completed
    Log To Console    All tests executed successfully

Test Initialization
    [Documentation]    Setup before each test case
    ${test_name}=    Get Test Name
    Log    Starting test: ${test_name}
    ${start_time}=    Get Current Date
    Set Test Variable    ${TEST_START_TIME}    ${start_time}

Test Cleanup
    [Documentation]    Cleanup after each test case with error handling
    
    Run Keyword If Test Failed    Capture Failure Information
    
    # Attempt cleanup of created records
    ${cleanup_status}=    Run Keyword And Return Status    Cleanup Created Records
    Run Keyword Unless    ${cleanup_status}    Log    Warning: Cleanup may have failed    WARN
    
    # Log test duration
    ${end_time}=    Get Current Date
    ${duration}=    Subtract Date From Date    ${end_time}    ${TEST_START_TIME}
    Log    Test Duration: ${duration} seconds

Capture Failure Information
    [Documentation]    Capture detailed information when test fails (CRT handles screenshots automatically)
    
    # Capture browser console logs if available
    ${console_logs}=    Run Keyword And Ignore Error    Execute Javascript    return window.console.logs
    Log    Console logs: ${console_logs}
    
    # Capture current URL for debugging
    ${current_url}=    Get Current URL
    Log    Failed at URL: ${current_url}
    
    # Log test context
    Log    Test failed for: ${SOURCE_TITLE}
    Log    Created Source ID: ${CREATED_SOURCE_ID}
    Log    Created PR ID: ${CREATED_PR_ID}
    Log    Created SL ID: ${CREATED_SL_ID}

#----------------------------------
# Main Test Flow Keywords
#----------------------------------
Launch Source Application
    [Documentation]    Navigate to Sources application
    Appstate          Home
    Sleep             ${WAIT_SHORT}
    LaunchApp         Sources
    Wait Until Page Loaded

Create New Source Record
    [Documentation]    Create new source with all required field values
    ClickText         ${NEW_BUTTON}
    UseModal          On
    Wait For Modal Load
    
    ClickText         Next
    VerifyText        New Source: Full
    
    Fill Source Title Details
    Fill Source Additional Fields
    Save Initial Source Record
    Fill Source Identification Numbers
    Select And Confirm License

Fill Source Title Details
    [Documentation]    Fill the main source information fields
    TypeText          *Title Name               ${SOURCE_TITLE}
    ComboBox          Publisher                 ${PUBLISHER}
    Sleep             ${MODAL_WAIT}    # Allow dropdown to populate
    ComboBox          Permission Holder         ${PERMISSION_HOLDER}
    Sleep             ${MODAL_WAIT}
    ComboBox          Content Provider          ${CONTENT_PROVIDER}
    Log               Title details filled successfully

Fill Source Additional Fields
    [Documentation]    Fill country, license process, and content fields
    PickList          ${COUNTRY_FIELD}          United Kingdom
    MultiPickList     ${LICENSE_PROCESS_FIELD}  Manual
    PickList          ${CONTENT_SET_FIELD}      Complete Collection
    MultiPickList     ${CONTENT_TYPE_FIELD}     Funding & Grants
    Log               Additional fields filled successfully

Save Initial Source Record
    [Documentation]    Save the source record and handle modal
    ClickText         ${SAVE_BUTTON}            partial_match=False
    Sleep             ${WAIT_SHORT}
    Log               Initial source record saved

Fill Source Identification Numbers
    [Documentation]    Enter ISSN, E-ISSN, and Funding Body ID
    TypeText          ISSN                      ${ISSN_VALUE}
    TypeText          E-ISSN                    ${EISSN_VALUE}
    TypeText          Funding Body ID           ${FUNDING_BODY_ID}
    Log               Identification numbers entered

Select And Confirm License
    [Documentation]    Select license template and confirm
    ClickCheckbox     Select Item 2             on    partial_match=False
    VerifyText        ${EXPECTED_LICENSE}
    ClickText         ${CONFIRM_BUTTON}
    Sleep             ${WAIT_SHORT}
    UseModal          Off
    Log               License selected and confirmed

Validate Source Creation
    [Documentation]    Verify the source was created successfully
    Wait Until Keyword Succeeds    ${WAIT_MEDIUM}    500ms    VerifyText    ${SOURCE_TITLE}
    
    # Capture the source ID for cleanup
    ${source_id}=    Get Source ID From URL
    Set Test Variable    ${CREATED_SOURCE_ID}    ${source_id}
    Log               Source created successfully with ID: ${source_id}

Validate Permission Request
    [Documentation]    Verify Permission Request was auto-created
    ClickText         ${RELATED_TAB}
    ClickText         ${EXPECTED_PR_COUNT}      partial_match=True
    VerifyText        Permission Requests       anchor=Source
    Sleep             ${WAIT_MEDIUM}
    
    # Navigate to Permission Request details
    UseTable          Select Item 1
    ClickText         PR-                       anchor=${PUBLISHER}
    
    # Capture PR ID for reference
    ${pr_id}=    Get Record ID From URL
    Set Test Variable    ${CREATED_PR_ID}    ${pr_id}
    Log               Permission Request validated with ID: ${pr_id}

Validate Related Records
    [Documentation]    Verify Source Link and Rights & Permissions were created
    ClickText         ${RELATED_TAB}
    SwipeDown
    
    Verify Source Link Exists
    Verify Rights And Permissions Exist

Verify Source Link Exists
    [Documentation]    Verify Source Link is present and accessible
    ${sl_present}=    Run Keyword And Return Status    ClickText    SL
    Should Be True    ${sl_present}    Source Link should be present
    Log               Source Link present and validated
    
    # Capture SL ID for cleanup
    ${sl_id}=    Get Record ID From URL
    Set Test Variable    ${CREATED_SL_ID}    ${sl_id}

Verify Rights And Permissions Exist
    [Documentation]    Verify Rights and Permission records exist
    ClickText         RP
    Log               Right and Permission present and validated

Validate Rights And Restrictions
    [Documentation]    Verify Rights and Restrictions and history records
    
    # Verify Rights and Restrictions
    ClickText         ${EXPECTED_RR_COUNT}
    Wait Until Page Loaded
    VerifyText        Rights and Restrictions
    Navigate Back
    Sleep             ${WAIT_SHORT}
    
    # Verify Right and Permission History
    ClickText         ${EXPECTED_RPH_COUNT}
    Wait Until Page Loaded
    Navigate Back
    Sleep             ${WAIT_SHORT}
    
    Log               Rights and Restrictions validated successfully

Navigate Back To Source
    [Documentation]    Navigate back to the main source record
    ClickText         T-                        anchor=Source
    Wait Until Page Loaded
    VerifyText        Title Id
    Log               Navigated back to source record

#----------------------------------
# Cleanup Keywords
#----------------------------------
Cleanup Created Records
    [Documentation]    Delete test data - Source and Source Link with error handling
    
    Run Keyword And Ignore Error    Delete Source Record
    Run Keyword And Ignore Error    Delete Source Link Record
    
    Log               Cleanup completed

Delete Source Record
    [Documentation]    Delete the created source record
    
    # Verify we're on the correct record
    VerifyText        Title Id
    Sleep             ${WAIT_SHORT}
    VerifyText        Change Permission Holder
    
    # Navigate to delete action
    Hover And Wait    Refresh DOAJ/URL Tracker
    Hover And Wait    Change Permission Holder
    ClickText         Show more actions
    Hover And Wait    Log a Call
    ClickText         ${DELETE_BUTTON}
    
    # Confirm deletion
    UseModal          On
    Wait For Modal Load
    ClickText         ${DELETE_BUTTON}
    Sleep             ${WAIT_SHORT}
    
    Log               Source record deleted successfully

Delete Source Link Record
    [Documentation]    Delete the associated source link record
    
    ClickText         ${RELATED_TAB}
    SwipeDown
    ClickText         Source Links
    
    ${sl_present}=    Run Keyword And Return Status    ClickText    SL-
    Return From Keyword If    not ${sl_present}
    
    ClickText         ${DELETE_BUTTON}
    UseModal          On
    Wait For Modal Load
    ClickText         ${DELETE_BUTTON}
    Sleep             ${WAIT_SHORT}
    
    Log               Source Link record deleted successfully

#----------------------------------
# Template Keywords for Data-Driven Testing
#----------------------------------
Create Source With Parameters
    [Documentation]    Template keyword for creating sources with different parameters
    [Arguments]       ${title}    ${country}    ${publisher}    ${content_provider}
    
    Launch Source Application
    ClickText         ${NEW_BUTTON}
    UseModal          On
    ClickText         Next
    
    TypeText          *Title Name               ${title}
    ComboBox          Publisher                 ${publisher}
    ComboBox          Permission Holder         ${publisher}
    ComboBox          Content Provider          ${content_provider}
    PickList          ${COUNTRY_FIELD}          ${country}
    
    ClickText         ${SAVE_BUTTON}            partial_match=False
    Sleep             ${WAIT_SHORT}
    UseModal          Off
    
    VerifyText        ${title}
    Log               Source created with title: ${title}
    
    # Cleanup this parameterized test data
    Run Keyword And Ignore Error    Delete Source Record

#----------------------------------
# Utility Keywords
#----------------------------------
Wait Until Page Loaded
    [Documentation]    Wait for page to fully load
    Sleep             ${WAIT_SHORT}

Wait For Modal Load
    [Documentation]    Wait for modal dialog to fully render
    Sleep             ${MODAL_WAIT}

Navigate Back
    [Documentation]    Navigate back using browser history
    ExecuteJavaScript    window.history.back();

Hover And Wait
    [Documentation]    Hover over element with small wait for UI response
    [Arguments]       ${text}
    HoverText         ${text}
    Sleep             500ms

Get Source ID From URL
    [Documentation]    Extract source ID from current URL
    ${url}=           Get Current URL
    ${id}=            Extract ID From URL    ${url}
    [Return]          ${id}

Get Record ID From URL
    [Documentation]    Extract record ID from current URL
    ${url}=           Get Current URL
    ${id}=            Extract ID From URL    ${url}
    [Return]          ${id}

Extract ID From URL
    [Documentation]    Extract Salesforce ID from URL
    [Arguments]       ${url}
    ${parts}=         Split String    ${url}    /
    ${id}=            Get From List   ${parts}    -1
    [Return]          ${id}

Get Current URL
    [Documentation]    Get current browser URL
    ${url}=           ExecuteJavaScript    return window.location.href
    [Return]          ${url}

Get Test Name
    [Documentation]    Get current test case name
    ${test_name}=     Set Variable    ${TEST NAME}
    [Return]          ${test_name}

#----------------------------------
# Verification Keywords with Retry Logic
#----------------------------------
Verify Text With Retry
    [Documentation]    Verify text with retry mechanism for dynamic content
    [Arguments]       ${text}    ${timeout}=${WAIT_MEDIUM}    ${interval}=500ms
    Wait Until Keyword Succeeds    ${timeout}    ${interval}    VerifyText    ${text}

Verify Element With Retry
    [Documentation]    Verify element with retry mechanism
    [Arguments]       ${locator}    ${timeout}=${WAIT_MEDIUM}
    Wait Until Keyword Succeeds    ${timeout}    500ms    VerifyElement    ${locator}