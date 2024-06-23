*** Settings ***
Library     SeleniumLibrary


*** Variables ***
#Web site & Browser Varibles
${URL}      https://stagingsports.bsbtest.com/default.aspx?portalid=8575
${browser}      chrome

#Login ID variables
${ID}       amol.sonar+superadmin@stacksports.com
${Pwd}      Test@1234

#Program Name Variable
${Activity}     Baseball
${prg_name}     22_06_TC 5


#Division 1 Variables
${Div1_Name}      PPT Div
${Div1_Price}      10000
${Div1_reg_startdate}     06/20/2024
${Div1_reg_closedate}     07/15/2024
${Div1_seasonstart}      06/30/2024
${Div1_seasonend}        07/30/2024
${Div1_oldage}           1/1/2000
${Div1_youngdate}        1/1/2015

#Division 1 Advance *** Settings ***
${EarlyBirth_Date}      06/30/2024
${LateFee_Date}         06/21/2024


#Division 2 Variables
${Div2_Name}      PPP Div
${Div2_Price}      10000
${Div2_reg_startdate}     06/10/2024
${Div2_reg_closedate}     06/30/2024
${Div2_seasonstart}      06/15/2024
${Div2_seasonend}        07/10/2024
${Div2_oldage}           1/1/2000
${Div2_youngdate}        1/1/2015

#Division 2 Variables
${Div3_Name}      Free Agent
${Div3_Price}      10000
${Div3_reg_startdate}     06/10/2024
${Div3_reg_closedate}     06/30/2024
${Div3_seasonstart}      06/15/2024
${Div3_seasonend}        07/10/2024
${Div3_oldage}           1/1/2000
${Div3_youngdate}        1/1/2015

#Custom Team Staff Name
${CustomPos_Name}       Custom A4

*** Keywords ***