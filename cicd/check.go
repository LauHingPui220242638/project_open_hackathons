package main

import (
	"errors"
	
)


func CheckApp(args []string) error {
if len(args) < 2 {
		return errors.New(`
please enter:
	cicd gitpush <message>
		`)
		
	}
	return nil
}

func CheckEnd(args []string) error {
	return errors.New("unknown command " + args[1] + `
	please enter:
		cicd gitpush <message>
		cicd gfunc <command>
			`)
	}

func CheckThree(args []string, prompt string) error {
	if len(args) != 3 {
			return errors.New(prompt)
			
		}
		return nil
	}