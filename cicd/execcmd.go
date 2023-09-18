package main

import (
	"fmt"
	"os/exec"
	"strings"
)

func ExecCmd(app string, frame string) (string, error) {
	token := strings.Split(frame, " ")
	cmd :=	exec.Command(app, token...)
	output, err := cmd.CombinedOutput()
	fmt.Println(string(output))
	
	return string(output), err
}