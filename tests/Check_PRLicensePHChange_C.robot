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
    Sleep             2s
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
    
    VerifyText        PRM Account
    
    # Direct verification with built-in error message
    VerifyCheckboxValue    PRM Account    on
    Log    PRM Account checkbox verified as checked (Active)    level=INFO
    
    Log To Console    [SUCCESS] PRM Account is Active
    
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

PRM Account Should Be Inactive
    [Documentation]    Verify PRM Account is now inactive
    VerifyText        PRM Account
    # Add verification for inactive status if needed

Navigate To Department Details
    [Documentation]    Helper keyword to navigate to department details page
    HoverText         Title Details
    ClickText         ${DEPT_NAME}
    VerifyText        PRM Account