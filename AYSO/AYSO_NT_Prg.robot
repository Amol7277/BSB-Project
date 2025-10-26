*** Settings ***
Library     SeleniumLibrary
Library     DateTime
Resource    Resourse_AYSO.robot
Test Setup      Open the browser and open the URL


*** Test Cases ***
AYSO Non Tryout Program Creation
    ${Current_Date_Time}       get current date                                  exclude_millis=yes

    ${EarlyBird_Date}=         Add Time To Date     ${Current_Date_Time}    5 days     result_format=%m-%d-%Y
    ${LateFee_Date}=           Add Time To Date     ${Current_Date_Time}    -2 days    result_format=%m-%d-%Y
    #Payment Plan Dates
    ${EMI 1}=                  Add Time To Date     ${Current_Date_Time}    30 days    result_format=%m-%d-%Y
    ${EMI 2}=                  Add Time To Date     ${Current_Date_Time}    60 days    result_format=%m-%d-%Y
    ${EMI 3}=                  Add Time To Date     ${Current_Date_Time}    90 days    result_format=%m-%d-%Y


    Login into the Portal
    Open the registration form
    Create the AYSO Non Tryout Program and Complete the 1st step    ${AYSO_NT_Program_Name}${Current_Date_Time}
    Edit the 19U divisions      ${EarlyBird_Date}     ${LateFee_Date}    ${EMI 1}    ${EMI 2}    ${EMI 3}
    Go to the Registration Question and Add question
    Fees & Discount
    Add Program level fee & discount
    Go to the Team Staff Add Standard & Custom Team Staff       ${Vol_Name}
    Go to the Confirmation note and add some note into it
*** Keywords ***
Open the browser and open the URL
    open browser    ${URL}      ${browser}
    maximize browser window

Login into the Portal
    set selenium implicit wait            20s
#    set selenium speed                   0.5
    click element                         id:dnn_dnnLOGIN_cmdLogin
    wait until element is visible         name:email
    input text                            name:email      ${User_ID}

    click element                         name:continue
    wait until element is visible         name:password      10
    input text                            name:password     ${Pwd}

    click element                         name:continue

Open the registration form
    set selenium implicit wait            10
    set selenium speed                    0.4

    ${Status}   run keyword and return status       page should contain element      //ul/li/a/span[contains(text(), "Registration")]
    log to console      ${Status}
    sleep       3
    Run Keyword If      ${Status}=='False'          reload page
    wait until element is visible         //ul/li/a/span[contains(text(), "Registration")]    200
#    run keyword and continue on failure     wait until element is visible         //marketplace-toolbar[@class='hydrated']      50

    mouse over                            //ul/li/a/span[contains(text(), "Registration")]
    click element                         //ul/li/a/span[contains(text(), "Registration Forms")]

