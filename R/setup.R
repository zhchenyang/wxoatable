library(wxoa)

appid = rstudioapi::askForSecret("appid")
appsecret = rstudioapi::askForSecret("appsecret")

APPID(appid)
APPSecret(appsecret)

# update user cumulate

get_token()

update_data(append = "data/getusercumulate.csv")
