*** Settings ***
Library           QForce
Library           QWeb
Library           DataDriver    reader_class=TestDataApi    name=TestDATA.csv
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End suite


*** Test Cases ***
Check License Template Edit Restrictions
    [tags]                    Licenses
    Appstate                  Home
    Sleep                     1s
    LaunchApp                 Licenses

