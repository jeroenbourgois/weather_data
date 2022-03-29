run:
	source ./.env.dev && iex -S mix run --no-halt

release: build

build:
	DB=/home/pi/weather_data/weather_data.db PORT=80 ./script/build
