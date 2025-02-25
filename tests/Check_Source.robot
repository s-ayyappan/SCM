# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Check Sources
    [tags]                    Sources
    Appstate                  Home
    Sleep                     2s
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
    ScrollText                Recent Items           
    ClickText                 Related
    ClickText                 Details

