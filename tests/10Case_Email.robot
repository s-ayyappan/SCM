*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Check Email in Cases
    [tags]                    Cases
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Cases

#Cases tab opening
    ClickText    Select a List View: Cases
#list all cases
    ClickText    All cases
#search for specific case
    TypeText    Search this list...    0000209
    ClickText    00002094
    ClickText    Related
    ClickText    Robotics Testing Case 
    HoverText    Reply
    HoverText    Forward
    HoverText    Reply All
    HoverText    Delete
#click the reply button and verify the objects
    ClickText    Reply    partial_match=False
    ClickText    Maximize
    VerifyText    To
    VerifyText    Subject
    HoverText    Send
    HoverText    Close
    ClickText    Close    partial_match=False
    Log          Email function objects present as expected 
    