run:
	source ./.env.dev && iex -S mix run --no-halt

build:
	DB=/home/pi/weather_data/weather_data.db ./script/build
