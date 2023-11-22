package main

import (
	"errors"
	"fmt"
	"net/http"
	"path"

	"github.com/gin-gonic/gin"
)

KeyWords := []string{"門診", "覆診", "小學"}

func wordInString(word string, str string) bool {
	return strings.Contains(str, word)
}

func main() {
	println("BACKEND_ENV: " + BACKEND_ENV)
	router := gin.Default()
	router.Use(CORSMiddleware())

	router.POST("/", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"message": "Welcome to the EventChat's Backend ",
		})
	})

	router.POST("/ask", func(c *gin.Context) {

		

		anscall := Call{}
		askcall := Call{}
		
		
		
		if err := c.ShouldBindJSON(&askcall); err != nil {
			c.Error(err)
			c.Abort()
			return
		}
		if askcall.Data.Chat == "" {
			c.Error(errors.New("Question is empty"))
			return
		}
		
		api_key := c.Query("api_key")
		var path string 
		
		path = "/ask"
		
		// testing for map or general
		for _, word := range KeyWords {
			if wordInString(word, askcall.Data.Chat) {
				path = "/ask-map"
				
			}
		}
		
		
		
		anscall, err := AskChatbot(askcall, path, api_key)
		if err != nil {
			c.Error(err)
			c.Abort()
			return
		}
		println("API Key: " + c.Query("api_key"))
		println("USER ID: " + askcall.UserID)
		println("Question: " + askcall.Data.Chat)
		println("Kind: " + askcall.Data.Kind)
		println("Coordinates: " + fmt.Sprint(askcall.Data.Coordinates))
		println("Response: " + anscall.Data.Chat)
		c.JSON(200, anscall)
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
