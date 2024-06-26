*** Settings ***
Library     SeleniumLibrary
Test Setup      Open the browser and open the URL
Resource        Resource1.robot

*** Variables ***
#${URL}      https://stagingsports.bsbtest.com/default.aspx?portalid=8575
#${browser}      chrome
#${ID}       amol.sonar+superadmin@stacksports.com
#${Pwd}      Test@1234
#
#${prg_name}     01_06_TC
#
#${div}      PPT Div
#${amt}      10000
#${regstartdate}     06/01/2024
#${regclosedate}     06/25/2024
#${seasonstart}      06/10/2024
#${seasonend}        07/10/2024
#${oldage}           1/1/2000
#${youngdate}        1/1/2015

${Division_title}       //button/span[contains(text(),' Add Division ')]
${BUTTON}               //button/span[contains(text(), "Save & Continue")]

*** Test Cases ***
TeamCoach Program Creation
    Login into the Portal
    Open the registration form
    Create the TeamCoach Program and Complete the 1st step
    Create Division 1   ${Div1_Name}    ${Div1_Price}   ${Div1_reg_startdate}   ${Div1_reg_closedate}   ${Div1_seasonstart}
    ...     ${Div1_seasonend}   ${Div1_oldage}      ${Div1_youngdate}
    Division 1 Advance setting      ${EarlyBirth_Date}      ${LateFee_Date}
    Click on the advanve button for the division 1 & Add custom disocunt
    Add custom fee for the Division 1
    Add Mandatory fee for the Division 1
    Create Division 2    ${Div2_Name}    ${Div1_Price}   ${Div1_reg_startdate}   ${Div1_reg_closedate}   ${Div1_seasonstart}
    ...     ${Div1_seasonend}   ${Div1_oldage}      ${Div1_youngdate}
    Division 2 Advance Settings
    Create Division 3    ${Div3_Name}    ${Div1_Price}   ${Div1_reg_startdate}   ${Div1_reg_closedate}   ${Div1_seasonstart}
    ...     ${Div1_seasonend}   ${Div1_oldage}      ${Div1_youngdate}
    Registration Questions
    Fees & Discount
    Team Staff Setup    ${CustomPos_Name}
    Confirmation Note

*** Keywords ***
Open the browser and open the URL
    open browser    ${URL}      ${browser}
    maximize browser window

Login into the Portal
    click element                                id:dnn_dnnLOGIN_cmdLogin
    wait until element is visible                name:email
    input text                                   name:email      ${ID}
    sleep   2
    click element                                name:continue
    wait until element is visible                name:password      10
    input text                                   name:password     ${Pwd}
    sleep   2
    click element                                name:continue

Open the registration form
    wait until element is visible                //ul/li/a/span[contains(text(), "Registration")]    300
    sleep       2
    mouse over                                   //ul/li/a/span[contains(text(), "Registration")]
    click element                                //ul/li/a/span[contains(text(), "Registration Forms")]

