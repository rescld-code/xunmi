package api

import (
	"net/http"
	"xunmi/utils"

	"github.com/gin-gonic/gin"
)

func SmsSignUp(c *gin.Context) {
	telphone := c.Query("tel")
	captcha := c.Query("captcha")

	defer func() {
		if err := recover(); err != nil {
			c.JSON(http.StatusOK, &gin.H{
				"code":    -1,
				"message": "failed",
			})
			c.Abort()
		}
	}()

	// 查询原数据
	// var user model.User
	// result := global.DB.First(&user, "telphone = ?", telphone)
	// if result.Error != nil {
	// 	panic(result.Error)
	// }

	res := utils.VerifyMobileFormat(telphone)
	if res {
		utils.SmsSignUp(telphone, captcha)
		c.JSON(http.StatusOK, &gin.H{
			"code":    0,
			"message": "OK",
		})
		c.Next()
	} else {
		c.JSON(http.StatusOK, &gin.H{
			"code":    -1,
			"message": "Failed",
		})
		c.Next()
	}
}
