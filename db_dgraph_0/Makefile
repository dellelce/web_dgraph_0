# Testing & Building standalone service

NAME    = $$(basename $$PWD)

help:
	@[ -f "help.txt" ] && cat help.txt || echo "No help available."

build: Dockerfile
	@docker build -t $(NAME) -t $(NAME):latest  .

# run here is expected only to be used for testing
run: build
	@docker run --rm  --name $(NAME) $(NAME)

yapf:
	@yapf -r -i .

kill:
	@docker kill $(NAME)

all: build run
