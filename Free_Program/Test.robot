*** Settings ***
Library         SeleniumLibrary
Resource        Resource.robot
Test Setup      Open the Browser & Open the Portal URL      ${Portal_URL}     ${Browser}


*** Test Cases ***
Free Program Creation
#    Open the Browser & Open the Portal URL      ${Portal_URL}     ${Browser}
    Login in the Portal     ${U_Name}       ${Pwd}
    Go to the Regitration forms
    Edit the program and go to registation question

*** Keywords ***
Open the Browser & Open the Portal URL
    [Arguments]         ${Portal_URL}     ${Browser}
    Open Browser                    ${Portal_URL}     ${Browser}
    maximize browser window

Login in the Portal
    [Arguments]    ${UserName}      ${Password}
    click element                   ID:dnn_dnnLOGIN_cmdLogin
    wait until element is visible       email
    input text                      Name:email                      ${UserName}
    click element                   Name:continue
    wait until element is visible       password
    input password                  Name:password                   ${Password}
    click element                   Name:continue

Go to the Regitration forms
    wait until element is visible       //a/img[@class='logo-img']          300
    mouse over                          //a/span[contains(text(),'Registration')]
    click element                       //a/span[contains(text(),'Registration Forms')]

Edit the program and go to registation question
    sleep       3
    click element                       //span/mat-icon[contains(text(),'edit')]
    sleep       1
    click element                       //button[contains(text(),'Registration Questions ')]
    sleep       2
    click element                       //div[contains(text(),'Discounts & Fees')]
    sleep       2
    click element                       //mat-dialog-actions/button/span[contains(text(),'Continue')]
