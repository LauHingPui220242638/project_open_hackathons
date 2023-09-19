package main

import (
	"fmt"
	"os"
)

func main(){
	Greeting()
	args := os.Args
	err := CheckApp(args)
	if err != nil {
		fmt.Println(err.Error())
		return 
	}
	
	app := args[1]
	
	switch app {
	case "gitpush":
		GitPush(args)
	case "gfunc":
		GFunc(args)
	default:
		err := CheckEnd(args)
		fmt.Println(err.Error())		
	}
    

    

}



