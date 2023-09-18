package main

import (
	"fmt"
	"os/exec"
)

func Greeting(){
    app := "echo"
    arg0 := "-e"
    arg1 := "C I / C D"
    arg2 := "\n\tby"
    arg3 := "Leo Lau"
    cmd := exec.Command(app, arg0, arg1, arg2, arg3)
   
	stdout, err := cmd.Output()
    if err != nil {
        fmt.Println(err.Error())
        return
    }

    fmt.Println(string(stdout))
}
