*** Settings ***
Library     SeleniumLibrary


*** Variables ***
${URL}          https://leagues.bluesombrero.com/default.aspx?portalid=9003
${Browser}      chrome
${User_ID}      amol.sonar+superadmin@stacksports.com
${Pwd}          Test@1234
${AdminManualOrderURL}      https://leagues.bluesombrero.com/Default.aspx?tabid=675705
${UserName}     Rock1410, Rock1410

${Player_Name}      P4 Of 1410 Prod
${Program_Name}     NT_15_10_2025
${Division_Name}    AA

${CardHolderName}   Test Amol
${CardNumber}       4111111111111111
${Expiration}       1030
${Cvv}              123
${Zip Code}         90033

*** Test Cases ***
Single Player - Admin Manual Order
    Open the browser and login as superadmin
    Go to the Admin manual page & Search the User
    Click on the available program button
    Select the View Division
    Select Division & Continue
    Continue from the program questions page
    Skip from the Volunteer Listing page
    Skip the registration store page
    Select the Payment Option and click on Continue button
    From Checkout page Complete the Order

*** Keywords ***
Open the browser and login as superadmin
    set selenium implicit wait            20s
    set selenium speed                    0.4

    open browser    ${URL}      ${Browser}
    maximize browser window


    click element                                id:dnn_dnnLOGIN_cmdLogin
    wait until element is visible                name:email
    input text                                   name:email      ${User_ID}
    sleep   2
    click element                                name:continue
    wait until element is visible                name:password      10
    input text                                   name:password     ${Pwd}
#    sleep   2
    click element                                name:continue

Go to the Admin manual page & Search the User
    set selenium implicit wait            20s
    set selenium speed                    0.4

    wait until element is visible           //div/span[contains(text(),'Dashboard')]        100

    go to       ${AdminManualOrderURL}

    wait until element is visible           //a/span[contains(text(),'Select Account')]     150

    click element       //a/span[contains(text(),'Select Account')]
    sleep    2
    input text          //div/input[@placeholder="Search"]      ${UserName}
    sleep    2
    press keys            //div/input[@placeholder="Search"]     ENTER

#Click on the available program button
#    set selenium implicit wait            20s
#    set selenium speed                    0.4
#
#    wait until element is visible            //div/span[@class='h3 text-scheme-participants']/span[1]       100
#
#    ${Players}=     get webelements    //div/span[@class='h3 text-scheme-participants']/span[1]
#    ${index}=   set variable    1
#
#    FOR    ${Player}    IN    @{Players}
#        sleep    2
#        scroll element into view    ${Player}
#        sleep    2
#        Log     ${Player.text}
#        Exit For Loop If    '${Player_Name}' == '${Player.text}'
#        ${index}=   evaluate    ${index} + 1
#        Log    ${index}
#    END
#    click element    (//a[@data-bind='click:navigateToRegisterNewProgramPage']/i/span)[${index}]

