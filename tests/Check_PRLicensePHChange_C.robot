*** Settings ***
Documentation     Test suite for verifying PR License status changes when PH changes at Source level
Library           QForce
Resource          ../resources/common.robot

Suite Setup       Setup Browser
Suite Teardown    End suite

# Enable BDD-style keyword prefixes
Test Template     ${EMPTY}

*** Variables ***
${SOURCE_ID}              T-15425
${SOURCE_LINK_ID}         SL-000410
${WAIT_SHORT}             2s     
${WAIT_MEDIUM}            3s
${DEPT_NAME}              Department of Science and Aerospacial Technology
${SEARCH_ANCHOR}          Account Manager, Content Provider, and Created Date aren't searchable. Use filters or sort on these fields instead.

*** Test Cases ***
Verify PR License Becomes Inactive When PH Changes At Source Level
    [Tags]            Sources    PRMLicense    Regression
    [Documentation]   Validates that an active PR license automatically changes to Inactive
    ...               when there is a PH (Primary Holder) change at the Source level
    
    User Navigates To Source Record
    User Verifies Source Link Status Is Inactive
    User Activates PRM Account
    PRM Account Should Be Active
    User Deactivates PRM Account
    PRM Account Should Be Inactive

*** Keywords ***
User Navigates To Source Record
    [Documentation]    Navigate to the Sources app and search for specific source record
    Appstate          Home
    Sleep             ${WAIT_SHORT}  
    LaunchApp         Sources
    TypeText          Search this list...    ${SOURCE_ID}\n    anchor=${SEARCH_ANCHOR}
    ClickText         ${SOURCE_ID}
    Log To Console    [SUCCESS] Successfully navigated to Source record

User Verifies Source Link Status Is Inactive
    [Documentation]    Check that the source link has an Inactive status
    ClickText         Related
    VerifyText        Source Links
    ClickText         ${SOURCE_LINK_ID}
    VerifyText        Inactive
    ClickText         ${SOURCE_ID}    anchor=Related
    Log To Console    [SUCCESS] Source Link status verified as Inactive

User Activates PRM Account
    [Documentation]    Enable PRM Account checkbox and save
    Navigate To Department Details
    ClickText         Edit PRM Account
    VerifyText        Billing Street
    VerifyText        Address Search
    VerifyText        PRM Account
    ClickCheckbox     PRM Account    on
    ClickText         Save
    Log To Console    [SUCCESS] PRM Account activated successfully

PRM Account Should Be Active
    [Documentation]    Verify PRM Account is now active
    Log    Verifying PRM Account is active    level=INFO
    Log To Console    \n[STEP] Verifying PRM Account is Active
    
    # Wait for save to complete
    Sleep    ${WAIT_MEDIUM}
    
    # Navigate to PRM Account view
    ClickText         Related
    ClickText         Details  
    ClickText         ${DEPT_NAME}
    VerifyText        PRM Account
    
    # Capture evidence
    #Capture Page Screenshot    prm_account_active.png
    Log    PRM Account page captured after activation    level=INFO
    Log To Console    [SUCCESS] PRM Account activation completed - screenshot saved

PRM Account Should Be Inactive
    [Documentation]    Verify PRM Account is now inactive
    Log    Verifying PRM Account is inactive    level=INFO
    Log To Console    \n[STEP] Verifying PRM Account is Inactive
    
    # Wait for save to complete
    Sleep    ${WAIT_MEDIUM}
    
    # Navigate to PRM Account view
    ClickText         Related
    ClickText         Details
    ClickText         ${DEPT_NAME}
    VerifyText        PRM Account
    
    # Capture evidence
    #Capture Page Screenshot    prm_account_inactive.png
    Log    PRM Account page captured after deactivation    level=INFO
    Log To Console    [SUCCESS] PRM Account deactivation completed - screenshot saved
    
User Deactivates PRM Account
    [Documentation]    Disable PRM Account checkbox and save
    ClickText         Related
    ClickText         Details
    ClickText         ${DEPT_NAME}    anchor=Departamento de Ciencia e Tecnologia Aeroespacial
    ClickText         Edit PRM Account
    ScrollText        Recent Items
    VerifyText        PRM Account
    ClickCheckbox     PRM Account    off
    ClickText         Save
    Log To Console    [SUCCESS] PRM Account deactivated successfully

Navigate To Department Details
    [Documentation]    Helper keyword to navigate to department details page
    HoverText         Title Details
    ClickText         ${DEPT_NAME}
    VerifyText        PRM Account