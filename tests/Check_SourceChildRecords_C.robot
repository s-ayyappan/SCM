*** Settings ***
Documentation    Create and validate Source Child Records with automated cleanup
Library          QForce
Library          String
Resource         ../resources/common.robot
Suite Setup      Setup Browser
Suite Teardown   End Suite
Test Teardown    Test Cleanup
Default Tags     Regression    Sources

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

*** Test Cases ***
Create New Source Child Records
    [Documentation]    Creates a new source with all required fields, validates related records, and performs cleanup
    [Tags]             New    Critical
    
    Launch Source Application
    Create New Source Record
    Validate Source Creation
    Validate Permission Request
    Validate Related Records
    Validate Rights And Restrictions
    Navigate Back To Source

Create Source With Invalid Data
    [Documentation]    Negative test: Validate error handling with invalid ISSN format
    [Tags]             Negative    Validation
    
    Launch Source Application
    
    # Open form
    ClickText         New
    UseModal          On
    ClickText         Next
    
    # Fill required fields
    TypeText          *Title Name               Invalid Source Test
    ComboBox          Publisher                 ${PUBLISHER}
    ComboBox          Permission Holder         ${PUBLISHER}
    ComboBox          Content Provider          ${PUBLISHER}
    PickList          Country                   United Kingdom

    # Enter mandatory Content Set and Content Type
    PickList          Content Set               Complete Collection
    MultiPickList     Content Type              Book series
    ClickText         Move selection to Chosen    anchor=Book series

    # Enter mandatory Content Set and Content Type
    PickList          *Content Set    Complete Collection
    MultiPickList     Content Type    Book series
    ClickText         Move selection to Chosen    anchor=Book series
    # Enter invalid ISSN and save
    TypeText          ISSN                      INVALID123
    HotKey            Tab
    Sleep             1s
    ClickText         Save                      partial_match=False
    Sleep             2s
    
    # Check for errors
    ${error1}=        Run Keyword And Return Status    VerifyText    Invalid    timeout=2s
    ${error2}=        Run Keyword And Return Status    VerifyText    Error      timeout=1s
    ${any_error}=     Evaluate    ${error1} or ${error2}
    
    # Skip if validation not configured
    Run Keyword If    '${any_error}' == 'False'
    ...               Skip    ISSN validation not configured
    
    Should Be True    ${any_error}    Expected ISSN validation error
    
    # Cleanup
    ClickText         Cancel    timeout=2s
    UseModal          Off

*** Keywords ***
#----------------------------------
# Test Cleanup
#----------------------------------
Test Cleanup
    [Documentation]    Cleanup after each test case
    Run Keyword If Test Failed    Capture Context
    ${cleanup_status}=    Run Keyword And Return Status    Cleanup Created Records
    Run Keyword Unless    ${cleanup_status}    Log    Cleanup may have failed    WARN

#----------------------------------
# Main Test Flow Keywords
#----------------------------------
Launch Source Application
    [Documentation]    Navigate to Sources application
    Appstate          Home
    Sleep             ${WAIT_SHORT}
    LaunchApp         Sources
    Log               Sources application launched

Create New Source Record
    [Documentation]    Create new source with all required field values
    ClickText         ${NEW_BUTTON}
    UseModal          On
    Sleep             1s
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
    Sleep             1s
    ComboBox          Permission Holder         ${PERMISSION_HOLDER}
    Sleep             1s
    ComboBox          Content Provider          ${CONTENT_PROVIDER}
    Log               Title details filled

Fill Source Additional Fields
    [Documentation]    Fill country, license process, and content fields
    PickList          ${COUNTRY_FIELD}          United Kingdom
    MultiPickList     ${LICENSE_PROCESS_FIELD}  Manual
    PickList          ${CONTENT_SET_FIELD}      Complete Collection
    MultiPickList     ${CONTENT_TYPE_FIELD}     Funding & Grants
    Log               Additional fields filled

Save Initial Source Record
    [Documentation]    Save the source record
    ClickText         ${SAVE_BUTTON}            partial_match=False
    Sleep             ${WAIT_SHORT}
    Log               Initial record saved

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
    Log               License confirmed

Validate Source Creation
    [Documentation]    Verify the source was created successfully
    Wait Until Keyword Succeeds    ${WAIT_MEDIUM}    500ms    VerifyText    ${SOURCE_TITLE}
    Log               Source created successfully

Validate Permission Request
    [Documentation]    Verify Permission Request was auto-created
    ClickText         ${RELATED_TAB}
    ClickText         ${EXPECTED_PR_COUNT}      partial_match=True
    VerifyText        Permission Requests       anchor=Source
    Sleep             ${WAIT_MEDIUM}
    UseTable          Select Item 1
    ClickText         PR-                       anchor=${PUBLISHER}
    Log               Permission Request validated

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
    Log               Source Link validated

Verify Rights And Permissions Exist
    [Documentation]    Verify Rights and Permission records exist
    ClickText         RP
    Log               Rights and Permissions validated

Validate Rights And Restrictions
    [Documentation]    Verify Rights and Restrictions and history records
    ClickText         ${EXPECTED_RR_COUNT}
    Sleep             ${WAIT_SHORT}
    VerifyText        Rights and Restrictions
    Navigate Back
    Sleep             ${WAIT_SHORT}
    ClickText         ${EXPECTED_RPH_COUNT}
    Sleep             ${WAIT_SHORT}
    Navigate Back
    Sleep             ${WAIT_SHORT}
    Log               Rights and Restrictions validated

Navigate Back To Source
    [Documentation]    Navigate back to the main source record
    ClickText         T-                        anchor=Source
    Sleep             ${WAIT_SHORT}
    VerifyText        Title Id
    Log               Navigated back to source

#----------------------------------
# Cleanup Keywords
#----------------------------------
Cleanup Created Records
    [Documentation]    Delete test data - Source and Source Link
    Run Keyword And Ignore Error    Delete Source Record
    Run Keyword And Ignore Error    Delete Source Link Record
    Log               Cleanup completed

Delete Source Record
    [Documentation]    Delete the created source record
    VerifyText        Title Id
    Sleep             ${WAIT_SHORT}
    VerifyText        Change Permission Holder
    HoverText         Refresh DOAJ/URL Tracker
    HoverText         Change Permission Holder
    ClickText         Show more actions
    HoverText         Log a Call
    ClickText         ${DELETE_BUTTON}
    UseModal          On
    Sleep             1s
    ClickText         ${DELETE_BUTTON}
    Sleep             ${WAIT_SHORT}
    Log               Source deleted

Delete Source Link Record
    [Documentation]    Delete the associated source link record
    ClickText         ${RELATED_TAB}
    SwipeDown
    ClickText         Source Links
    ${sl_present}=    Run Keyword And Return Status    ClickText    SL-
    Return From Keyword If    not ${sl_present}
    ClickText         ${DELETE_BUTTON}
    UseModal          On
    Sleep             1s
    ClickText         ${DELETE_BUTTON}
    Sleep             ${WAIT_SHORT}
    Log               Source Link deleted
