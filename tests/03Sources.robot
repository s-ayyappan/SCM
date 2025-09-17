*** Settings ***
Library    QForce
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Sources Tab UI Checks
    [tags]                    Sources
    [Documentation]           Sources tab UI check
    Appstate                  Home
    LaunchApp                 Sources
    Sleep                     2s    

#capture the UI objects in New Sources Modal


    ClickText    Sources List
    ClickText    New Source
    UseModal    On
    ClickText    New
    UseModal    On
    VerifyText    New Source
    VerifyText    Prospect
    VerifyText    Unenriched
    VerifyText    Full
    VerifyText    Cancel    partial_match=False
    ClickText    Next
    VerifyText    New Source: Full
    VerifyText    Title Details
    VerifyText    Title Id
    VerifyText    Paid Source
    VerifyText    Content Provider
    VerifyText    Publisher
    VerifyText    *Title Nam
    VerifyText    Owner
    VerifyText    Content Provider
    VerifyText    License Selection Run Date
    VerifyText    Permission Holder
    VerifyText    OBII Id
    VerifyText    License/SourceLink creation Process
    VerifyText    ECH ID Publisher
    VerifyText    ECH ID Content
    VerifyText    Country
    VerifyText    Enrichment Completed
    VerifyText    Frequency (nr. of issues per year)
    VerifyText    ISSN
    VerifyText    E-ISSN
    VerifyText    Status
    VerifyText    Homepage
    VerifyText    Serial
    VerifyText    Created By
    VerifyText    Elsevier Comments
    VerifyText    Created By
    VerifyText    Last Modified By
    VerifyText    Elsevier Comments
    VerifyText    Homepage
    VerifyText    Validation Completed
    VerifyPickList    Content Set    
    VerifyText    Account Manager
    VerifyText    Frequency (nr. of volumes per year)
    VerifyText    Content Set
    VerifyText    Content Type
    VerifyText    Available
    VerifyText    Chosen
    VerifyText    ISSN & E-ISSN Empty
    VerifyText    Start Year
    VerifyPickList    Type of Title    
    VerifyText    URL to Terms & Condition
    VerifyText    Licensor URL
    VerifyText    First Article Published Cover Da
    VerifyText    Funding Body ID
    VerifyText    Scopus Source Page Url
    VerifyText    Source Id
    VerifyText    Auto License Triggered
    VerifyText     Cancel    partial_match=False
    VerifyText     Save & New
    VerifyText     Save
    UseModal        Off
    


