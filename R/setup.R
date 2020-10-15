library(wxoa)

appid = rstudioapi::askForSecret("appid")
appsecret = rstudioapi::askForSecret("appsecret")

APPID(appid)
APPSecret(appsecret)

df = rio::import("data/getusercumulate.csv")
start_date = as.Date(tail(df$ref_date, 1))+1

get_token()

data = get_data(keyword = "getusercumulate", start = start_date, append = "data/getusercumulate.csv")
# append works
