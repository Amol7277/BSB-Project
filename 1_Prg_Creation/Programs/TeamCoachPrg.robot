*** Settings ***
Library     SeleniumLibrary
Library     DateTime
#Resource        ../1_Resource/Resource_TeamCoachPrg.robot
Resource        ../1_Resource/Resource_All_Prg.robot
Test Setup      Open the browser and open the URL
#Test Teardown    Close Browser

*** Variables ***

${Division_title}       //button/span[contains(text(),' Add Division ')]
${BUTTON}               //button/span[contains(text(), "Save & Continue")]

*** Test Cases ***
TeamCoach Program Creation
    ${Current_Date_Time}       get current date                                   exclude_millis=yes

    ${current_date}            get current date                                   result_format=%Y-%m-%d
    ${Div_regi_startdate}=     Add Time To Date     ${current_date}    -3 days    result_format=%m-%d-%Y
    ${Div_regi_closedate}=     Add Time To Date     ${current_date}    30 days    result_format=%m-%d-%Y
    ${Div_SeasonStart}=        Add Time To Date     ${current_date}    2 days     result_format=%m-%d-%Y
    ${Div_SeasonEnd}=          Add Time To Date     ${current_date}    45 days    result_format=%m-%d-%Y
    ${EarlyBird_Date}=         Add Time To Date     ${current_date}    5 days     result_format=%m-%d-%Y
    ${LateFee_Date}=           Add Time To Date     ${current_date}    -2 days    result_format=%m-%d-%Y

#Payment Plan Dates
    ${EMI-1 Date}=                  Add Time To Date     ${current_date}    30 days    result_format=%m-%d-%Y
    ${EMI-2 Date}=                  Add Time To Date     ${current_date}    60 days    result_format=%m-%d-%Y
    ${EMI-3 Date}=                  Add Time To Date     ${current_date}    90 days    result_format=%m-%d-%Y

    Handle One Trust Popup
    Login in the Portal     ${User_ID}       ${Pwd}
    Open the registration form
    Create the TeamCoach Program and Complete the 1st step      ${TC_Program_Name}${Current_Date_Time}
    Create Division 1   ${TC_Div1_Name}    ${Div_Price}   ${Div_regi_startdate}   ${Div_regi_closedate}   ${Div_seasonstart}
    ...     ${Div_seasonend}   ${OldDate}      ${YoungDate}

    Division 1 Advance setting      ${EarlyBird_DD}     ${EarlyBird_Date}   ${DL-Dis}   ${DL-Fee}   ${DL-MFee}
    ...     ${Deposit}      ${EMI-1 Date}   ${EMI-1}    ${installmentFee}
    ...     ${EMI-2 Date}   ${EMI-2}    ${EMI-3 Date}   ${EMI-3}

    Create Division 2    ${TC_Div2_Name}    ${Div_Price}   ${Div_regi_startdate}   ${Div_regi_closedate}   ${Div_seasonstart}
    ...     ${Div_seasonend}   ${OldDate}      ${YoungDate}

    Division 2 Advance Settings     ${LateFee_DF}    ${LateFee_Date}    ${Deposit}
    ...             ${EMI-1 Date}   ${EMI-1}    ${installmentFee}
    ...             ${EMI-2 Date}   ${EMI-2}    ${EMI-3 Date}   ${EMI-3}

    Create Division 3    ${TC_Div3_Name}    ${Div_Price}   ${Div_regi_startdate}   ${Div_regi_closedate}   ${Div_seasonstart}
    ...     ${Div_seasonend}   ${OldDate}      ${YoungDate}

    Division 3 Advance Settings     ${EMI-1 Date}     ${EMI-2 Date}      ${EMI-3 Date}
    Registration Questions
    Fees & Discount     ${FamilyDis}     ${VolumeDis}      ${ResidentDis}
    Add Program level fee & discount        ${PL-Dis}    ${PL-Fee}   ${PL-MFee}
    Team Staff Setup    ${Vol_Name}
    Confirmation Note

