*** Settings ***
Library    QForce
Library    String
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Variables ***
${WAIT_SHORT}            2s
${SOURCE_TITLE}          CRT Test Source  
${LICENSE}               L-005128 
${SOURCE}                T-56248
${SOURCE_LINK_ID}        SL-015805
${RIGHTS_PERMISSION}     RP-005082
${ACCOUNT_NAME}          Medicina Oral


*** Test Cases ***
Check Source to License Child records
    [tags]                    Sources, PR, Source Links
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Sources
    
#navigate to the source
    
    ClickText                 Select a List View: Sources
    ClickText                 All Titles
    TypeText                  Search this list...    ${SOURCE_TITLE}\n    anchor=Account Manager, Created Date, and Content Provider aren't searchable. Use filters or sort on these fields instead.
    VerifyText                CRT Test Source
    ClickText                 ${SOURCE} 
    ClickText                 Related
    #ClickText                 PR-00025183
    #VerifyText                License
    #VerifyText                L-010852
    ClickText                 Related
    SwipeDown
    VerifyText                Source Links
    ClickText                 ${SOURCE_LINK_ID}	
    VerifyText                Source Link
    VerifyText                ${SOURCE_LINK_ID}
    ClickFieldValue           Right and Permission
    VerifyText                Right and Permission
    VerifyText                ${RIGHTS_PERMISSION}
    VerifyField               License    ${LICENSE}   tag=a    partial_match=True
    ClickFieldValue           License
    VerifyField               License Template   Elsevier Permission Form Template    tag=a    partial_match=True
    VerifyText                License
    VerifyText                ${LICENSE}
    VerifyField               Account Name    ${ACCOUNT_NAME}    partial_match=True
