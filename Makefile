run:
	source ./.env && iex -S mix run --no-halt

build:
	source ./.env && ./script/build
