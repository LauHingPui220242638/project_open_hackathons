package main

import (
	"fmt"
	"os"
	"path/filepath"
)

func Build(args []string) {
	dir, err := filepath.Abs(filepath.Dir(os.Args[0]))
    if err != nil {
            fmt.Println(err.Error())
    }
	
	opath := filepath.Join(dir,"cicd")
	frames := [][]string{
		[]string{"rm", opath},
		[]string{"go", "build -o " + opath + " ."},
	}

	ExecCmdMulti(frames)
	
	fmt.Println("cicd is sucessfully built!!")

}