*** Keywords ***
Open the registration form
    set selenium implicit wait            10
    set selenium speed                    0.4

    ${Status}   run keyword and return status       page should contain element      //ul/li/a/span[contains(text(), "Registration")]
    log to console      ${Status}
    sleep       3
    Run Keyword If      ${Status}=='False'          reload page
    wait until element is visible         //ul/li/a/span[contains(text(), "Registration")]    200
    run keyword and continue on failure     wait until element is visible         //marketplace-toolbar[@class='hydrated']      100

    mouse over                            //ul/li/a/span[contains(text(), "Registration")]
    click element                         //ul/li/a/span[contains(text(), "Registration Forms")]

Create the TeamCoach Program and Complete the 1st step
    [Arguments]     ${prg_name}

    wait until element is visible         //button/span[contains(text(), " Add Program ")]   20
    click element                         //button/span[contains(text(), " Add Program ")]
    wait until element is visible         (//button/span[contains(text(), " Select")])[1]
    scroll element into view              (//button/span[contains(text(), " Select")])[3]

    click element                         (//button/span[contains(text(), " Select")])[3]

    wait until element is visible         //li/button/img[@alt='${Activity}']     10
    click element                         //li/button/img[@alt='${Activity}']

    set selenium implicit wait            20s
    set selenium speed                    0.4
    click element                         //button/span[contains(text(), " Save & Continue")]
    set selenium page load timeout        30

    input text                            //div/input[@id = 'mat-input-0']    ${prg_name}

    click element                         //div/mat-select[@formcontrolname='ngbCtrl']

    click element                         //div/mat-option/span[contains(text(), "USSSA")]

    execute javascript                    window.scrollTo(0,500)

    wait until element is visible         //button/span[contains(text(), " Save & Continue ")]
    double click element                  //button/span[contains(text(), " Save & Continue ")]

    ${element_present}    Run Keyword And Return Status    page should contain element      ${Division_title}
    log to console      ${element_present}
    Run Keyword If    ${element_present}=='False'    Click Element    ${BUTTON}

Create Division 1
    [Arguments]    ${D_Name}    ${D_Price}    ${Div1_regi_startdate}      ${Div1_regi_closedate}    ${Div_seasonstart}
    ...     ${Div_seasonend}    ${Div_oldage}   ${Div_youngdate}
    set selenium implicit wait            20s
#    set selenium speed                   0.4
    wait until element is visible         //button/span[contains(text(),' Add Division ')]    30
    click element                         //button/span[contains(text(),' Add Division ')]
    wait until element is visible         //div/input[@formcontrolname='nameCtrl']
    input text                            //div/input[@formcontrolname='nameCtrl']    ${D_Name}
    input text                            //div/input[@formcontrolname='priceCtrl']    ${D_Price}
#Gender selection
    click element                         //mat-select[@name='genderCtrl']
    click element                         //mat-option[@value="select-all"]

    double click element                   //div/h3[contains(text(), "Division Information")]

    input text                            (//div/input[@formcontrolname='openDateCtrl'])[1]      ${Div1_regi_startdate}
    double click element                  //h3/span[contains(text(), "Age Range")]

    input text                            (//div/input[@formcontrolname='closeDateCtrl'])[1]      ${Div1_regi_closedate}
    double click element                  //div/h3[contains(text(), "Season Dates")]

    input text                            (//div/input[@formcontrolname='startDateCtrl'])[1]      ${Div_seasonstart}
    double click element                  //h3/span[contains(text(), "Age Range")]

    input text                            (//div/input[@formcontrolname='endDateCtrl'])[1]      ${Div_seasonend}
    double click element                  //div/h3[contains(text(), "Season Dates")]

    input text                            //div/input[@formcontrolname='ageStartCtrl']      ${Div_oldage}
    double click element                  //div/h3[contains(text(), "Season Dates")]

    input text                            //div/input[@formcontrolname='ageEndCtrl']      ${Div_youngdate}
    double click element                  //div/h3[contains(text(), "Season Dates")]

    click element                         //button[@iconclass='save-icon']


Division 1 Advance setting
    [Arguments]     ${EarlyBird_DD}    ${Earlybirth_Date}   ${DL-Dis}   ${DL-Fee}   ${DL-MFee}    ${Deposit}
    ...             ${EMI-1 Date}   ${EMI-1}    ${installmentFee}
    ...             ${EMI-2 Date}   ${EMI-2}    ${EMI-3 Date}   ${EMI-3}
    set selenium implicit wait            20s
    set selenium speed                    0.4
    sleep   3
    wait until element is visible         (//button/span/span[contains(text(),"Advanced")])[1]     30

#    DIvision Advanced setting
    click element                         (//button/span/span[contains(text(),"Advanced")])[1]

#    Division level fee & Discount
    wait until element is visible         //div/div/span[contains(text(),"Discounts & Fees")]        20
    click element                         //div/div/span[contains(text(),"Discounts & Fees")]

#    earlybird amount
    wait until element is visible         //div/input[@formcontrolname='earlyBirdDiscountAmountCtrl']     20
    input text                            //div/input[@formcontrolname='earlyBirdDiscountAmountCtrl']     ${EarlyBird_DD}

#    earlybird date
    wait until element is visible         //div/input[@formcontrolname='earlyBirdDiscountEndDateCtrl']       10
    double click element                  //div/input[@formcontrolname='earlyBirdDiscountEndDateCtrl']
    input text                            //div/input[@formcontrolname='earlyBirdDiscountEndDateCtrl']     ${Earlybirth_Date}

#Division Level Custom Fee & Discount
    click element                         //button/span[contains(text(),'Add Custom Discount Or Fee Question')]

    click element                         //button[contains(text(),'Discount')]

    input text                            //div/input[@formcontrolname='prompt']    DD

    input text                            (//div/input[@formcontrolname='amount'])    ${DL-Dis}

    input text                            //div/input[@formcontrolname='name']      DD

    click element                         (//*[@formcontrolname='applyOnOption']/mat-radio-button/label)[1]

    click element                         (//button[@iconclass='save-icon']/span)[1]

#Add custom fee for the Division 1

    click element                         //button/span[contains(text(),'Add Custom Discount Or Fee Question')]

    click element                         //button[contains(text(),'Fee')]

    input text                            //div/input[@formcontrolname='prompt']    DF

    input text                            (//div/input[@formcontrolname='amount'])[2]    ${DL-Fee}

    input text                            //div/input[@formcontrolname='name']      DF

    click element                         (//button[@iconclass='save-icon']/span)[1]

#Add Mandatory fee for the Division 1

    click element                         //button/span[contains(text(),'Add Custom Discount Or Fee Question')]

    click element                         //button[contains(text(),' Mandatory Fee ')]

    input text                            //div/input[@formcontrolname='prompt']    MDF

    input text                            (//div/input[@formcontrolname='amount'])[3]    ${DL-MFee}

    input text                            //div/input[@formcontrolname='name']      DMF

    click element                         (//button[@iconclass='save-icon']/span)[1]


#Deposit amount
    click element                         //div/span[contains(text(),'Payment Options')]

    wait until element is visible         (//div[@class='mat-radio-container'])[1]
    click element                         (//div[@class='mat-radio-container'])[1]

    input text                            //div/input[@formcontrolname='depositAmountCtrl']      ${Deposit}

#Payment Plan
    click element                         //button/span[contains(text(),'Add Payment Plan')]

    execute javascript                    window.scrollTo(0,document.body.scrollHeight)

    input text                            //input[@formcontrolname="planNameCtrl"]      Payment Plan

    input text                            //input[@formcontrolname="planDescriptionCtrl"]   Payment Plan

    double click element                  (//input[@formcontrolname="estimatedDueDateCtrl"])[1]
    input text                            (//input[@formcontrolname="estimatedDueDateCtrl"])[1]      ${EMI-1 Date}

    input text                            (//input[@formcontrolname="amountCtrl"])[1]                ${EMI-1}

    input text                            (//input[@formcontrolname="installmentFeeCtrl"])           ${installmentFee}


    double click element                  (//input[@formcontrolname="estimatedDueDateCtrl"])[2]
    input text                            (//input[@formcontrolname="estimatedDueDateCtrl"])[2]      ${EMI-2 Date}

    input text                            (//input[@formcontrolname="amountCtrl"])[2]                ${EMI-2}


    click element                          //button/span[contains(text(),'Add Payment Installment')]

    double click element                   (//input[@formcontrolname="estimatedDueDateCtrl"])[3]
    input text                             (//input[@formcontrolname="estimatedDueDateCtrl"])[3]      ${EMI-3 Date}

    input text                             (//input[@formcontrolname="amountCtrl"])[3]                ${EMI-3}

    execute javascript                     window.scrollTo(0,-200)

    click element                          //span/mat-icon[contains(text(),'save')]

    execute javascript                     window.scrollTo(0,document.body.scrollHeight)
    wait until element is visible          //button[@id='divisionSave']
    click element                          //button[@id='divisionSave']

    execute javascript                     window.scrollTo(0,-document.body.scrollHeight)

    click element                          //button/span/mat-icon[contains(text(),"clear")]

Create Division 2
    [Arguments]    ${D_Name}    ${D_Price}    ${Div1_regi_startdate}      ${Div1_regi_closedate}    ${Div_seasonstart}
    ...     ${Div_seasonend}    ${Div_oldage}   ${Div_youngdate}
    set selenium implicit wait             20s

#    set selenium speed                    0.4
    sleep       3
    wait until element is visible          //button/span[contains(text(),' Add Division ')]    30
    click element                          //button/span[contains(text(),' Add Division ')]
    wait until element is visible          //div/input[@formcontrolname='nameCtrl']       10
    input text                             //div/input[@formcontrolname='nameCtrl']    ${D_Name}
    input text                             //div/input[@formcontrolname='priceCtrl']    ${D_Price}
#Gender selection
    click element                          //mat-select[@name='genderCtrl']
    click element                          //mat-option[@value="select-all"]

    execute javascript                     window.scrollTo(0,200)

    double click element                   //div/h3[contains(text(), "Division Information")]
    click element                          (//div[@class='mat-radio-container'])[2]

    input text                             (//div/input[@formcontrolname='openDateCtrl'])[1]      ${Div1_regi_startdate}
    double click element                   //h3/span[contains(text(), "Age Range")]

    input text                             (//div/input[@formcontrolname='closeDateCtrl'])[1]      ${Div1_regi_closedate}
    double click element                   //div/h3[contains(text(), "Season Dates")]

    input text                             (//div/input[@formcontrolname='startDateCtrl'])[1]      ${Div_seasonstart}
    double click element                   //h3/span[contains(text(), "Age Range")]

    input text                             (//div/input[@formcontrolname='endDateCtrl'])[1]      ${Div_seasonend}
    double click element                   //div/h3[contains(text(), "Season Dates")]

    input text                             //div/input[@formcontrolname='ageStartCtrl']      ${Div_oldage}
    double click element                   //div/h3[contains(text(), "Season Dates")]

    input text                             //div/input[@formcontrolname='ageEndCtrl']      ${Div_youngdate}
    double click element                   //div/h3[contains(text(), "Season Dates")]

    click element                          //button[@iconclass='save-icon']

Division 2 Advance Settings
    [Arguments]     ${LateFee_DF}    ${Latefee_Date}    ${Deposit}
    ...             ${EMI-1 Date}   ${EMI-1}    ${installmentFee}
    ...             ${EMI-2 Date}   ${EMI-2}    ${EMI-3 Date}   ${EMI-3}
    set selenium implicit wait             20s
    set selenium speed                     0.4
    wait until element is visible          (//button/span/span[contains(text(),"Advanced")])[2]     30
#    DIvision Advanced setting
    sleep       2
    click element                          (//button/span/span[contains(text(),"Advanced")])[2]
    execute javascript                     window.scrollTo(0,200)

    click element                          (//div[contains(text(),'No')])[2]

    execute javascript                     window.scrollTo(0,-300)

    wait until element is visible          //div/div/span[contains(text(),"Discounts & Fees")]        20
    click element                          //div/div/span[contains(text(),"Discounts & Fees")]

#    Late free amount
    wait until element is visible          //div/input[@formcontrolname='lateFeeAmountCtrl']       10
    input text                             //div/input[@formcontrolname='lateFeeAmountCtrl']     ${LateFee_DF}

#    Late Fee Date
    wait until element is visible          //div/input[@formcontrolname='lateFeeStartDateCtrl']     10
    double click element                   //div/input[@formcontrolname='lateFeeStartDateCtrl']
    input text                             //div/input[@formcontrolname='lateFeeStartDateCtrl']     ${Latefee_Date}

#Deposit amount
    click element                          //div/span[contains(text(),'Payment Options')]

    wait until element is visible          (//div[@class='mat-radio-container'])[1]
    click element                          (//div[@class='mat-radio-container'])[1]

    input text                             //div/input[@formcontrolname='depositAmountCtrl']      ${Deposit}

#Payment Plan

    click element                          //button/span[contains(text(),'Add Payment Plan')]

    execute javascript                     window.scrollTo(0,document.body.scrollHeight)

    input text                             //input[@formcontrolname="planNameCtrl"]      Payment Plan

    input text                             //input[@formcontrolname="planDescriptionCtrl"]   Payment Plan

    double click element                   (//input[@formcontrolname="estimatedDueDateCtrl"])[1]
    input text                             (//input[@formcontrolname="estimatedDueDateCtrl"])[1]      ${EMI-1 Date}

    input text                             (//input[@formcontrolname="amountCtrl"])[1]                ${EMI-1}

    input text                             (//input[@formcontrolname="installmentFeeCtrl"])           ${installmentfee}

    double click element                   (//input[@formcontrolname="estimatedDueDateCtrl"])[2]
    input text                             (//input[@formcontrolname="estimatedDueDateCtrl"])[2]      ${EMI-2 Date}

    input text                             (//input[@formcontrolname="amountCtrl"])[2]                ${EMI-2}

    click element                          //button/span[contains(text(),'Add Payment Installment')]

    double click element                   (//input[@formcontrolname="estimatedDueDateCtrl"])[3]
    input text                             (//input[@formcontrolname="estimatedDueDateCtrl"])[3]      ${EMI-2 Date}

    input text                             (//input[@formcontrolname="amountCtrl"])[3]                ${EMI-3}

    execute javascript                     window.scrollTo(0,-200)

    click element                          //span/mat-icon[contains(text(),'save')]

    execute javascript                     window.scrollTo(0,document.body.scrollHeight)
    wait until element is visible          //button[@id='divisionSave']
    click element                          //button[@id='divisionSave']

    execute javascript                     window.scrollTo(0,-document.body.scrollHeight)
    sleep        1
    click element                          //button/span/mat-icon[contains(text(),"clear")]

Create Division 3
    [Arguments]    ${D_Name}    ${D_Price}    ${Div1_regi_startdate}      ${Div1_regi_closedate}    ${Div_seasonstart}
    ...     ${Div_seasonend}    ${Div_oldage}   ${Div_youngdate}
    set selenium implicit wait             20s
#    set selenium speed                    0.4
    sleep       3
    wait until element is visible          //button/span[contains(text(),' Add Division ')]    30
    click element                          //button/span[contains(text(),' Add Division ')]
    wait until element is visible          //div/input[@formcontrolname='nameCtrl']       10
    input text                             //div/input[@formcontrolname='nameCtrl']    ${D_Name}
    input text                             //div/input[@formcontrolname='priceCtrl']    ${D_Price}
#Gender selection
    click element                          //mat-select[@name='genderCtrl']
    click element                          //mat-option[@value="select-all"]

    execute javascript                     window.scrollTo(0,200)

    double click element                   //div/h3[contains(text(), "Division Information")]
    click element                          (//div[@class='mat-radio-container'])[2]

    input text                             //div/input[@formcontrolname='openDateCtrl']      ${Div1_regi_startdate}
    double click element                   //h3/span[contains(text(), "Age Range")]

    input text                             //div/input[@formcontrolname='closeDateCtrl']      ${Div1_regi_closedate}
    double click element                   //div/h3[contains(text(), "Season Dates")]

    input text                             //div/input[@formcontrolname='startDateCtrl']      ${Div_seasonstart}
    double click element                   //h3/span[contains(text(), "Age Range")]

    input text                             //div/input[@formcontrolname='endDateCtrl']      ${Div_seasonend}
    double click element                   //div/h3[contains(text(), "Season Dates")]

    input text                             //div/input[@formcontrolname='ageStartCtrl']      ${Div_oldage}
    double click element                   //div/h3[contains(text(), "Season Dates")]

    input text                             //div/input[@formcontrolname='ageEndCtrl']      ${Div_youngdate}
    double click element                   //div/h3[contains(text(), "Season Dates")]

    execute javascript                     window.scrollTo(0,-100)

    click element                          //button[@iconclass='save-icon']

Division 3 Advance Settings
    [Arguments]     ${Deposit}   ${EMI-1 Date}   ${EMI-1}    ${installmentFee}
    ...             ${EMI-2 Date}   ${EMI-2}    ${EMI-3 Date}   ${EMI-3}
    set selenium implicit wait             20s
    set selenium speed                     0.4

#    Division Advanced setting
    sleep       2
    wait until element is visible          (//button/span/span[contains(text(),"Advanced")])[3]     30
    click element                          (//button/span/span[contains(text(),"Advanced")])[3]

    execute javascript                     window.scrollTo(0,document.body.scrollHeight)
    input text                             //*[@id='freeagentPolicyCtrl-quill']/div[2]/div/div    Free Agent Policy
    execute javascript                     window.scrollTo(0,-document.body.scrollHeight)

#Deposit amount
    wait until element is visible          //div/span[contains(text(),'Payment Options')]
    click element                          //div/span[contains(text(),'Payment Options')]

    wait until element is visible          (//div[@class='mat-radio-container'])[1]
    click element                          (//div[@class='mat-radio-container'])[1]

    input text                             //div/input[@formcontrolname='depositAmountCtrl']      ${Deposit}

#Payment Plan
    click element                          //button/span[contains(text(),'Add Payment Plan')]

    execute javascript                     window.scrollTo(0,document.body.scrollHeight)

    input text                             //input[@formcontrolname="planNameCtrl"]      Payment Plan

    input text                             //input[@formcontrolname="planDescriptionCtrl"]   Payment Plan

    double click element                   (//input[@formcontrolname="estimatedDueDateCtrl"])[1]
    input text                             (//input[@formcontrolname="estimatedDueDateCtrl"])[1]      ${EMI-1 Date}

    input text                             (//input[@formcontrolname="amountCtrl"])[1]                ${EMI-1}

    input text                             (//input[@formcontrolname="installmentFeeCtrl"])           ${installmentFee}

    double click element                   (//input[@formcontrolname="estimatedDueDateCtrl"])[2]
    input text                             (//input[@formcontrolname="estimatedDueDateCtrl"])[2]      ${EMI-2 Date}

    input text                             (//input[@formcontrolname="amountCtrl"])[2]                ${EMI-2}

    click element                          //button/span[contains(text(),'Add Payment Installment')]

    double click element                   (//input[@formcontrolname="estimatedDueDateCtrl"])[3]
    input text                             (//input[@formcontrolname="estimatedDueDateCtrl"])[3]      ${EMI-3 Date}

    input text                             (//input[@formcontrolname="amountCtrl"])[3]                ${EMI-3}

    execute javascript                     window.scrollTo(0,-200)

    click element                          //span/mat-icon[contains(text(),'save')]

    execute javascript                     window.scrollTo(0,document.body.scrollHeight)
    wait until element is visible          //button[@id='divisionSave']
    click element                          //button[@id='divisionSave']

    execute javascript                     window.scrollTo(0,-document.body.scrollHeight)
    sleep        1
    click element                          //button/span/mat-icon[contains(text(),"clear")]

    wait until element is visible          //button/span[contains(text(), " Save & Continue ")]    20
    click element                          //button/span[contains(text(), " Save & Continue ")]

Registration Questions
    set selenium implicit wait             20s
    set selenium speed                     0.4

    click element                          //button/span[contains(text(),'Add Question')]
    click element                          //button[contains(text(),' Standard Question ')]
    ${Reg_Questions}=   Get WebElements    //span/span[contains(text(),'Add')]
    FOR    ${RegQ}   IN RANGE    3
        sleep       1
        click element       ${Reg_Questions}[${RegQ}]
        sleep       1
    END
    execute javascript                     window.scrollTo(0,document.body.scrollHeight)
    click element                          (//button/span[contains(text(),'Save')])[2]

    wait until element is visible          (//button/span[contains(text(),' Save & Continue ')])[2]        20
    click element                          (//button/span[contains(text(),' Save & Continue ')])[2]

Fees & Discount
    [Arguments]    ${FamilyDis}     ${VolumeDis}      ${ResidentDis}

    set selenium implicit wait             20s
#    set selenium speed                    0.4
    wait until element is visible          //div/input[@formcontrolname='secondParticipantDiscountCtrl']      10

    input text                             //div/input[@formcontrolname='secondParticipantDiscountCtrl']      ${FamilyDis}
    input text                             //div/input[@formcontrolname='thirdParticipantDiscountCtrl']      ${FamilyDis}
    input text                             //div/input[@formcontrolname='fourthParticipantDiscountCtrl']      ${FamilyDis}
    input text                             //div/input[@formcontrolname='subsequentParticipantDiscountCtrl']      ${FamilyDis}

    input text                             //div/input[@formcontrolname='volumeDiscountCtrl']     ${VolumeDis}

    click element                          (//label/div[@class='mat-radio-container'])[2]

    input text                             //div/input[@formcontrolname='residentDiscountFeeAmount']     ${ResidentDis}

    scroll element into view               (//div[@class='tshq-program-wizard-nav']/button/span)[3]

Add Program level fee & discount
    [Arguments]    ${PL-Dis}    ${PL-Fee}   ${PL-MFee}
    set selenium implicit wait             20s
    set selenium speed                     0.4

    click element                          //button/span[contains(text(),'Add Custom Discount Or Fee Question')]

    click element                          //button[contains(text(),'Discount')]

    input text                             //div/input[@formcontrolname='prompt']    PL-D

    input text                             (//div/input[@formcontrolname='amount'])    ${PL-Dis}

    input text                             //div/input[@formcontrolname='name']      PL-D

    click element                          (//*[@formcontrolname='applyOnOption']/mat-radio-button/label)[1]

    click element                          (//button[@iconclass='save-icon']/span)[1]

#Add Program Level Fees
    wait until element is visible          //button/span[contains(text(),'Add Custom Discount Or Fee Question')]

    click element                          //button/span[contains(text(),'Add Custom Discount Or Fee Question')]

    click element                          //button[contains(text(),'Fee')]

    input text                             //div/input[@formcontrolname='prompt']    PL-F

    input text                             (//div/input[@formcontrolname='amount'])[2]    ${PL-Fee}

    input text                             //div/input[@formcontrolname='name']      PL-F

    click element                          (//button[@iconclass='save-icon']/span)[1]

#Add Program level Mandatory Fees

    wait until element is visible          //button/span[contains(text(),'Add Custom Discount Or Fee Question')]

    click element                          //button/span[contains(text(),'Add Custom Discount Or Fee Question')]

    click element                          //button[contains(text(),' Mandatory Fee ')]
    input text                             //div/input[@formcontrolname='prompt']    PL-MF

    input text                             (//div/input[@formcontrolname='amount'])[3]    ${PL-MFee}

    input text                             //div/input[@formcontrolname='name']      PL-MF

    click element                          (//button[@iconclass='save-icon']/span)[1]

    scroll element into view               (//div[@class='tshq-program-wizard-nav']/button/span)[3]

    click element                          (//div[@class='tshq-program-wizard-nav']/button/span)[3]

Team Staff Setup
    [Arguments]    ${Cpos_Name}
    set selenium implicit wait             20s
    set selenium speed                     0.4
    wait until element is visible          //button/span[contains(text(),' Add Team Staff Position ')]    10
    click element                          //button/span[contains(text(),' Add Team Staff Position ')]
    click element                          //div/button[contains(text(),'Available Position')]

#    standard position selection
    wait until element is visible          //label[@class='mat-checkbox-layout']
    click element                          (//label[@class='mat-checkbox-layout'])[3]
    click element                          (//label[@class='mat-checkbox-layout'])[4]
    scroll element into view               //*[@id="select-team-personnel"]/tshq-program-wizard-nav/div/div/button/span

    click element                          //*[@id="select-team-personnel"]/tshq-program-wizard-nav/div/div/button/span

#   Custom position Add
    wait until element is visible          //button/span[contains(text(),' Add Team Staff Position ')]    10
    click element                          //button/span[contains(text(),' Add Team Staff Position ')]

    click element                          //div/button[contains(text(),'Custom Position')]

    wait until element is visible          //div/input[@formcontrolname='roleName']       20
    ${Current_Date_Time}             get current date        exclude_millis=yes
    input text                             //div/input[@formcontrolname='roleName']       ${Cpos_Name}${Current_Date_Time}

    input text                             //div/input[@formcontrolname='roleDescription']    it's custom position

    input text                             //div/input[@formcontrolname='displayName']     ${Cpos_Name}${Current_Date_Time}

    click element                          (//div[@class='tshq-program-wizard-nav']/button/span)[4]

    sleep       2
    execute javascript                     window.scrollTo(0,document.body.scrollHeight)
    sleep       1
    execute javascript                     window.scrollTo(0,document.body.scrollHeight)

    wait until element is visible          (//div[@class='tshq-program-wizard-nav']/button/span)[4]      10
    click element                          (//div[@class='tshq-program-wizard-nav']/button/span)[4]

    wait until element is visible          (//div[@class='tshq-program-wizard-nav']/button/span)[4]      20

#    click element                         (//button/span[contains(text(), " Save & Continue ")])[4]
    click element                          (//div[@class='tshq-program-wizard-nav']/button/span)[4]

Confirmation Note
    set selenium implicit wait             20s
    set selenium speed                     0.4

    scroll element into view               //*[@id='confirmationEmail-quill']/div[2]/div/div
    input text                             //*[@id='confirmationEmail-quill']/div[2]/div/div       Order Confirmation Notes

    scroll element into view               //*[@id='playerInviteEmail-quill']/div[2]/div/div
    input text                             //*[@id='playerInviteEmail-quill']/div[2]/div/div       Player Invite Notes

    scroll element into view               //*[@id='teamStaffConfirmationEmail-quill']/div[2]/div/div
    input text                             //*[@id='teamStaffConfirmationEmail-quill']/div[2]/div/div    Team Staff Confirmation Notes

    execute javascript                     window.scrollTo(0,document.body.scrollHeight)

    wait until element is visible          //button/span[contains(text(), " Save & Finish ")]       10
    click element                          //button/span[contains(text(), " Save & Finish ")]


