*** Settings ***
Documentation     Standalone JWT Authentication verification test
Library           QForce

*** Variables ***
${client_id}      3MVG9buXpECUESHhDSM8g0.moaAsr1uNU8R2fLDydXCmvg9KQs.14UjGaYdfb1n1W_4eDFikH_1PI7yzAP3IT
${username1}      s.ayyappan@elsevier.com.scm.uat
${private_key}    ${EXECDIR}/resources/private_key.pem
${login_url}      https://relx-elsevier-operations--uat.sandbox.my.salesforce.com
${home_url}       https://relx-elsevier-operations--uat.sandbox.lightning.force.com/lightning/page/home

*** Test Cases ***
Verify JWT Authentication Works
    OpenBrowser         about:blank    chrome
    SetConfig           DefaultTimeout    60s
    JwtAuthenticate     ${client_id}    ${username1}    ${private_key}
    JwtLogin
    VerifyText          Home
    Log                 JWT Authentication successful for: ${username1}    level=INFO
    TakeScreenshot
    Close All Browsers