Create the AYSO Non Tryout Program and Complete the 1st step
    [Arguments]     ${prg_name}

    wait until element is visible         //button/span[contains(text(), " Add Program ")]   20
    click element                         //button/span[contains(text(), " Add Program ")]
    wait until element is visible         (//button/span[contains(text(), " Select")])[1]
    scroll element into view              (//button/span[contains(text(), " Select")])[1]

    click element                         (//button/span[contains(text(), " Select")])[1]

    wait until element is visible         //li/button/img[@alt='${Activity}']     10
    click element                         //li/button/img[@alt='${Activity}']

    set selenium implicit wait            20s
    set selenium speed                    1

    click element                         //button/span[contains(text(), " Save & Continue")]
    set selenium page load timeout        30

    input text                            //div/input[@id = 'mat-input-0']    ${prg_name}

    click element                         //div/mat-select[@formcontrolname='ngbCtrl']
    click element                         //div/mat-option/span[contains(text(), "AYSO")]

    wait until element is visible         //mat-select[@formcontrolname="tier1Ctrl"]       10

    click element                         //mat-select[@formcontrolname="tier1Ctrl"]
    click element                         //div/mat-option/span[contains(text(), "Section 90 National Office")]

    wait until element is visible         //mat-select[@formcontrolname="tier2Ctrl"]        10

    click element                         //mat-select[@formcontrolname="tier2Ctrl"]
    click element                         //div/mat-option/span[contains(text(), "AYSO Demo Area")]

    wait until element is visible         //mat-select[@formcontrolname="tier3Ctrl"]        10

    click element                         //mat-select[@formcontrolname="tier3Ctrl"]
    click element                         //div/mat-option/span[contains(text(), "AYSO Demo Region")]

    wait until element is visible         //mat-select[@formcontrolname="seasonCtrl"]        10

    click element                         //mat-select[@formcontrolname="seasonCtrl"]
    click element                         //div/mat-option/span[contains(text(), "2024-2025 MY2024")]

    click element                         //mat-select[@formcontrolname="playLevelCtrl"]
    click element                         //div/mat-option/span[contains(text(), "Core")]

    click element                         //button/span[contains(text(), " Save & Continue ")]

Edit the 19U divisions
    [Arguments]    ${Earlybirth_Date}   ${Latefee_Date}     ${EMI 1}    ${EMI 2}    ${EMI 3}
    set selenium implicit wait            20s
    set selenium speed                    1

    @{Div_Index}     create list     21      22
    FOR     ${div}      IN      @{Div_Index}
        click element       (//button[@mattooltip="Edit"])[${div}]/span
        input text          //input[@formcontrolname="priceCtrl"]       10000
        click element       //mat-select[@formcontrolname="genderCtrl"]
        click element       //mat-option[@value="C"]
        click element       //button[@iconname="done"]

        IF   ${div}==21
            click element    (//span[contains(text(),"Advanced")])[${div}]
                sleep   3
#    Division level fee & Discount
                wait until element is visible         //div/div/span[contains(text(),"Discounts & Fees")]        20
                click element                         //div/div/span[contains(text(),"Discounts & Fees")]

#Early Bird Discount
                wait until element is visible         //div/input[@formcontrolname='earlyBirdDiscountAmountCtrl']     20
                input text                            //div/input[@formcontrolname='earlyBirdDiscountAmountCtrl']     1000

                wait until element is visible         //div/input[@formcontrolname='earlyBirdDiscountEndDateCtrl']       10
                double click element                  //div/input[@formcontrolname='earlyBirdDiscountEndDateCtrl']
                input text                            //div/input[@formcontrolname='earlyBirdDiscountEndDateCtrl']     ${Earlybirth_Date}

#Late Fee
                wait until element is visible          //div/input[@formcontrolname='lateFeeAmountCtrl']       10
                input text                             //div/input[@formcontrolname='lateFeeAmountCtrl']     1000

                wait until element is visible          //div/input[@formcontrolname='lateFeeStartDateCtrl']     10
                double click element                   //div/input[@formcontrolname='lateFeeStartDateCtrl']
                input text                             //div/input[@formcontrolname='lateFeeStartDateCtrl']     ${Latefee_Date}

#Division Level Custom Fee & Discount
                click element                         //button/span[contains(text(),'Add Custom Discount Or Fee Question')]

                click element                         //button[contains(text(),'Discount')]

                input text                            //div/input[@formcontrolname='prompt']    DD1

                input text                            (//div/input[@formcontrolname='amount'])    1000

                input text                            //div/input[@formcontrolname='name']      DD1

                click element                         (//*[@formcontrolname='applyOnOption']/mat-radio-button/label)[1]

                click element                         (//button[@iconclass='save-icon']/span)[1]

#Add custom fee for the Division 1

                click element                         //button/span[contains(text(),'Add Custom Discount Or Fee Question')]

                click element                         //button[contains(text(),'Fee')]

                input text                            //div/input[@formcontrolname='prompt']    DF

                input text                            (//div/input[@formcontrolname='amount'])[2]    1000

                input text                            //div/input[@formcontrolname='name']      DF

                click element                         (//button[@iconclass='save-icon']/span)[1]

#Add Mandatory fee for the Division 1

                click element                         //button/span[contains(text(),'Add Custom Discount Or Fee Question')]

                click element                         //button[contains(text(),' Mandatory Fee ')]

                input text                            //div/input[@formcontrolname='prompt']    MDF

                input text                            (//div/input[@formcontrolname='amount'])[3]    1000

                input text                            //div/input[@formcontrolname='name']      DMF

                click element                         (//button[@iconclass='save-icon']/span)[1]


#Deposit amount
                click element                         //div/span[contains(text(),'Payment Options')]

                wait until element is visible         (//div[@class='mat-radio-container'])[1]
                click element                         (//div[@class='mat-radio-container'])[1]

                input text                            //div/input[@formcontrolname='depositAmountCtrl']      5000

#Payment PLan
                click element                         //button/span[contains(text(),'Add Payment Plan')]

                execute javascript                    window.scrollTo(0,document.body.scrollHeight)

                input text                            //input[@formcontrolname="planNameCtrl"]       Payment Plan

                input text                            //input[@formcontrolname="planDescriptionCtrl"]    Payment Plan

                double click element                  (//input[@formcontrolname="estimatedDueDateCtrl"])[1]
                input text                            (//input[@formcontrolname="estimatedDueDateCtrl"])[1]      ${EMI 1}

                input text                            (//input[@formcontrolname="amountCtrl"])[1]                3300

                input text                            (//input[@formcontrolname="installmentFeeCtrl"])           1000


                double click element                  (//input[@formcontrolname="estimatedDueDateCtrl"])[2]
                input text                            (//input[@formcontrolname="estimatedDueDateCtrl"])[2]      ${EMI 2}

                input text                            (//input[@formcontrolname="amountCtrl"])[2]                3300


                click element                          //button/span[contains(text(),'Add Payment Installment')]

                double click element                   (//input[@formcontrolname="estimatedDueDateCtrl"])[3]
                input text                             (//input[@formcontrolname="estimatedDueDateCtrl"])[3]      ${EMI 3}

                input text                             (//input[@formcontrolname="amountCtrl"])[3]                3400

                execute javascript                     window.scrollTo(0,-200)

                click element                          //span/mat-icon[contains(text(),'save')]

                execute javascript                     window.scrollTo(0,document.body.scrollHeight)
                wait until element is visible          //button[@id='divisionSave']
                click element                          //button[@id='divisionSave']

                execute javascript                     window.scrollTo(0,-document.body.scrollHeight)
                click element                          //button/span/mat-icon[contains(text(),"clear")]
        END
    END

    wait until element is visible         //button/span[contains(text(),'Save & Continue')]       20
    click element                         //button/span[contains(text(),'Save & Continue')]

Go to the Registration Question and Add question
    set selenium implicit wait            20s
    set selenium speed                    0.4

    wait until element is visible         //span[contains(text(),"Add Question")]    20
    click element                         //span[contains(text(),"Add Question")]

    click element                         //button[contains(text(),"Standard Question")]

    ${Reg_Ques}=    Get WebElements       //span/span[contains(text(),'Add')]

    FOR    ${RegQ}   IN RANGE    3
        click element       ${Reg_Ques}[${RegQ}]
    END
    execute javascript                    window.scrollTo(0,document.body.scrollHeight)

    click element                         (//button/span[contains(text(),'Save')])[2]

    wait until element is visible         (//button/span[contains(text(),' Save & Continue ')])[2]        10
    click element                         (//button/span[contains(text(),' Save & Continue ')])[2]

Fees & Discount
    set selenium implicit wait             20s
#    set selenium speed                    0.4
    wait until element is visible          //div/input[@formcontrolname='secondParticipantDiscountCtrl']      10

    input text                             //div/input[@formcontrolname='secondParticipantDiscountCtrl']      1000
    input text                             //div/input[@formcontrolname='thirdParticipantDiscountCtrl']      1000
    input text                             //div/input[@formcontrolname='fourthParticipantDiscountCtrl']      1000
    input text                             //div/input[@formcontrolname='subsequentParticipantDiscountCtrl']      1000

    input text                             //div/input[@formcontrolname='volumeDiscountCtrl']     1000

    click element                          (//label/div[@class='mat-radio-container'])[2]

    input text                             //div/input[@formcontrolname='residentDiscountFeeAmount']     1000

    scroll element into view               (//div[@class='tshq-program-wizard-nav']/button/span)[3]

Add Program level fee & discount
    set selenium implicit wait             20s
    set selenium speed                     0.4

    click element                          //button/span[contains(text(),'Add Custom Discount Or Fee Question')]

    click element                          //button[contains(text(),'Discount')]

    input text                             //div/input[@formcontrolname='prompt']    PL-D

    input text                             (//div/input[@formcontrolname='amount'])    1000

    input text                             //div/input[@formcontrolname='name']      PL-D

    click element                          (//*[@formcontrolname='applyOnOption']/mat-radio-button/label)[1]

    click element                          (//button[@iconclass='save-icon']/span)[1]

#Add Program Level Fees
    wait until element is visible          //button/span[contains(text(),'Add Custom Discount Or Fee Question')]

    click element                          //button/span[contains(text(),'Add Custom Discount Or Fee Question')]

    click element                          //button[contains(text(),'Fee')]

    input text                             //div/input[@formcontrolname='prompt']    PL-F

    input text                             (//div/input[@formcontrolname='amount'])[2]    1000

    input text                             //div/input[@formcontrolname='name']      PL-F

    click element                          (//button[@iconclass='save-icon']/span)[1]

#Add Program level Mandatory Fees

    wait until element is visible          //button/span[contains(text(),'Add Custom Discount Or Fee Question')]

    click element                          //button/span[contains(text(),'Add Custom Discount Or Fee Question')]

    click element                          //button[contains(text(),' Mandatory Fee ')]
    input text                             //div/input[@formcontrolname='prompt']    PL-MF

    input text                             (//div/input[@formcontrolname='amount'])[3]    1000

    input text                             //div/input[@formcontrolname='name']      PL-MF

    click element                          (//button[@iconclass='save-icon']/span)[1]

    scroll element into view               (//div[@class='tshq-program-wizard-nav']/button/span)[3]

    click element                          (//div[@class='tshq-program-wizard-nav']/button/span)[3]

Go to the Team Staff Add Standard & Custom Team Staff
    [Arguments]    ${Cpos_Name}
    set selenium implicit wait            20s
    set selenium speed                    1
#    wait until element is visible         //button/span[contains(text(),' Display Standard Positions ')]    10
#    click element                         //button/span[contains(text(),' Display Standard Positions ')]
#
#    ${Avail_TeamStaff}=   Get WebElements     //label[@class='mat-checkbox-layout']
#
#    FOR    ${RegQ}   IN RANGE   1    4
#        click element       ${Avail_TeamStaff}[${RegQ}]
#    END
#    scroll element into view              //*[@id="select-team-personnel"]/tshq-program-wizard-nav/div/div/button/span
#
#    click element                         //*[@id="select-team-personnel"]/tshq-program-wizard-nav/div/div/button/span

#   Custom position Add

    wait until element is visible         //button/span[contains(text(),' Add Team Staff Position ')]    10
    click element                         //button/span[contains(text(),' Add Team Staff Position ')]

    click element                         //div/button[contains(text(),'Custom Position')]

    wait until element is visible         //div/input[@formcontrolname='roleName']       20
    ${Current_Date_Time}            get current date        exclude_millis=yes
    input text                            //div/input[@formcontrolname='roleName']       ${Cpos_Name}${Current_Date_Time}

    click element                         //mat-select[@formcontrolname="ngbRoleCtrl"]
    click element                         (//span[contains(text(), "Referee")])

    input text                            //div/input[@formcontrolname='roleDescription']    it's custom position

    input text                            //div/input[@formcontrolname='displayName']     ${Cpos_Name}${Current_Date_Time}

    click element                         (//div[@class='tshq-program-wizard-nav']/button/span)[4]

    sleep       5
    execute javascript                    window.scrollTo(0,document.body.scrollHeight)
    sleep       2
    execute javascript                    window.scrollTo(0,document.body.scrollHeight)

#    wait until element is visible         (//div[@class='tshq-program-wizard-nav']/button/span)[4]      10
    click element                         (//div[@class='tshq-program-wizard-nav']/button/span)[4]

#    wait until element is visible         (//button/span[contains(text(), " Save & Continue ")])[4]       20

    click element                         (//div[@class='tshq-program-wizard-nav']/button/span)[4]

Go to the Confirmation note and add some note into it
    set selenium implicit wait            20s
    set selenium speed                    0.4

    wait until element is visible         //*[@formcontrolname='teamStaffConfirmationEmail']       10
    input text                            //*[@formcontrolname='confirmationEmail']/div[2]/div       Order Confirmation Notes

    scroll element into view              //button/span[contains(text(), " Save & Finish ")]

    click element                         //button/span[contains(text(), " Save & Finish ")]