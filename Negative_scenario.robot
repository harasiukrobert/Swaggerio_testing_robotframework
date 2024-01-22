*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary

*** Variables ***
${url_get_user_information}             https://petstore.swagger.io/v2/user/31fdsg354v
${error_message}                        User not found

${url_upd_pet_information}             https://petstore.swagger.io/v2/pet/432
${error_message_upd}                   not found



*** Test Cases ***
Retrieving a user's information using their username
    Get user by username


Pet update in the store
    Update a pet in the story with format data


*** Keywords ***
Get user by username
    ${response_user_inf}=    GET    ${url_get_user_information}    expected_status=404
    Log    ${response_user_inf.json()}

    Should Be Equal As Strings    ${error_message}     ${response_user_inf.json()}[message]
    Status Should Be    404    ${response_user_inf}


Update a pet in the story with format data
    ${response_pet_upd}=    POST    ${url_upd_pet_information}    expected_status=404
    Log    ${response_pet_upd.json()}

    Should Be Equal As Strings    ${error_message_upd}     ${response_pet_upd.json()}[message]
    Status Should Be    404    ${response_pet_upd}