Click on the available program button
    set selenium implicit wait            20s
    set selenium speed                    0.4

    wait until element is visible            //div/span[@class='h3 text-scheme-participants']       100

    ${Players}=     get webelements    //div/span[@class='h3 text-scheme-participants']
    ${index}=   set variable    1

    FOR    ${Player}    IN    @{Players}
        sleep    1
        scroll element into view    ${Player}
        sleep    1
        Log     ${Player.text}
        Exit For Loop If    '${Player_Name}' == '${Player.text}'
        ${index}=   evaluate    ${index} + 1
        Log    ${index}
    END
    click element    (//a[@data-bind='click:navigateToRegisterNewProgramPage']/i/span)[${index}]

Select the View Division
    set selenium implicit wait            20s
    set selenium speed                    0.4

#    wait until element is visible           //div[@class='ng-star-inserted']/div/mat-accordion/mat-expansion-panel/mat-expansion-panel-header/span/p[2]/span              100
    wait until element is visible           //mat-expansion-panel-header[@role ='button']/span/p[2]/span       100

#    ${Programs}=     get webelements        //div[@class='ng-star-inserted']/div/mat-accordion/mat-expansion-panel/mat-expansion-panel-header/span/p[2]/span
    ${Programs}=     get webelements        //mat-expansion-panel-header[@role ='button']/span/p[2]/span
    ${index}=   set variable    1

    FOR    ${Prg}    IN    @{Programs}
        sleep    1
        scroll element into view    ${Prg}
        sleep    1
        Log     ${Prg.text}
        Exit For Loop If    '${Program_Name}' == '${Prg.text}'
        ${index}=   evaluate    ${index} + 1
        Log    ${index}
    END
    scroll element into view    (//button/span[contains(text(),'View Divisions')])[${index}]
    click element    (//button/span[contains(text(),'View Divisions')])[${index}]

Select Division & Continue
    set selenium implicit wait            20s
    set selenium speed                    0.4

    wait until element is visible            //mat-card-title[@class='mat-card-title']/div      100

    ${Divisions}=     get webelements        //mat-card-title[@class='mat-card-title']/div
    ${index}=   set variable    1

    FOR    ${Div}    IN    @{Divisions}
        sleep    1
        scroll element into view    ${Div}
        sleep    1
        Log     ${Div.text}
        Exit For Loop If    '${Division_Name}' == '${Div.text}'
        ${index}=   evaluate    ${index} + 1
        Log    ${index}
    END
    sleep       1
    scroll element into view    (//button/span[contains(text(),'Select')])[${index}]
    sleep       1
    click element    (//button/span[contains(text(),'Select')])[${index}]

    sleep       5
    repeat keyword      3 times         execute javascript        window.scrollTo(0,document.body.scrollHeight)
#    sleep       2
#    execute javascript      window.scrollTo(0,document.body.scrollHeight)
    sleep       3
    click element       //button/span[contains(text(),'Continue')]

Continue from the program questions page
    set selenium implicit wait            20s
    set selenium speed                    0.4

    wait until element is visible           //div/div[@class='program-name notranslate']        50
    sleep       2
    scroll element into view        //button/span[contains(text(),'Continue')]
    sleep       2
    click element       //button/span[contains(text(),'Continue')]

Skip from the Volunteer Listing page
    set selenium implicit wait            20s
    set selenium speed                    0.4

    wait until element is visible           //button/span[contains(text(),'Skip')]        50

    repeat keyword      3 times         execute javascript        window.scrollTo(0,document.body.scrollHeight)
    sleep       2
    click element       //button/span[contains(text(),'Skip')]

Skip the registration store page
    set selenium implicit wait            20s
    set selenium speed                    0.4

    wait until element is visible           //button/span[contains(text(),'Next')]        50

    scroll element into view                //button/span[contains(text(),'Next')]
    sleep    2
    click element                           //button/span[contains(text(),'Next')]

    sleep    2
    wait until element is visible           //button/span[contains(text(),'Skip')]        50

    repeat keyword      3 times         execute javascript        window.scrollTo(0,document.body.scrollHeight)
    sleep       2
    click element       //button/span[contains(text(),'Skip')]

Select the Payment Option and click on Continue button
    set selenium implicit wait            20s
    set selenium speed                    0.4

    wait until element is visible           //div[@class='payment-option']/span         50

    click element       //div[@class='payment-option']/span
    sleep      2
    click element       //button/span[contains(text(),'Select')]

    sleep       2

    scroll element into view        //button/span[contains(text(),'Continue')]
    sleep       2
    click element       //button/span[contains(text(),'Continue')]

From Checkout page Complete the Order
    set selenium implicit wait            20s
    set selenium speed                    0.4

    wait until element is visible    //span/mat-panel-title[contains(text(),'Coupon Code')]     100
    repeat keyword      2 times     scroll element into view    (//*[@class="mat-radio-button mat-primary"])[2]/label/div[1]
    sleep       3
    click element       (//*[@class="mat-radio-button mat-primary"])[2]/label/div[1]

    sleep       2
    scroll element into view            //div/mat-select[@formcontrolname="paymentMethod"]
    sleep       1
    click element                       //div/mat-select[@formcontrolname="paymentMethod"]
    sleep       1
    click element                       //mat-option/span[contains(text(),'Credit Card')]
    sleep       10

    select frame                //iframe[@id='sp-js-api']

    sleep       1
    wait until element is visible       //div/input[@placeholder="Your card number"]          100
    scroll element into view            //div/input[@placeholder="Your card number"]

    input text              //div/input[@placeholder="Your Name"]       ${CardHolderName}
    sleep       1
    input text              //div/input[@placeholder="Your card number"]    ${CardNumber}
    sleep       1
    input text              //div/input[@placeholder="MM/YY"]           ${Expiration}
    sleep       1
    input text              //div/input[@placeholder="CVV"]             ${Cvv}
    sleep       1
    input text              //div/input[@placeholder="ZIP"]             ${Zip Code}
    sleep       1

    unselect frame

    scroll element into view        //mat-checkbox[@name="termsAndConditions"]/label/div
    sleep       1
    click element           //mat-checkbox[@name="termsAndConditions"]/label/div
    sleep       1
    click element           //button[@id="submitBtn"]
