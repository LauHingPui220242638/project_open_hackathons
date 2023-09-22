package main

import (
	"errors"
	"fmt"
	"strings"
)

func GitB2M(args []string) {

	fmt.Println("the active branch:")
	cicd_activebranch, err := ExecCmd("git", "rev-parse --abbrev-ref HEAD")
	if err != nil {
		fmt.Println(err.Error())
		return
	}
	cicd_activebranch = strings.TrimSuffix(cicd_activebranch, "\n")
	if cicd_activebranch == "main" {
		fmt.Println(errors.New("branch cannot be main"))
		return
	}
	frames := [][]string{
		[]string{"git", "checkout " + cicd_activebranch},
		[]string{"git", "checkout main"},
		[]string{"git", "merge " + cicd_activebranch},
		[]string{"git", "checkout " + cicd_activebranch}}

	ExecCmdMulti(frames)

}
