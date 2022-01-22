run:
	source ./.env.dev && iex -S mix run --no-halt

build:
	DB=/var/weather_data/weather_data.db ./script/build
