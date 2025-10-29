*** Settings ***
Library    QForce
Library    String
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Check Source to License Child records
    [tags]                    Sources, PR, Source Links
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Sources
    
#navigate to the source
    
    ClickText                 Select a List View: Sources
    ClickText                 All Titles
    TypeText                  Search this list...    CRT Test Source\n    anchor=Account Manager, Created Date, and Content Provider aren't searchable. Use filters or sort on these fields instead.
    VerifyText                CRT Test Source
    ClickText                 T-56248
    ClickText                 Related
    ClickText                 PR-00025183
    VerifyText                License
    VerifyText                L-010852
    ClickText                 Related
    SwipeDown
    VerifyText                Source Links
    ClickText                 SL-014889
    VerifyText                Source Link
    VerifyText                SL-014889
    ClickFieldValue           Right and Permission
    VerifyText                Right and Permission
    VerifyText                RP-010641
    VerifyField               License    L-010852    tag=a    partial_match=True
    ClickFieldValue           License
    VerifyField               License Template   Elsevier Permission Form Template    tag=a    partial_match=True
    VerifyText                License
    VerifyText                L-010852
    VerifyField               Account Name    Avignon University    partial_match=True
