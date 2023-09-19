package main

import (
	"fmt"
)

func GitPush(args []string)  {
	err := CheckThree(args, "message for commit must be sigle string")
	if err != nil {
		fmt.Println(err.Error())
		return
	}
	
	frames := []string{
		"fetch",
		"add -A",
		"commit -m" + args[2],
		"push"}
	
	for _, frame := range frames {
		
		_, err := ExecCmd("git", frame)
		if err != nil {
			fmt.Println(err.Error())
			return
		}	
		
	}
	
	
	
}
