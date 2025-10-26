*** Settings ***
Library         SeleniumLibrary

*** Variables ***
${URL}      https://stagingsports.bsbtest.com/default.aspx?portalid=8575
#${URL}      https://leagues.bluesombrero.com/default.aspx?portalid=9003
${browser}      chrome
#${browser}      firefox

${User_ID}       amol.sonar+superadmin@stacksports.com
${Pwd}          Test@1234

${Activity}         Basketball

#Program Names
${Free_Program_Name}     Free -
${NT_Program_Name}       NT -
${TO_Program_Name}     TO -
${TC_Program_Name}     TC -

#Division Names
#    Free Program Division Names
${Free_Div1_Name}            Division1
${Free_Div2_Name}            Waitlist Division

#    Non Tryout Division Names
${NT_Div1_Name}              Div 1
${NT_Div2_Name}              Waitlist Div

#    Tryout Division Names
${TO_Div1_Name}              Div 1
${TO_Div2_Name}              Div 2

#    Team Coach Division Names
${TC_Div1_Name}              PPT Div
${TC_Div2_Name}              PPP Div
${TC_Div3_Name}              Free Agent

${Div_Price}                 10000
${OldDate}                   01/01/2000
${YoungDate}                 01/01/2015

${Tryout_Fee}                1000

${EarlyBird_DD}              1000
${LateFee_DF}                1000
${EMI-1}                     3300
${EMI-2}                     3300
${EMI-3}                     3400

${DL-Dis}                    1000
${DL-Fee}                    1000
${DL-MFee}                   1000

${Deposit}                   5000
${installmentFee}            1000

${FamilyDis}                 1000
${VolumeDis}                 1000
${ResidentDis}               1000

${PL-Dis}                    1000
${PL-Fee}                    1000
${PL-MFee}                   1000

${Vol_Name}                  Volunteer -


*** Keywords ***
Open the browser and open the URL
    open browser    ${URL}      ${browser}
    maximize browser window

Login in the Portal
    [Arguments]    ${UserName}      ${Password}
    set selenium implicit wait            20s
    set selenium speed                    0.4

    run keyword and continue on failure     click element       ID:dnn_dnnLOGINLL_cmdLogin
    run keyword and continue on failure     click element       ID:dnn_dnnLOGIN_cmdLogin
    wait until element is visible         email
    input text                            Name:email                      ${UserName}
    click element                         Name:continue
    wait until element is visible         password
    input password                        Name:password                   ${Password}
    click element                         Name:continue

Handle One Trust Popup
    set selenium implicit wait            20s
    set selenium speed                    0.4
    run keyword and continue on failure    wait until element is visible        //button[@id='onetrust-accept-btn-handler']     50
    run keyword and continue on failure     click element       //button[@id='onetrust-accept-btn-handler']