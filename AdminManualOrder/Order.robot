*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${UserName}     amol.sonar+superadmin@stacksports.com
${Password}     Test@1234

${Go to URL}    https://registration.bluesombrero.com/9003/order-summary?userId=86714206

${CardHolderName}   Test Amol
${CardNumber}       4111111111111111
${Expiration}       1030
${Cvv}              123
${Zip Code}         90033


*** Test Cases ***
Order
    Open the browser and open the URL
    Login the Admin Account
    Go to the Order - Summary


*** Keywords ***
Open the browser and open the URL
    Open Browser                    https://leagues.bluesombrero.com/default.aspx?portalid=9003     Chrome
    maximize browser window

Login the Admin Account
    sleep       2
    click element                              dnn_dnnLOGIN_cmdLogin
    wait until element is visible              email
    input text                                 Name:email                      ${UserName}
    click element                              Name:continue
    wait until element is visible              password                        20
    input password                             Name:password                   ${Password}
    click element                              Name:continue

Go to the Order - Summary
    set selenium implicit wait            20s
    set selenium speed                    0.4

    wait until element is visible           //div/span[contains(text(),'Dashboard')]        200

    go to       ${Go to URL}

    wait until element is visible       //span[contains(text(),' Payment Options')]     100

    ${payment_options}      get webelements         //div[@class="payment-option"]
    ${index}=   set variable    1
    FOR     ${opt}      IN      @{payment_options}
        click element       ${opt}
        sleep    1
        click element       //div[contains(text(),'Payment Plans')]
        sleep    1
        click element       //button/span[contains(text(),'Select')]
        sleep    1
    END
    sleep    1
    click element       //button/span[contains(text(),'Continue')]

    wait until element is visible    //span/mat-panel-title[contains(text(),'Coupon Code')]     100

    repeat keyword      2 times     scroll element into view    (//*[@class="mat-radio-button mat-primary"])[2]/label/div[1]

    sleep       3

#    click element       //button/span[contains(text(),'Apply')]
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

    repeat keyword     2 times      scroll element into view        //mat-checkbox[@name="termsAndConditions"]/label/div
    sleep       1
    click element           //mat-checkbox[@name="termsAndConditions"]/label/div
    sleep       1
    log to console          Order Submit
#    click element           //button[@id="submitBtn"]