*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary

*** Variables ***
${url_create_user}                            https://petstore.swagger.io/v2/user
${url_get_user_information}                   https://petstore.swagger.io/v2/user/TestApi001

${url_create/update_pet}                      https://petstore.swagger.io/v2/pet
${url_get_pet_information}                    https://petstore.swagger.io/v2/pet/293721


*** Test Cases ***
Creating a user, downloading information and deleting it
    Create user
    Get user by username
    Delete user

Adding a pet, updating its information and downloading information
    Add a new pet to the store
    Update an existing pet
    Finds Pets By Status



*** Keywords ***
Create user
    ${data_user}=    Load Json From File    create_user.json
    ${response_user}=    POST    ${url_create_user}    json=${data_user}    expected_status=200
    log    ${response_user.json()}
    Set Global Variable    ${data_user}

    Status Should Be    200    ${response_user}
    Should Be Equal As Strings    ${response_user.json()}[message]    ${data_user}[id]




Get user by username
    ${response_user_inf}=    GET    ${url_get_user_information}    expected_status=200
    Log    ${response_user_inf.json()}

    Status Should Be    200    ${response_user_inf}
    Should Be Equal As Strings    ${data_user}    ${response_user_inf.json()}



Delete user
    ${response_user_del}=    DELETE    https://petstore.swagger.io/v2/user/TestApi001    expected_status=200
    Log    ${response_user_del.json()}

    Status Should Be    200    ${response_user_del}
    Should Be Equal As Strings    ${response_user_del.json()}[message]    ${data_user}[username]



Add a new pet to the store
    ${data_pet}=    Load Json From File    add_pet.json
    ${response_pet}=    POST    ${url_create/update_pet}    json=${data_pet}    expected_status=200

    Status Should Be    200    ${response_pet}
    Should Be Equal As Strings    ${data_pet}    ${response_pet.json()}
    


Update an existing pet
    ${data_pet_update}=    Load Json From File    update_pet.json
    ${response_pet_upd}=    PUT    ${url_create/update_pet}    json=${data_pet_update}    expected_status=200
    Log    ${response_pet_upd}
    Set Global Variable    ${data_pet_update}

    Status Should Be    200    ${response_pet_upd}
    Should Be Equal As Strings    ${data_pet_update}    ${response_pet_upd.json()}
    


Finds Pets by Status
    ${response_pet_inf}=    GET    ${url_get_pet_information}    expected_status=200
    Log    ${response_pet_inf.json()}
    
    Status Should Be    200    ${response_pet_inf}
    Should Be Equal As Strings    ${data_pet_update}    ${response_pet_inf.json()}

    






