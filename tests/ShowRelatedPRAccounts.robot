*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Verify Permission Request Appears In Related Account
    [Tags]            Permission Request
    [Documentation]   Verify that a Permission Request opened directly from the
    ...               Permission Requests list also appears, with the same name,
    ...               in the Related Permission Requests list of its parent Account.

    # --- Open the Permission Request from the list view ---
    Appstate          Home
    Sleep             2s
    LaunchApp         Permission Requests

    ClickText         Select a List View: Permission Requests
    ClickText         All Permission Requests
    HoverText         Show Actions
    TypeText          Search this list...    PR-00003499\n    anchor=Clear

    # --- Guard against an empty search result before trying to click the row ---
    ${found}=       Run Keyword And Return Status    VerifyText    PR-00003499    timeout=10
    ${no_results}=  Run Keyword And Return Status    VerifyText    No items to display
    IF    not ${found} and ${no_results}
        Fail    Search for PR-00003499 returned no results under "All Permission Requests". Verify the record exists, is not filtered out (owner/record-type filters), and search indexing is not delayed.
    ELSE IF    not ${found}
        Fail    PR-00003499 not found after search, and no explicit "no results" message was detected either — check list view state/screenshot for the actual cause.
    END

    ClickText         PR-00003499
    VerifyText        PR-00003499

    # --- Capture the PR name from the record detail page ---
    ${pr_name_detail}=    GetText    Permission Request Name

    ClickText         Related
    ClickText         Details

    # --- Navigate to the related Account, then back into its Related PR list ---
    ClickText         Oral Medicine
    ClickText         Related
    SwipeDown
    VerifyText        Sources (Publisher)
    ClickText         Permission Requests    anchor=Title Id
    ClickText         PR-00003499

    # --- Capture the PR name as shown from the Account's Related tab ---
    VerifyText        Permission Request Name
    ${pr_name_account}=    GetText    Permission Request Name

    # --- Compare the two captures instead of a hardcoded string ---
    IF    "${pr_name_account}" == "${pr_name_detail}"
        Log    Same PR (${pr_name_account}) exists in the Account's Related tab
    ELSE
        Fail    PR mismatch: expected "${pr_name_detail}" but found "${pr_name_account}" in Account Related tab
    END