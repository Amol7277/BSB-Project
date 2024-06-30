*** Settings ***
Library     SeleniumLibrary
Resource    Login/login.robot


*** Variables ***
${URL}      https://testing.bsbtest.com/default.aspx?portalid=1309
${browser}      chrome
${ID}       itw.amols+superadmin@gmail.com
${Pwd}      Test@1234

*** Test Cases ***
Step One
    mouse over    //ul/li/a/span[contains(text(), "Registration")]
    click element    //ul/li/a/span[contains(text(), "Registration Forms")]


*** Keywords ***
