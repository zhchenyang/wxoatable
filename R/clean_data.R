usercumulate  = rio::import("data/getusercumulate.csv")
userread = rio::import("data/getuserread.csv")
usersummary = rio::import("data/getusersummary.csv")


trans <- function(vectors, type) {

  if (type == "userread.usersource") {
    tmp = setNames(
      c("全部", "会话", "好友", "朋友圈", "腾讯微博","历史消息页", "其他", "看一看", "搜一搜"),
      c(99999999,0:7)
    )

    out = unname(tmp[as.character(vectors)])
  }

  return(out)
}


