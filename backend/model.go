package main

type Call struct {
	UserID string `json:"user_id"`
	Data  `json:"data"`
}

type Data struct {
	Chat string `json:"chat"`
	Kind string `json:"kind"`
	Coordinates [3]float64 `json:"coordinates"`
}


// type Data interface {
// 	Ask | Ans 
	
// }


// type Ask struct {
// 	Question string `json:"question"`
// }

// type Ans struct {
// 	Response string `json:"response"`
// }
