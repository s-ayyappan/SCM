# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Check Refresh DOAJ/URL Tracker
    [tags]                    Sources, Referesh DOAJ
    [Documentation]           The script check whether the Refresh DOAJ/URL tracker API is triggered successfully
    Appstate                  Home
    LaunchApp                 Sources
  
    TypeText                  Search this list...    T-14688\n    anchor=Account Manager, Content Provider, and Created Date aren't searchable. Use filters or sort on these fields instead.
    ClickText                 T-14688
    VerifyText                GeroFam
    VerifyText                GeroFam
    VerifyField               Title Id    T-14688    partial_match=True
    VerifyField               Publisher    GeroFam    tag=a    partial_match=True
    VerifyField               ISSN    13096478    partial_match=True
    VerifyField               E-ISSN    13098675    partial_match=True
    VerifyField               OBII Id    277656999    partial_match=True     

#capture the API called at timing and status
    SwipeDown
    ScrollText    Last API call for DOAJ and URL Tracker
    ScrollText    Recent Items
#    VerifyText    API Called at
#    VerifyText    02/04/2025, 15:32
    VerifyText    API Status
    VerifyText    Timeout
#click the Refresh DOAJ button and checkt the API Status
    ClickText    Refresh DOAJ/URL Tracker
    VerifyText    API Called at
    VerifyText    API Status
    VerifyText    Requested

# First verify that checkbox is not present using Is Text
    ${exists}=         Is Text          VerifyText    Requested

# Verify the checkbox does not exist (exists should be False)
    IF  ${exists}
        Log  DOAJ API call successfully made
    ELSE            
        Log  DOAJ API call not successfully made
    END 