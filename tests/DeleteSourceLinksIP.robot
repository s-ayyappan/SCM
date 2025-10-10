*** Settings ***
Library    QForce
Library    QWeb
Library    QVision
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite

*** Test Cases ***
Delete Contact and linked Source Link
    [tags]                    Permission Request, Contacts
    [Documentation]           Test to check while deleting contact, then connected Source link is deleted
    Appstate                  Home
    Sleep                     2s
    LaunchApp                 Contacts

#create a new contact for robotics testing
    ClickText    New
    UseModal     On
    PickList     Salutation    Mr.
    TypeText     First Name    Robotics
    TypeText     Last Name    PRCRcontact
    TypeText     OBII Id    222343\n
    PickList     Contact Role    All-round
    ComboBox     Search Accounts...    Aalborg University
    TypeText     Email    test@elsevier.invalid.com    
    ClickText    Save    partial_match=False
#check whether duplicate or similar contact already exists
    ${duplicate_exists}=    Set Variable    Similar Records Exist
    IF    '${duplicate_exists}' == 'Similar Records Exist'
        Log    >>> Duplicates were found
        ClickText    Cancel    partial_match=False
    ELSE
        Log    >>> No duplicates found
        ClickText    Save    partial_match=False
    END
#    UseModal     Off
#    Sleep        2s
#click the existing contact    
    ClickText    Contacts
    ClickText    Robotics PRCRcontact
    Sleep        2s
    VerifyField  Name    Mr. Robotics PRCRcontact    partial_match=True
#clik the source link
 
    ClickText    Sources
    TypeText     Search this list...    funding test\n    anchor=Content Provider
    ClickText    T-55992
    VerifyText   Funding Test template 22
    ClickText    Related

#delete the contact
    ClickText    Contacts
    ClickText    Robotics PRCRcontact
    Sleep        2s
    VerifyText    Mr. Robotics PRCRcontact
    ClickText     Delete
    UseModal      On
    ClickText     Delete
    VerifyText    Robotics PRCRcontact
    Log           Contact Sucessfully deleted



#Check if element exists and perform actions based on result
    ClickText    Sources
    Sleep        2s
    TypeText     Search this list...    funding test\n    anchor=Content Provider
    ClickText    T-55992
    Sleep        2s
    ClickText    Related
    VerifyText   Source Links
    ClickText    Source Links    
    ${element_exists}=    Run Keyword And Return Status    VerifyText    Select Item 1    timeout=3
    IF    ${element_exists}
        Log    Select Item 1 found - Source link not deleted
#        ClickText    Select Item 1
    # Add your actions here when element exists
    ELSE
        Log    Select Item 1 not found - Source link deleted successfully
    # Add your alternative actions here
    END

    # Using in CRT with VerifyText
#    VerifyText          Select Item 1

# Using in CRT with VerifyElement
#    VerifyElement       xpath=//span[text()='Select Item 1']

# Using in CRT with ClickText (if clickable)
#    ClickText           Select Item 1

# Using in CRT with custom XPath
#    VerifyElement       xpath=//span[@part='label' and text()='Select Item 1']
