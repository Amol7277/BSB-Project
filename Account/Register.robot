*** Settings ***
Library     SeleniumLibrary
Test Setup      open the browser and URL

*** Variables ***
${URL}      https://stagingsports.bsbtest.com/default.aspx?portalid=8575
${Browser}      Chrome

${U_Name}       amol.sonar+stg1+0607@stacksports.com
${Pwd}          Test@1234

*** Test Cases ***
Account Creation
    Register the Account and Click Create account

*** Keywords ***
open the browser and URL
    OPEN BROWSER        ${URL}          ${Browser}
    maximize browser window

Register the Account and Click Create account
    click element           dnn_dnnUSER_cmdRegister
    wait until element is visible       Name:email
    input text              Name:email          ${U_Name}
    click element           Name:continue

    wait until element is visible           Name:password
    input password                          Name:password        ${Pwd}
    input password                          Name:passwordConfirm     ${Pwd}
    click element                           Name:continue