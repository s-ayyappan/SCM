*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***
Tasks tab UI check
    [tags]                    Tasks
    [Documentation]           Test to check the UI compoents in Tasks tab
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Tasks

    ClickText    Select a List View: Tasks
    ClickText    All Open Tasks

    ClickText     Tasks List
    ClickText     New Task
    UseModal      On
    VerifyText    New Task
    VerifyText    Task Information
    VerifyText    Task Number
    VerifyText    Subject
    VerifyText    Due Date
    VerifyText    Assigned To
    VerifyText    Related To
#    ClickText    Assigned To*
#    VerifyText    Related To*
    VerifyText    Total Task
    VerifyText    Saved Email
    VerifyText    Pick an object
    VerifyText    Name
    VerifyText    Category    
    VerifyText    SBF Correction Required
    VerifyText    Sub Category   
    VerifyText    OBII Correction Required
    VerifyText    Product Approval   
    VerifyText    Comments
    VerifyText    Additional Information
    VerifyText    Priority    
    VerifyText    Start Dat
    VerifyText    Status  
    VerifyText    Completed Date
    VerifyText    Other Information
    VerifyText    Reminder Set
    VerifyText    Create Recurring Series of Tasks
    VerifyText    Save & New
    VerifyText    Cancel
    VerifyText    Save
    ClickText     Cancel and close
    UseModal      Off
    VerifyText    Task Complete
