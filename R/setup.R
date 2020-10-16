library(wxoa)

appid = rstudioapi::askForSecret("appid")
appsecret = rstudioapi::askForSecret("appsecret")

APPID(appid)
APPSecret(appsecret)

# update user cumulate

get_token()

update_data(append = "data/getusershare.csv")
update_data(append = "data/getuserread.csv")

