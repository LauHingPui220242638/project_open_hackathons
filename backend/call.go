package main

type Call[D Data] struct {
	APIKey string `json:"api_key"`
	Data D `json:"data"`
}

type Data interface{
	Ask | Ans 
}

type Ask struct {
	Question string `json:"question"`
}

type Ans struct {
	Response string `json:"response"`
}
