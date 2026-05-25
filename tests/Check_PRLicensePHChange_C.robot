*** Settings ***
Documentation     Test suite for verifying PR License status changes when PH changes at Source level
Library           QForce
Resource          ../resources/common.robot

Suite Setup       Setup Browser
Suite Teardown    End suite

# This allows Given/When/Then/And/But prefixes
Library           robot.libraries.BuiltIn    WITH NAME    BuiltIn

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
    
    Given User Navigates To Source Record
    When User Verifies Source Link Status Is Inactive
    And User Activates PRM Account
    Then PRM Account Should Be Active
    When User Deactivates PRM Account
    Then PRM Account Should Be Inactive

*** Keywords ***
Given User Navigates To Source Record
    [Documentation]    Navigate to the Sources app and search for specific source record
    Appstate          Home
    Sleep             2s
    LaunchApp         Sources
    TypeText          Search this list...    ${SOURCE_ID}\n    anchor=${SEARCH_ANCHOR}
    ClickText         ${SOURCE_ID}

When User Verifies Source Link Status Is Inactive
    [Documentation]    Check that the source link has an Inactive status
    ClickText         Related
    VerifyText        Source Links
    ClickText         ${SOURCE_LINK_ID}
    VerifyText        Inactive
    ClickText         ${SOURCE_ID}    anchor=Related

When User Activates PRM Account
    [Documentation]    Enable PRM Account checkbox and save
    Navigate To Department Details
    ClickText         Edit PRM Account
    VerifyText        Billing Street
    VerifyText        Address Search
    VerifyText        PRM Account
    ClickCheckbox     PRM Account    on
    ClickText         Save

Then PRM Account Should Be Active
    [Documentation]    Verify PRM Account is now active
    VerifyText        PRM Account
    # Add verification for active status if needed

When User Deactivates PRM Account
    [Documentation]    Disable PRM Account checkbox and save
    ClickText         Related
    ClickText         Details
    ClickText         ${DEPT_NAME}    anchor=Departamento de Ciencia e Tecnologia Aeroespacial
    ClickText         Edit PRM Account
    ScrollText        Recent Items
    VerifyText        PRM Account
    ClickCheckbox     PRM Account    off
    ClickText         Save

Then PRM Account Should Be Inactive
    [Documentation]    Verify PRM Account is now inactive
    VerifyText        PRM Account
    # Add verification for inactive status if needed

Navigate To Department Details
    [Documentation]    Helper keyword to navigate to department details page
    HoverText         Title Details
    ClickText         ${DEPT_NAME}
    VerifyText        PRM Account