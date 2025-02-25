# NOTE: readme.txt contains important information you need to take into account
# before running this suite.

*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Check ISSN Eissn
    [tags]                    Sources
    Appstate                  Home
    LaunchApp                 Sources
  
    ClickText    Select a List View
    ClickText    All Titles
    HoverText    All Titles
    TypeText     Search this list...    T-00006\n    anchor=Account Manager, Content Provider, and Created Date aren't searchable. Use filters or sort on these fields instead.
    ClickText    T-00006
    HoverText    Title Details
    ClickText    T-00006
    ScrollText   Audit Fields
    VerifyText   DOAJcheck(ISSN)
    IsText       text='complete'
    VerifyText   DOAJcheck(Eissn)
    IsText       text='waiting for results(ISSN)'
    VerifyText   URLcheck
    IsText       text='complete'
