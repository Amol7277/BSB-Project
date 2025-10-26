*** Settings ***
Library     SeleniumLibrary


*** Variables ***
#Web site & Browser Varibles
#${URL}      https://leagues.bluesombrero.com/default.aspx?portalid=9003
${URL}      https://stagingsports.bsbtest.com/default.aspx?portalid=8575
${browser}      chrome

#Login ID variables
${User_ID}          amol.sonar+superadmin@stacksports.com
${Pwd}              Test@1234

#Program Name Variable
${Activity}     Baseball
${TO_Program_Name}     TO -

#Division 1 Variables
${TO_Div1_Name}      Div 1
${TO_Div2_Name}      Div 2

${Div_Price}                 10000
${OldDate}                   01/01/2000
${YoungDate}                 01/01/2015


${Vol_Name}                  Volunteer -