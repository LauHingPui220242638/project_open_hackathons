package main

import (
	"fmt"
	"os/exec"
	"strings"
)

func ExecCmdMulti(frames [][]string){
	for _, frame := range frames {
		
		_, err := ExecCmd(frame[0], frame[1])
		if err != nil {
			fmt.Println(err.Error())
			return
		}	
		
	}
}


func ExecCmd(app string, frame string) (string, error) {
	token := strings.Split(frame, " ")
	cmd :=	exec.Command(app, token...)
	output, err := cmd.CombinedOutput()
	fmt.Println(string(output))
	
	return string(output), err
}