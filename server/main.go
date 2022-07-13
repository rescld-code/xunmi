package main

import (
	"xunmi/api"
	"xunmi/global"
	"xunmi/middle"
	"xunmi/model"

	"github.com/gin-gonic/gin"
)

func main() {
	// 初始化MySQL
	global.DB = model.InitDB()

	r := gin.New()

	v1 := r.Group("", middle.CORSMiddleware())
	{
		v1.GET("/sms", api.SmsSignUp)     // 发送手机验证码
		v1.GET("/logs", api.LoginHistory) // 获取登陆历史记录

		v1.POST("/signup", api.SignUp)           // 注册账号
		v1.POST("/signin", api.SignIn)           // 用户登陆
		v1.POST("/forget", api.ForgetPwd)        // 忘记密码
		v1.POST("/username", api.ChangeUsername) // 修改用户名
		v1.POST("/telphone", api.ChangeTelphone) // 修改手机号码
		v1.POST("/password", api.ChangePassword) // 修改密码

		v1.GET("/pills", api.GetPills)  // 获取胶囊信息，id=-1时返回所有数据
		v1.POST("/pills", api.PutPills) // 投放胶囊
	}

	r.Run()
}
