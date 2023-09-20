package main

import (
	"errors"
)

func CheckNum(args []string, num int, prompt string) error {
	if num > len(args)  {
		return errors.New(prompt)

	}
	return nil
}



func CheckEnd(precmd string, prompt string) error {
	return errors.New("unknown command " + precmd + prompt)
}
