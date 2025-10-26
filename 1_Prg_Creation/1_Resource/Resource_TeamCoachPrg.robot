*** Settings ***
Library     SeleniumLibrary
Library     DateTime


*** Variables ***
#Web site & Browser Varibles
#${URL}      https://leagues.bluesombrero.com/default.aspx?portalid=9003
${URL}      https://stagingsports.bsbtest.com/default.aspx?portalid=8575
${browser}      chrome
#${browser}      Firefox

#Login ID variables
${User_ID}          amol.sonar+superadmin@stacksports.com
${Pwd}              Test@1234

#Program Name Variable
${Activity}     Baseball
${TC_Program_Name}     TC -

${current_date}

${TC_Div1_Name}      PPT Div
${TC_Div2_Name}      PPP Div
${TC_Div3_Name}      Free Agent

${Div_Price}      10000
${Div_oldage}           1/1/2000
${Div_youngdate}        1/1/2015

#Custom Team Staff Name
${Vol_Name}       Volunteer-



#*** Keywords ***
#Registration Start & Close date
#    ${current_date}      get current date        result_format=%Y-%m-%d
#
#    ${Div_regi_startdate}=    Add Time To Date    ${current_date}    -3 days    result_format=%m-%d-%Y
#    log to console    Registration Start - ${Div_regi_startdate}
#
#    ${Div_regi_closedate}=    Add Time To Date    ${current_date}    30 days    result_format=%m-%d-%Y
#    log to console   Registration Close - ${Div_regi_closedate}
#
#
#Season Start & End Date
#    ${current_date}      get current date        result_format=%Y-%m-%d
#
#    ${Div_SeasonStart}=    Add Time To Date    ${current_date}    2 days    result_format=%m-%d-%Y
#    log to console    Season Start - ${Div_seasonstart}
#
#    ${Div_SeasonEnd}=    Add Time To Date    ${current_date}     45 days    result_format=%m-%d-%Y
#    log to console    Season End - ${Div_SeasonEnd}
#
#EarlyBirth Discount
#    ${current_date}      get current date        result_format=%Y-%m-%d
#
#    ${EarlyBird_Date}=    Add Time To Date    ${current_date}    5 days    result_format=%m-%d-%Y
#    log to console  EarlyBird Discount Date - ${EarlyBird_Date}
#
#Late Fee
#    ${current_date}      get current date        result_format=%Y-%m-%d
#
#    ${LateFee_Date}=    Add Time To Date    ${current_date}    -2 days    result_format=%m-%d-%Y
#    log to console   Late Fee Date - ${LateFee_Date}