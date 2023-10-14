package main

import (
	"net/http"
	"net/url"
	"bytes"
    "encoding/json"
)

func AskChatbot(ask Call[Ask], apikey string) (Call[Ans], error){
	var ans Call[Ans]
	

	// data := url.Values{}
	// data.Set("name", "foo")
	// data.Set("surname", "bar")
	
	apiurl := urlTemplate(LANCHAIN_GATEWAY_URL, "/ask", apikey)
	
	
	requestBodyBytes, err := json.Marshal(ask)
	req, err := http.NewRequest("POST", apiurl, bytes.NewBuffer(requestBodyBytes))
	if err != nil {
		return ans, err
	}
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Accept", "application/json")
	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		return ans, err
	}
	
	println(resp.Status)
	err = json.NewDecoder(resp.Body).Decode(&ans)
	if err != nil {
		return ans, err
	}
	return ans, err
}



func urlTemplate(domain string, path string, api_key string) string  {
	u, _ := url.ParseRequestURI(domain)
	u.Path = path
	q := u.Query()
	q.Add("api_key", api_key)
	u.RawQuery = q.Encode()
	return u.String() 
}