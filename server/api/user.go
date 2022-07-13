package api

import (
	"fmt"
	"net/http"
	"xunmi/global"
	"xunmi/model"
	"xunmi/utils"

	"github.com/gin-gonic/gin"
)

func SignUp(c *gin.Context) {
	// 提取参数
	username := c.PostForm("username")
	password := c.PostForm("password")
	telphone := c.PostForm("telphone")

	// 格式化对象
	user := &model.User{
		Username: username,
		Password: password,
		Telphone: telphone,
	}

	// 创建失败
	defer abort(c)

	// 新建用户
	result := global.DB.Create(&user)
	if result.Error != nil {
		panic(result.Error)
	}

	// 创建成功
	c.JSON(http.StatusOK, &gin.H{
		"code":    0,
		"message": "OK",
	})
	c.Next()
}

func SignIn(c *gin.Context) {
	// 提取参数
	username := c.PostForm("username")
	password := c.PostForm("password")

	user := &model.User{}

	// 创建失败
	defer abort(c)

	// 匹配账号密码
	result := global.DB.First(&user, "username = ? and password = ?", username, password)
	if result.Error != nil {
		panic(result.Error)
	}

	// 添加历史记录
	result = global.DB.Create(&model.Log{
		Uid: user.ID,
	})
	if result.Error != nil {
		panic(result.Error)
	}

	// 匹配成功
	c.JSON(http.StatusOK, &gin.H{
		"code":     0,
		"message":  "OK",
		"uid":      user.ID,
		"username": user.Username,
		"telphone": user.Telphone,
	})
	c.Next()
}

func ForgetPwd(c *gin.Context) {
	// 提取参数
	password := c.PostForm("password")
	telphone := c.PostForm("telphone")

	if !utils.VerifyMobileFormat(telphone) {
		abort(c)
	}

	defer abort(c)

	// 查询原数据
	var user model.User
	result := global.DB.First(&user, "telphone = ?", telphone)
	if result.Error != nil {
		panic(result.Error)
	}

	result = global.DB.Model(&user).Update("password", password)
	if result.Error != nil {
		panic(result.Error)
	}

	c.JSON(http.StatusOK, gin.H{
		"code":    0,
		"message": "OK",
	})
	c.Next()
}

func ChangeUsername(c *gin.Context) {
	uid := c.PostForm("uid")
	username := c.PostForm("username")

	defer abort(c)

	var user model.User
	result := global.DB.First(&user, uid)
	if result.Error != nil {
		panic(result.Error)
	}

	result = global.DB.Model(&user).Update("username", username)
	if result.Error != nil {
		panic(result.Error)
	}

	c.JSON(http.StatusOK, gin.H{
		"code":    0,
		"message": "OK",
	})
	c.Next()
}

func ChangePassword(c *gin.Context) {
	uid := c.PostForm("uid")
	password := c.PostForm("password")
	newPassword := c.PostForm("newPassword")

	defer abort(c)

	var user model.User
	result := global.DB.First(&user, uid)
	if result.Error != nil {
		panic(result.Error)
	}

	if user.Password == password {
		result = global.DB.Model(&user).Update("password", newPassword)
		if result.Error != nil {
			panic(result.Error)
		}
		c.JSON(http.StatusOK, gin.H{
			"code":    0,
			"message": "OK",
		})
		c.Next()
	} else {
		c.JSON(http.StatusOK, gin.H{
			"code":    -1,
			"message": "Failed",
		})
		c.Abort()
	}
}

func ChangeTelphone(c *gin.Context) {
	uid := c.PostForm("uid")
	telphone := c.PostForm("telphone")
	fmt.Println(telphone)

	if !utils.VerifyMobileFormat(telphone) {
		c.JSON(http.StatusOK, &gin.H{
			"code":    -1,
			"message": "Failed",
		})
		c.Abort()
	}

	defer abort(c)

	var user model.User
	result := global.DB.First(&user, uid)
	if result.Error != nil {
		panic(result.Error)
	}

	result = global.DB.Model(&user).Update("telphone", telphone)
	if result.Error != nil {
		panic(result.Error)
	}

	c.JSON(http.StatusOK, gin.H{
		"code":    0,
		"message": "OK",
	})
	c.Next()
}

func abort(c *gin.Context) {
	if err := recover(); err != nil {
		c.JSON(http.StatusOK, &gin.H{
			"code":    -1,
			"message": "Failed",
		})
		c.Abort()
	}
}
