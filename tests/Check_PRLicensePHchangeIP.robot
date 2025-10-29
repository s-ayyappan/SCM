# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Check PR License change for PH
    [tags]                    Sources
    [Documentation]           Existing active PR license status to be changed to Inactive automatically when there is a PH change at the Source level             
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Sources
    TypeText                  Search this list...    T-15425\n    anchor=Account Manager, Content Provider, and Created Date aren't searchable. Use filters or sort on these fields instead.
    ClickText                 T-15425

#check the source link status

    ClickText     Related
    VerifyText    Source Links
    ClickText     SL-000410
    VerifyText    Inactive
    ClickText     T-15425    anchor=Related
    HoverText     Title Details
    ClickText     Department of Science and Aerospacial Technology
    VerifyText    PRM Account
    ClickText     Edit PRM Account  

    VerifyText    Billing Street
    VerifyText    Address Search
    VerifyText    PRM Account
    ClickCheckbox    PRM Account    on
    ClickText    Save

    ClickText     Related
    ClickText     Details
    ClickText     Department of Science and Aerospacial Technology    anchor=Departamento de Ciencia e Tecnologia Aeroespacial
    ClickText     Edit PRM Account
    ScrollText    Recent Items
    VerifyText    PRM Account
    ClickCheckbox    PRM Account    off
    ClickText    Save


