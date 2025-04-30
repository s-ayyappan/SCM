*** Settings ***
Library           QForce
Library           QWeb
Resource          ../resources/common.robot
Suite Setup       Setup Browser
Suite Teardown    End suite


*** Test Cases ***
Check License Template Edit Restrictions
    [tags]                    Licenses
    Appstate                  Home
    Sleep                     1s
    LaunchApp                 Licenses

#navigate to a license
    ClickText    Select a List View: Licenses
    ClickText    All
#    HoverText    L-010698
    TypeText     Search this list...    Elsevier b.v\n    anchor=Account, License Template, Version, and Last Refresh Date aren't searchable. Use filters or sort on these fields instead.
    VerifyText   BioOne
    ClickText    L-009111
    VerifyField    License Template    Elsevier License Template    tag=a    partial_match=True
    ClickText      Edit License Template
    VerifyText     License Template     anchor=License Template
    ClickText      Clear Selection       anchor=License Template
    ClickText      Save
    VerifyText     You can't change License Template field value
    ClickText      You can't change License Template field value
    Log            User unable to amend the License template field as expected            