Create the TeamCoach Program and Complete the 1st step
    wait until element is visible                //button/span[contains(text(), " Add Program ")]   20
    click element                                //button/span[contains(text(), " Add Program ")]
    wait until element is visible               (//button/span[contains(text(), " Select")])[1]
    scroll element into view                    (//button/span[contains(text(), " Select")])[3]
    sleep    1
    click element                               (//button/span[contains(text(), " Select")])[3]
#    wait until element is visible    //li/button/img[@alt='Basketball']     10
#    click element    //li/button/img[@alt='Basketball']
    wait until element is visible                //li/button/img[@alt='${Activity}']     10
    click element                                //li/button/img[@alt='${Activity}']
    click element                                //button/span[contains(text(), " Save & Continue")]
    set selenium page load timeout    30
    sleep   2
    input text                                   //div/input[@id = 'mat-input-0']    ${prg_name}
    sleep   2
    click element                                //div/mat-select[@formcontrolname='ngbCtrl']
    sleep   1
    click element                                //div/mat-option/span[contains(text(), "USSSA")]
    sleep    1
    execute javascript                           window.scrollTo(0,500)
    sleep   2
    wait until element is visible                //button/span[contains(text(), " Save & Continue ")]
    double click element                         //button/span[contains(text(), " Save & Continue ")]
    sleep    3
    ${element_present}    Run Keyword And Return Status    page should contain element      ${Division_title}
#    ${element_present}    Run Keyword And Return Status    element should be focused      ${Division_title}
    sleep    3
    Run Keyword If    ${element_present}=='False'    Click Element    ${BUTTON}


Create Division 1
    [Arguments]    ${D_Name}    ${D_Price}    ${Div_reg_startdate}      ${Div_reg_closedate}    ${Div_seasonstart}
    ...     ${Div_seasonend}    ${Div_oldage}   ${Div_youngdate}
#    go to   https://registration-setup-site-stage.bsbtest.com/registration-admin/8575/program/130096348/2
    wait until element is visible                //button/span[contains(text(),' Add Division ')]    30
    click element                                //button/span[contains(text(),' Add Division ')]
    wait until element is visible                //div/input[@formcontrolname='nameCtrl']
    input text                                   //div/input[@formcontrolname='nameCtrl']    ${D_Name}
    input text                                   //div/input[@formcontrolname='priceCtrl']    ${D_Price}
#Gender selection
    click element                                //div/mat-select[@formcontrolname='genderCtrl']
    click element                                //div/mat-option[@value='C']

    input text                                   //div/input[@formcontrolname='openDateCtrl']      ${Div_reg_startdate}
    double click element                         //div/input[@formcontrolname='openDateCtrl']
    sleep   1

    input text                                   //div/input[@formcontrolname='closeDateCtrl']      ${Div_reg_closedate}
    double click element                         //div/input[@formcontrolname='closeDateCtrl']
    sleep   1

    input text                                   //div/input[@formcontrolname='startDateCtrl']      ${Div_seasonstart}
    double click element                         //div/input[@formcontrolname='startDateCtrl']
    sleep   1

    input text                                   //div/input[@formcontrolname='endDateCtrl']      ${Div_seasonend}
    double click element                         //div/input[@formcontrolname='endDateCtrl']
    sleep   1

    input text                                   //div/input[@formcontrolname='ageStartCtrl']      ${Div_oldage}
    double click element                         //div/input[@formcontrolname='ageStartCtrl']
    sleep   1

    input text                                   //div/input[@formcontrolname='ageEndCtrl']      ${Div_youngdate}
    double click element                         //div/input[@formcontrolname='ageEndCtrl']

    sleep    1
    double click element                         //h3/span[contains(text(), "Age Range")]
    sleep    1
    double click element                         //div/h3[contains(text(), "Season Dates")]
    sleep    1
#    execute javascript                           window.scrollTo(0,-100)
    sleep    1
    click element                                 //button[@iconclass='save-icon']
#    click element                                //button[@type="submit"]

Division 1 Advance setting
    [Arguments]    ${Earlybirth_Date}   ${Latefee_Date}
    sleep   3
    wait until element is visible                (//button/span/span[contains(text(),"Advanced")])[1]     30
#    DIvision Advanced setting
    click element                                (//button/span/span[contains(text(),"Advanced")])[1]
    sleep   2
#    Division level fee & Discount
    wait until element is visible                //div/div/span[contains(text(),"Discounts & Fees")]        20
    click element                                //div/div/span[contains(text(),"Discounts & Fees")]

#    earlybird amount
    wait until element is visible                //div/input[@formcontrolname='earlyBirdDiscountAmountCtrl']     20
    input text                                   //div/input[@formcontrolname='earlyBirdDiscountAmountCtrl']     1000

#    earlybird date
    wait until element is visible                //div/input[@formcontrolname='earlyBirdDiscountEndDateCtrl']       10
    double click element                         //div/input[@formcontrolname='earlyBirdDiscountEndDateCtrl']
    input text                                   //div/input[@formcontrolname='earlyBirdDiscountEndDateCtrl']     ${Earlybirth_Date}

#    Late free amount
    wait until element is visible                //div/input[@formcontrolname='lateFeeAmountCtrl']       10
    input text                                   //div/input[@formcontrolname='lateFeeAmountCtrl']     1000

#    Late Fee Date
    wait until element is visible                //div/input[@formcontrolname='lateFeeStartDateCtrl']     10
    double click element                         //div/input[@formcontrolname='lateFeeStartDateCtrl']
    input text                                   //div/input[@formcontrolname='lateFeeStartDateCtrl']     ${Latefee_Date}

    wait until element is visible                //button[@id='divisionSave']
    click element                                //button[@id='divisionSave']
    sleep      3
#    execute javascript                           window.scrollTo(0,-100)
#    sleep      1
#    click element                                //button/span/mat-icon[contains(text(),"clear")]
#    sleep    2

Click on the advanve button for the division 1 & Add custom disocunt
    wait until element is visible                (//button/span/span[contains(text(),'Advanced')])[1]     10
    sleep       1
    click element                                (//button/span/span[contains(text(),'Advanced')])[1]
    sleep       1
    click element                                 //div/span[contains(text(),'Discounts & Fees')]
    sleep       1
    click element                                 //button/span[contains(text(),'Add Custom Discount Or Fee Question')]
    sleep       1
    click element                                 //button[contains(text(),'Discount')]
    sleep       1
    input text                                    //div/input[@formcontrolname='prompt']    DD1
    sleep       2
    input text                                    (//div/input[@formcontrolname='amount'])    1000
    sleep       2
    input text                                     //div/input[@formcontrolname='name']      DD1
    sleep       1
    click element                                 (//*[@formcontrolname='applyOnOption']/mat-radio-button/label)[1]
    sleep       1
    click element                                 (//button[@iconclass='save-icon']/span)[1]

Add custom fee for the Division 1
    sleep       2
    click element                                  //button/span[contains(text(),'Add Custom Discount Or Fee Question')]
    sleep       1
    click element                                  //button[contains(text(),'Fee')]
    sleep       1
    input text                                     //div/input[@formcontrolname='prompt']    DF
    sleep       2
    input text                                     (//div/input[@formcontrolname='amount'])[2]    1000
    sleep       2
    input text                                      //div/input[@formcontrolname='name']      DF
    sleep       1
#    click element         (//*[@formcontrolname='applyOnOption']/mat-radio-button/label)[1]
#    sleep       1
    click element                                  (//button[@iconclass='save-icon']/span)[1]

Add Mandatory fee for the Division 1
    sleep       2
    click element                                   //button/span[contains(text(),'Add Custom Discount Or Fee Question')]
    sleep       1
    click element                                   //button[contains(text(),' Mandatory Fee ')]
    sleep       1
    input text                                      //div/input[@formcontrolname='prompt']    MDF
    sleep       2
    input text                                     (//div/input[@formcontrolname='amount'])[3]    1000
    sleep       2
    input text                                      //div/input[@formcontrolname='name']      DMF
    sleep       1
    click element                                  (//button[@iconclass='save-icon']/span)[1]
    sleep       1
    click element                                   //button/span/span[contains(text(),'Save')]
    sleep    1
    execute javascript                              window.scrollTo(0, -200)
    sleep    2
    click element                                   //button/span/mat-icon[contains(text(),'clear')]

Create Division 2
    [Arguments]    ${D_Name}    ${D_Price}    ${Div_reg_startdate}      ${Div_reg_closedate}    ${Div_seasonstart}
    ...     ${Div_seasonend}    ${Div_oldage}   ${Div_youngdate}
#    go to   https://registration-setup-site-stage.bsbtest.com/registration-admin/8575/program/130096348/2
    wait until element is visible                   //button/span[contains(text(),' Add Division ')]    30
    click element                                   //button/span[contains(text(),' Add Division ')]
    wait until element is visible                   //div/input[@formcontrolname='nameCtrl']       10
    input text                                      //div/input[@formcontrolname='nameCtrl']    ${D_Name}
    input text                                      //div/input[@formcontrolname='priceCtrl']    ${D_Price}
#Gender selection
    click element                                   //div/mat-select[@formcontrolname='genderCtrl']
    click element                                   //div/mat-option[@value='C']
    execute javascript                              window.scrollTo(0,200)
    sleep       1
    click element                                   (//div[@class='mat-radio-container'])[2]
    sleep       1
    input text                                      //div/input[@formcontrolname='openDateCtrl']      ${Div_reg_startdate}
    sleep   1
    double click element                            //div/input[@formcontrolname='openDateCtrl']
    sleep   1

    input text                                      //div/input[@formcontrolname='closeDateCtrl']      ${Div_reg_closedate}
    sleep   1
    double click element                            //div/input[@formcontrolname='closeDateCtrl']
    sleep   1

    input text                                      //div/input[@formcontrolname='startDateCtrl']      ${Div_seasonstart}
    double click element                            //div/input[@formcontrolname='startDateCtrl']
    sleep   1

    input text                                      //div/input[@formcontrolname='endDateCtrl']      ${Div_seasonend}
    double click element                            //div/input[@formcontrolname='endDateCtrl']
    sleep   1

    input text                                      //div/input[@formcontrolname='ageStartCtrl']      ${Div_oldage}
    double click element                            //div/input[@formcontrolname='ageStartCtrl']
    sleep   1

    input text                                      //div/input[@formcontrolname='ageEndCtrl']      ${Div_youngdate}
    double click element                            //div/input[@formcontrolname='ageEndCtrl']
    sleep    1
    double click element                            //h3/span[contains(text(), "Age Range")]
    Log     Clicked
    sleep    1
    double click element                            //div/h3[contains(text(), "Season Dates")]
    sleep    1
    Log     Clicked
#    execute javascript                             window.scrollTo(0,-100)
#    sleep    1
#    scroll element into view                       //button[@iconclass='done-icon']
#    click element                                  //button[@iconclass='done-icon']
    click element                                   //button[@iconclass='save-icon']
#    click element                                  //button[@type="submit"]

Division 2 Advance Settings
    sleep   2
    wait until element is visible                   (//button/span/span[contains(text(),"Advanced")])[2]     30
#    DIvision Advanced setting
    click element                                   (//button/span/span[contains(text(),"Advanced")])[2]
    sleep    3
    execute javascript                              window.scrollTo(0,100)
#    scroll element into view                     (//div[@class='mat-radio-container'])[2]
    sleep    2
    click element                                   (//div[@class='mat-radio-container'])[2]
    sleep    3
    execute javascript                              window.scrollTo(0,-100)
#Payment Options
    sleep   1
    click element                                   //div/span[contains(text(),'Payment Options')]
    wait until element is visible                   (//div[@class='mat-radio-container'])[1]
    click element                                   (//div[@class='mat-radio-container'])[1]
    sleep    1
    input text                                      //div/input[@formcontrolname='depositAmountCtrl']      5000

    wait until element is visible                   //button[@id='divisionSave']
    click element                                   //button[@id='divisionSave']
    sleep      2
    execute javascript                              window.scrollTo(0,-100)
    sleep      1
    click element                                   //button/span/mat-icon[contains(text(),"clear")]
    sleep     2

Create Division 3
    [Arguments]    ${D_Name}    ${D_Price}    ${Div_reg_startdate}      ${Div_reg_closedate}    ${Div_seasonstart}
    ...     ${Div_seasonend}    ${Div_oldage}   ${Div_youngdate}
#    go to   https://registration-setup-site-stage.bsbtest.com/registration-admin/8575/program/130096348/2
    wait until element is visible                   //button/span[contains(text(),' Add Division ')]    30
    click element                                   //button/span[contains(text(),' Add Division ')]
    wait until element is visible                   //div/input[@formcontrolname='nameCtrl']       10
    input text                                      //div/input[@formcontrolname='nameCtrl']    ${D_Name}
    input text                                      //div/input[@formcontrolname='priceCtrl']    ${D_Price}
#Gender selection
    click element                                   //div/mat-select[@formcontrolname='genderCtrl']
    click element                                   //div/mat-option[@value='C']
    execute javascript                              window.scrollTo(0,200)
    sleep       1
    click element                                   (//div[@class='mat-radio-container'])[2]
    sleep       1
    input text                                      //div/input[@formcontrolname='openDateCtrl']      ${Div_reg_startdate}
    sleep   1
    double click element                            //div/input[@formcontrolname='openDateCtrl']
    sleep   1

    input text                                      //div/input[@formcontrolname='closeDateCtrl']      ${Div_reg_closedate}
    sleep   1
    double click element                            //div/input[@formcontrolname='closeDateCtrl']
    sleep   1

    input text                                      //div/input[@formcontrolname='startDateCtrl']      ${Div_seasonstart}
    double click element                            //div/input[@formcontrolname='startDateCtrl']
    sleep   1

    input text                                      //div/input[@formcontrolname='endDateCtrl']      ${Div_seasonend}
    double click element                            //div/input[@formcontrolname='endDateCtrl']
    sleep   1

    input text                                      //div/input[@formcontrolname='ageStartCtrl']      ${Div_oldage}
    double click element                            //div/input[@formcontrolname='ageStartCtrl']
    sleep   1

    input text                                      //div/input[@formcontrolname='ageEndCtrl']      ${Div_youngdate}
    double click element                            //div/input[@formcontrolname='ageEndCtrl']
    sleep    1
    double click element                            //h3/span[contains(text(), "Age Range")]
    Log     Clicked
    sleep    1
    double click element                            //div/h3[contains(text(), "Season Dates")]
    sleep    1
    Log     Clicked
#    execute javascript                             window.scrollTo(0,-100)
#    sleep    1
#    scroll element into view                       //button[@iconclass='done-icon']
#    click element                                  //button[@iconclass='done-icon']
#    click element                                  //button[@iconclass='save-icon']
#    click element                                  //button[@type="submit"]
    wait until element is visible                   //button/span[contains(text(), " Save & Continue ")]    10
    sleep    3
    click element                                   //button/span[contains(text(), " Save & Continue ")]

Registration Questions
    sleep   7
#    wait until element is visible                  (//button/span[contains(text(), " Save & Continue ")])[2]   10
    wait until element is visible                   (//div[@class='tshq-program-wizard-nav']/button/span)[2]   10
#    click element                                  //div[@class='edit-program-questions']/tshq-program-wizard-nav/div/div/button/span
#    click element                                  (//button/span[contains(text(), " Save & Continue ")])[2]
    click element                                   (//div[@class='tshq-program-wizard-nav']/button/span)[2]

Fees & Discount
    sleep   2
    wait until element is visible                   //div/input[@formcontrolname='secondParticipantDiscountCtrl']      10

    input text                                      //div/input[@formcontrolname='secondParticipantDiscountCtrl']      1000
    input text                                      //div/input[@formcontrolname='thirdParticipantDiscountCtrl']      1000
    input text                                      //div/input[@formcontrolname='fourthParticipantDiscountCtrl']      1000
    input text                                      //div/input[@formcontrolname='subsequentParticipantDiscountCtrl']      1000

    sleep     1
    input text                                      //div/input[@formcontrolname='volumeDiscountCtrl']     1000

    sleep     1
    click element                                   (//label/div[@class='mat-radio-container'])[2]

    sleep    1
    input text                                      //div/input[@formcontrolname='residentDiscountFeeAmount']     1000

#    scroll element into view                       (//button/span[contains(text(), " Save & Continue ")])[3]
    scroll element into view                        (//div[@class='tshq-program-wizard-nav']/button/span)[3]
    sleep     1
#    click element                                  (//button/span[contains(text(), " Save & Continue ")])[3]
    click element                                   (//div[@class='tshq-program-wizard-nav']/button/span)[3]

Team Staff Setup
    [Arguments]    ${Cpos_Name}
    wait until element is visible                   //button/span[contains(text(),' Add Team Staff Position ')]    10
    click element                                   //button/span[contains(text(),' Add Team Staff Position ')]
    click element                                   //div/button[contains(text(),'Available Position')]

#    standard position selection
    wait until element is visible                   //label[@class='mat-checkbox-layout']
    click element                                   (//label[@class='mat-checkbox-layout'])[3]
    click element                                   (//label[@class='mat-checkbox-layout'])[4]
    scroll element into view                        //*[@id="select-team-personnel"]/tshq-program-wizard-nav/div/div/button/span
    sleep    1
    click element                                   //*[@id="select-team-personnel"]/tshq-program-wizard-nav/div/div/button/span

#   Custom position Add
    wait until element is visible                   //button/span[contains(text(),' Add Team Staff Position ')]    10
    click element                                   //button/span[contains(text(),' Add Team Staff Position ')]
    sleep       2
    click element                                   //div/button[contains(text(),'Custom Position')]

    wait until element is visible                   //div/input[@formcontrolname='roleName']       20
    input text                                      //div/input[@formcontrolname='roleName']       ${Cpos_Name}
    sleep     1
    input text                                      //div/input[@formcontrolname='roleDescription']    it's custom position
    sleep     1
    input text                                      //div/input[@formcontrolname='displayName']     ${Cpos_Name}
    sleep     1
    click element                                   (//div[@class='tshq-program-wizard-nav']/button/span)[4]
#    click element                                  //*[@class="edit-team-personnel"]/div/div/div[2]/tshq-program-wizard-nav/div/div/button/span
    sleep   3
    execute javascript                              window.scrollTo(0,document.body.scrollHeight)
    sleep     2
    wait until element is visible                   (//div[@class='tshq-program-wizard-nav']/button/span)[4]      10
    click element                                   (//div[@class='tshq-program-wizard-nav']/button/span)[4]
    sleep     2

    wait until element is visible                   (//button/span[contains(text(), " Save & Continue ")])[4]       20
#    wait until element is visible                  (//div[@class='tshq-program-wizard-nav']/button/span)[4]       20
    sleep   2
    click element                                   (//button/span[contains(text(), " Save & Continue ")])[4]
#    click element                                  (//div[@class='tshq-program-wizard-nav']/button/span)[4]

Confirmation Note
    sleep    2
    execute javascript                              window.scrollTo(0,document.body.scrollHeight)
    sleep    2
    wait until element is visible                   //button/span[contains(text(), " Save & Finish ")]       10
    click element                                   //button/span[contains(text(), " Save & Finish ")]


