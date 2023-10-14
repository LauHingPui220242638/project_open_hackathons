package main

import (
	"errors"
	"net/http"

	"github.com/gin-gonic/gin"
)


func main() {
	router := gin.Default()
	router.Use(CORSMiddleware())

	router.GET("/", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"message": "pong",
		})
	})

	router.POST("/ask", func(c *gin.Context) {

		

		
		var anscall Call[Ans]
		var askcall Call[Ask]
		if BACKEND_ENV == "DEV" {
			anscall.Data.Response = "I am Fine!! from DEV"
		}else{
			anscall.Data.Response = "I am Fine!! from PROD"
		}
		
		
		
		if err := c.ShouldBindJSON(&askcall); err != nil {
			c.Error(err)
			c.Abort()
			return
		}
		if askcall.Data.Question == "" {
			c.Error(errors.New("Question is empty"))
			return
		}
		
	
		
		// answer = askchatbot(ask)

		// resp, err := http.Get('https://api-gateway-7923qjyk.ue.gateway.dev')
		// if err != nil {
		// 	// handle error
		// }

		println("Question: " + askcall.Data.Question)
		println("Response: " + anscall.Data.Response)
		c.JSON(200, anscall)
	})

	router.Run(":8080")
}

// func askchatbot(ask Ask) Answer {
	
// 	answer := 
// 	return answer

// }



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
