*** Settings ***
Library    QForce
Library    QVision
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Create New Obligation in PR
    [tags]                    Permission Request
    [Documentation]           Test to check PRCR under Permission Request is loading as normal
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Permission Requests

    ClickText    Select a List View: Permission Requests
    ClickText    All Permission Requests
    HoverText    Show Actions
    TypeText     Search this list...    PR-00024512\n    anchor=Clear
    Sleep        2s
    ClickText    PR-00024512
    VerifyText   PR-00024512
    ClickText    Related
    Sleep        2s

#Create new Obligation for the PR
    SwipeDown
    VerifyText    Obligations
    ClickText     Obligations 
    VerifyText    New                  
    ClickText     New    
    UseModal      On
#    ComboBox      Search Rights and Permissions...    RP-010166
    PickList      Type    Attribution
    PickList      Status    Pending
    ClickText     Save    partial_match=False
    UseModal      Off
    Sleep        2s
    ClickText    PR-00024512
    ClickText    Related
    
   
      
#Navigate to the obligations thru the license->RP->obligations
    ClickText    L-010380
    ClickText    Rights and Permissions (1)
    ClickText    RP-010166
    ClickText    Obligations                        

#Select the last created obligations using hotkeys and delete
    VerifyText    New
# First verify that checkbox is not present using Is Text
    ${exists}=         Is Text          Select Item 5    timeout=2
    IF  ${exists}
        ClickCheckbox    Select Item 5    on    partial_match=False
        HotKey       Tab
        ClickText    O                  anchor=Select Item 5
    ELSE            
        Log  Checkbox not found, skipping this step
    END




    ${exists}=         Is Text          Select Item 5    timeout=2
    Run Keyword If     ${exists}        ClickCheckbox    Select Item 5    on    partial_match=False
                #HotKey       Tab
                ClickText    O                  anchor=Select Item 5
            ELSE   
                Log  Checkbox not found, skipping this step   
                

# Verify the checkbox does not exist (exists should be False)
    Should Not Be True    ${exists}    msg=Checkbox 'Select Item 5' was not found
    ClickCheckbox    Select Item 5    on    partial_match=False
    HotKey       Tab
    ClickText    O                  anchor=Select Item 5

    Log                   PRCR successfully deleted

    HotKey       Enter 
    ClickText    Delete
    UseModal     On
    ClickText    Delete
