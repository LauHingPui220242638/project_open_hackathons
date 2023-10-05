package main

import (
	// "fmt"

	"net/http"
	"github.com/gin-gonic/gin"
)

type Ask struct {
	Question string `json:"question"`
}

type Answer struct {
	Response string `json:"response"`
}

func main() {
	router := gin.Default()
	router.Use(CORSMiddleware())
	
	router.GET("/", func (c *gin.Context){
		c.JSON(http.StatusOK, gin.H{
			"message": "pong",
		})
	})

	router.POST("/ask", func(c *gin.Context) {

		var ask Ask
		var answer Answer

		answer.Response = "I am Fine!!"
		
		if err := c.ShouldBindJSON(&ask); err != nil {
			c.Error(err)
			c.Abort()
			return
		}
		println("Question: " + ask.Question)
		println("Response: " + answer.Response)
		c.JSON(200, answer)
	})

	router.Run(":8080")
}

func CORSMiddleware() gin.HandlerFunc {
    return func(c *gin.Context) {
        c.Writer.Header().Set("Access-Control-Allow-Origin", "*")
        c.Writer.Header().Set("Access-Control-Allow-Credentials", "true")
        c.Writer.Header().Set("Access-Control-Allow-Headers", "Content-Type, Content-Length, Accept-Encoding, X-CSRF-Token, Authorization, accept, origin, Cache-Control, X-Requested-With")
        c.Writer.Header().Set("Access-Control-Allow-Methods", "POST, OPTIONS, GET, PUT")

        if c.Request.Method == "OPTIONS" {
            c.AbortWithStatus(204)
            return
        }

        c.Next()
    }
}