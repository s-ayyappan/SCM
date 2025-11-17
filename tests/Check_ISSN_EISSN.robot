*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Check ISSN Eissn
    [tags]                    Sources, ISSN, EISSN
    Appstate                  Home
    LaunchApp                 Sources
  
    ClickText    Select a List View
    ClickText    All Titles
    HoverText    All Titles
    TypeText     Search this list...    T-56103\n    anchor=Account Manager, Content Provider, and Created Date aren't searchable. Use filters or sort on these fields instead.
    ClickText    T-56103
    HoverText    Title Details
    ClickText    T-56103
    ScrollText   Audit Fields
    VerifyText   DOAJcheck(ISSN)
    IsText       text='complete'
    VerifyText   DOAJcheck(Eissn)
    IsText       text='complete'
    VerifyText   URLcheck
    IsText       text='complete'
