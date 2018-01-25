# Objective
This project was created to for myself to learn RoR. It is intended to be ran alongside training-demo-frontend on a different port

# Key Areas of Research
1. RoR
1. Devise_Token_Auth

# Key points
1. Backend in RoR API mode, uses Devise_Token_Auth to manage user login
1. Testing done for each function and each model. Checks for things like request when not log in or a request for a resource that a user isn't permitted to access

# Known issues
1. Single item pages use data from the array rather than requesting from server again because the show function returns 500 rather than 200 (even on postman and on test)
1. Devise Token Auth is config-ed to not create a new token for each request