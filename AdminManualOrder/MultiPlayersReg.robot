*** Settings ***
Library     SeleniumLibrary
Library    Collections


*** Variables ***
${implecit_wait}        20s
${selenium_speed}       0.4



${URL}          https://leagues.bluesombrero.com/default.aspx?portalid=9003
${Browser}      chrome
${User_ID}      amol.sonar+superadmin@stacksports.com
${Pwd}          Test@1234
${AdminManualOrderURL}      https://leagues.bluesombrero.com/Default.aspx?tabid=675705
${UserName}         Rock1410, Rock1410

${Player_Name}      P1 Of 1410 Prod
${Program_Name}     NT_15_10_2025
${Division_Name}    AA

${CardHolderName}   Test Amol
${CardNumber}       4111111111111111
${Expiration}       1030
${Cvv}              123
${Zip Code}         90033

*** Test Cases ***
Multiple Players - Admin Manual Order
    Open the browser and login as superadmin
#    Test 1
    Go to the Admin manual page & Search the User
    Click on the available program button
#    Test
    Select the View Division for Multiple Players
    Continue from the program questions page
    Skip from the Volunteer Listing page
    Skip the registration store page
#    Select the Payment Option and click on Continue button


*** Keywords ***
Open the browser and login as superadmin
    set selenium implicit wait      ${implecit_wait}
    set selenium speed              ${selenium_speed}

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
    set selenium implicit wait      ${implecit_wait}
    set selenium speed              ${selenium_speed}

    wait until element is visible           //div/span[contains(text(),'Dashboard')]        100

    go to       ${AdminManualOrderURL}

    wait until element is visible           //a/span[contains(text(),'Select Account')]     150

    click element       //a/span[contains(text(),'Select Account')]
    sleep    2
    input text          //div/input[@placeholder="Search"]      ${UserName}
    sleep    2
    press keys            //div/input[@placeholder="Search"]     ENTER

Click on the available program button
    set selenium implicit wait      ${implecit_wait}
    set selenium speed              ${selenium_speed}

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

Test 1
   set selenium implicit wait      ${implecit_wait}
    set selenium speed              ${selenium_speed}


    wait until element is visible           //div/span[contains(text(),'Dashboard')]        100

    go to       https://registration.bluesombrero.com/9003/program-questions?userId=86714206&playerId=85338135

Test
    set selenium implicit wait      ${implecit_wait}
    set selenium speed              ${selenium_speed}


    wait until element is visible       //*[@class="programs-available"]    50

    ${player}=  get webelements    //*[@class="programs-available"]
    ${total_players}=    Get Length    ${player}
    Log To Console    Total Players Found: ${total_players}

        FOR     ${ply}      IN     @{player}
            log     ${ply.text}
            log to console    ${ply.text}
#            IF     ${ply.text}
        END

    ${last_player}=    Get From List    ${player}     -1
    Click Element    ${last_player}
    Sleep    1s

    ${is_skip_visible}=    Run Keyword And Return Status    Element Should Be Visible    (//button/span[contains(.,'Skip')])[4]
    repeat keyword    3     scroll element into view        (//button/span[contains(.,'Skip')])[4]
    Run Keyword If    ${is_skip_visible}    Click Element    (//button/span[contains(.,'Skip')])[4]
    ...    ELSE    Click Element    //button/span[contains(.,'Continue')]

Select the View Division for Multiple Players
    set selenium implicit wait      ${implecit_wait}
    set selenium speed              ${selenium_speed}

    @{Players}=     create list     P1 of 1410      P3 of 1410      P2 of 1410

    ${player}=  get webelements    //*[@class="programs-available"]
    ${total_players}=    Get Length    ${player}
    Log To Console    Total Players Found: ${total_players}

    FOR    ${ply}    IN    @{Players}
        sleep    1
#        repeat keyword      3 times     scroll element into view    //h3[contains(text(),'${ply}')]
        scroll element into view        //h3[contains(text(),'${ply}')]
        sleep    1
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    //mat-expansion-panel-header[@role='button']/span/p[2]/span
        log     ${is_visible}
        Run Keyword Unless    ${is_visible}    Click Element    //h3[contains(text(),'${ply}')]

        #Findings for Available Programs
        wait until element is visible           //mat-expansion-panel-header[@role ='button']/span/p[2]/span       100

        ${Programs}=     get webelements        //mat-expansion-panel-header[@role ='button']/span/p[2]/span
        ${index1}=   set variable    1

        FOR    ${Prg}    IN    @{Programs}
            sleep    1
            scroll element into view    ${Prg}
            sleep    1
            Log     ${Prg.text}
            Exit For Loop If    '${Program_Name}' == '${Prg.text}'
            ${index1}=   evaluate    ${index1} + 1
            Log    ${index1}
        END
        scroll element into view    (//button/span[contains(text(),'View Divisions')])[${index1}]
        click element    (//button/span[contains(text(),'View Divisions')])[${index1}]

        #Findings for Available Divisions
        wait until element is visible            //mat-card-title[@class='mat-card-title']/div      100

        ${Divisions}=     get webelements        //mat-card-title[@class='mat-card-title']/div
        ${index2}=   set variable    1

            FOR    ${Div}    IN    @{Divisions}
#                sleep    1
                scroll element into view    ${Div}
#                sleep    1
                Log     ${Div.text}
                Exit For Loop If    '${Division_Name}' == '${Div.text}'
                ${index2}=   evaluate    ${index2} + 1
                Log    ${index2}
            END
            sleep       1
            scroll element into view    (//button/span[contains(text(),'Select')])[${index2}]
            sleep       1
            click element    (//button/span[contains(text(),'Select')])[${index2}]

            wait until element is visible       //h3[contains(text(),'${ply}')]     20

            click element    //h3[contains(text(),'${ply}')]

    END

    ${last_player}=    Get From List    ${player}     -1
    Click Element    ${last_player}
    Sleep    1s

    repeat keyword    3     scroll element into view        (//button/span[contains(.,'Skip')])[4]
    ${is_skip_visible}=    Run Keyword And Return Status    Element Should Be Visible    (//button/span[contains(.,'Skip')])[4]
    Run Keyword If    ${is_skip_visible}    Click Element    (//button/span[contains(.,'Skip')])[4]
    ...    ELSE    Click Element    //button/span[contains(.,'Continue')]

Continue from the program questions page
    set selenium implicit wait      ${implecit_wait}
    set selenium speed              ${selenium_speed}

    ${Players}=     get webelements     //span[@class='name-label notranslate']

    ${index1}=   set variable    1
    FOR     ${ply}      IN    @{Players}
        sleep       2
        ${is_next_visible}=    Run Keyword And Return Status    Element Should Be Visible    (//button/span[contains(.,"Next Player")])[${index1}]
        Run Keyword If    ${is_next_visible}    Click Element    (//button/span[contains(.,"Next Player")])[${index1}]
        ...    ELSE    Click Element    //button/span[contains(.,'Continue')]

        ${index1}=   evaluate    ${index1} + 1
        log to console      ${index1}
    END

Skip from the Volunteer Listing page
    set selenium implicit wait      ${implecit_wait}
    set selenium speed              ${selenium_speed}

    wait until element is visible           //button/span[contains(text(),'Skip')]        50

    repeat keyword      3 times         execute javascript        window.scrollTo(0,document.body.scrollHeight)
    sleep       2
    click element       //button/span[contains(text(),'Skip')]

Skip the registration store page
    set selenium implicit wait      ${implecit_wait}
    set selenium speed              ${selenium_speed}

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


