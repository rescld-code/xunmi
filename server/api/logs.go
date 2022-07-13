package api

import (
	"net/http"
	"xunmi/global"
	"xunmi/model"

	"github.com/gin-gonic/gin"
)

func LoginHistory(c *gin.Context) {
	uid := c.Query("uid")

	var logs []model.Log

	defer abort(c)

	result := global.DB.Order("id desc").Find(&logs, "uid = ?", uid)
	if result.Error != nil {
		panic(result.Error)
	}

	var time []string
	for _, log := range logs {
		time = append(time, log.CreatedAt.Format("2006-01-02 15:04:05"))
	}

	c.JSON(http.StatusOK, gin.H{
		"code":    0,
		"message": "OK",
		"times":   time,
	})
	c.Next()
}
