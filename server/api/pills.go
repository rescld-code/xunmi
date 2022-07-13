package api

import (
	"fmt"
	"net/http"
	"strconv"
	"xunmi/global"
	"xunmi/model"

	"github.com/gin-gonic/gin"
)

func format(c *gin.Context) model.Pills {
	fmt.Println(c.PostForm("privacy"))
	uid, err := strconv.Atoi(c.PostForm("uid"))
	if err != nil {
		panic(err)
	}

	privacy, err := strconv.ParseBool(c.PostForm("privacy"))
	if err != nil {
		panic(err)
	}

	latitude, err := strconv.ParseFloat(c.PostForm("latitude"), 64)
	if err != nil {
		panic(err)
	}

	longitude, err := strconv.ParseFloat(c.PostForm("longitude"), 64)
	if err != nil {
		panic(err)
	}

	text := c.PostForm("text")
	theme := c.PostForm("theme")

	return model.Pills{
		Uid:       uint(uid),
		Theme:     theme,
		Latitude:  latitude,
		Longitude: longitude,
		Text:      text,
		Privacy:   privacy,
	}
}

func PutPills(c *gin.Context) {
	defer func() {
		if err := recover(); err != nil {
			fmt.Println(err)
			c.JSON(http.StatusOK, &gin.H{
				"code":    -1,
				"message": "Failed",
			})
			c.Abort()
		}
	}()

	pills := format(c)

	result := global.DB.Create(&pills)
	if result.Error != nil {
		panic(result.Error)
	}

	c.JSON(http.StatusOK, gin.H{
		"code":    0,
		"message": "OK",
	})
}

func GetPills(c *gin.Context) {
	defer func() {
		if err := recover(); err != nil {
			fmt.Println(err)
			c.JSON(http.StatusOK, &gin.H{
				"code":    -1,
				"message": "Failed",
			})
			c.Abort()
		}
	}()

	id, err := strconv.Atoi(c.Query("id"))
	if err != nil {
		panic(err)
	}

	if id == -1 {
		getAllPills(c)
	} else {
		getPills(c)
	}
}

func getPills(c *gin.Context) {
	id := c.Query("id")

	var pills model.Pills
	result := global.DB.First(&pills, id)
	if result.Error != nil {
		panic(result.Error)
	}

	c.JSON(http.StatusOK, gin.H{
		"code":  0,
		"pills": pills,
	})
}

func getAllPills(c *gin.Context) {
	var pills []model.Pills

	result := global.DB.Find(&pills)
	if result.Error != nil {
		panic(result.Error)
	}

	c.JSON(http.StatusOK, gin.H{
		"code":  0,
		"pills": pills,
	})
	c.Next()
}
