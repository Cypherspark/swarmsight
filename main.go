package main

import (
	"os"
	"text/template"
	"gopkg.in/yaml.v2"
	"io/ioutil"
)

type Config struct {
	Services []struct {
		Name        string `yaml:"name"`
		Port        int    `yaml:"port"`
		MetricsPath string `yaml:"metrics_path"`
	} `yaml:"services"`
}

func main() {
	configData, err := ioutil.ReadFile("services.yaml")
	if err != nil {
		panic(err)
	}

	var config Config
	err = yaml.Unmarshal(configData, &config)
	if err != nil {
		panic(err)
	}

	t, err := template.ParseFiles("prometheus.tpl")
	if err != nil {
		panic(err)
	}

	f, err := os.Create("prometheus.yaml")
	if err != nil {
		panic(err)
	}
	defer f.Close()

	err = t.Execute(f, config)
	if err != nil {
		panic(err)
	}
}