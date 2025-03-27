*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Check Content Delivery Task
    [tags]                    Permission Request
    Appstate                  Home
    LaunchApp                 Permission Requests

    ClickText    Select a List View: Permission Requests
    ClickText    All Permission Requests
    HoverText    Show Actions
#    TypeText     Search this list...    PR-00036740\n    anchor=Clear
#    ClickText    PR-00036740
#    VerifyText   PR-00036740
