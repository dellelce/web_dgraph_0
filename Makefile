# "Global" makefile

COMPONENTS  = $$(for dir in */Makefile; do echo $$(basename $$(dirname $$dir)); done )
DCL         = db_dgraph_0.yml
STACK       = db_dgraph

# $HELP$
# help          Print this message
# build         Build all components in this Makefile
# deploy        Deploy stack
# undeploy      Undeploy stack
# status        Check status of stack
# all           Build componts and Deploy
# stop          Alias of undeploy
# start         Alias of deploy
# logs          Containers log

.PHONY: help
help:
	@awk -f docs/help.awk Makefile

.PHONY: build
build:
	for service in $(COMPONENTS); do make -C "$$service" build || break; done

# deploy only if nothing is running
.PHONY: deploy
deploy: build
	@docker stack ps -q $(STACK) > /dev/null 2>&1 && { echo "Make sure you 'undeploy' first"; } || { docker stack deploy $(STACK) -c $(DCL); }


.PHONY: undeploy
undeploy:
	@docker stack rm $(STACK) 2>&1

.PHONY: status
status:
	@docker stack ps $(STACK) --no-trunc

.PHONY: all
all: build deploy

stop: undeploy

sleep:
	@sleep 10

.PHONY: redeploy
redeploy: build undeploy sleep deploy

restart: redeploy

all: undeploy

start: deploy

.PHONY: logs
logs:
	@for service in $(COMPONENTS); do docker service logs  $(STACK)_default; done

# EOF #
