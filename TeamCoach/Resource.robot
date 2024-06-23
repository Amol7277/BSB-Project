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
${prg_name}     09_06_TC 3


#Division 1 Variables
${Div1_Name}      PPT Div
${Div1_Price}      10000
${Div1_reg_startdate}     06/10/2024
${Div1_reg_closedate}     06/30/2024
${Div1_seasonstart}      06/15/2024
${Div1_seasonend}        07/10/2024
${Div1_oldage}           1/1/2000
${Div1_youngdate}        1/1/2015

#Division 2 Variables
${Div2_Name}      PPT Div
${Div2_Price}      10000
${Div2_reg_startdate}     06/10/2024
${Div2_reg_closedate}     06/30/2024
${Div2_seasonstart}      06/15/2024
${Div2_seasonend}        07/10/2024
${Div2_oldage}           1/1/2000
${Div2_youngdate}        1/1/2015


*** Keywords ***