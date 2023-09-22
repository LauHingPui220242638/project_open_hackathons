package main

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
)

func Build(args []string) {
	
	opath, err := os.Executable()
    if err != nil {
        panic(err)
    }
	dirpath := filepath.Dir(opath)
	cmd := exec.Command("go","build .")
	cmd.Dir = dirpath
	fmt.Println("cicd is sucessfully built")

}
