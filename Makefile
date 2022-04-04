.SILENT: ;               # no need for @

release: build

build:
	echo "Compiling for the Pi"
	GOOS=linux GOARCH=arm go build -o bin/weatherd-arm main.go
