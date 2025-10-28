*** Settings ***
Library     SeleniumLibrary


*** Variables ***
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
    Go to the Admin manual page & Search the User
    Click on the available program button
    Select the View Division for Multiple Players

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

Select the View Division for Multiple Players

    set selenium implicit wait            20s
    set selenium speed                    0.4

    @{Players}=     create list     P1 of 1410      P3 of 1410
#    ${AvailPrgforPlayer}=     get webelements     //h3[@class='programs-available']
#    ${index}=   set variable    1
    FOR    ${ply}    IN    @{Players}
        sleep    1
        repeat keyword      3 times     scroll element into view    //h3[contains(text(),'${ply}')]
        sleep    1
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    //mat-expansion-panel-header[@role='button']/span/p[2]/span
        log     ${is_visible}
        Run Keyword Unless    ${is_visible}    Click Element    //h3[contains(text(),'${ply}')]

#        click element    //h3[contains(text(),'${ply}')]
#        sleep    1
#        click element    //h3[contains(text(),'${ply}')]

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
                sleep    1
                scroll element into view    ${Div}
                sleep    1
                Log     ${Div.text}
                Exit For Loop If    '${Division_Name}' == '${Div.text}'
                ${index2}=   evaluate    ${index2} + 1
                Log    ${index2}
            END
            sleep       1
            scroll element into view    (//button/span[contains(text(),'Select')])[${index2}]
            sleep       1
            click element    (//button/span[contains(text(),'Select')])[${index2}]
            sleep       5
#            repeat keyword      3 times         execute javascript        window.scrollTo(0,document.body.scrollHeight)
#            repeat keyword      3 times         scroll element into view    //button/span[contains(text(),'Next Player')]
#            sleep       3
#            click element       //button/span[contains(text(),'Next Player')]
            click element    //h3[contains(text(),'${ply}')]

#            sleep       3
#            ${Status}  run keyword and return status    element should be visible     //mat-expansion-panel-header[@role ='button']/span/p[2]/span
#            run keyword if     ${Status}=='True'    click element    //h3[contains(text(),'${ply}')]
    END


Select the View Division
    set selenium implicit wait            20s
    set selenium speed                    0.4

    wait until element is visible           //mat-expansion-panel-header[@role ='button']/span/p[2]/span       100

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