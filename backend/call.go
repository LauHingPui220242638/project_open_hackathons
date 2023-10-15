package main

type Call[D Data] struct {
	UserID string `json:"user_id"`
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
