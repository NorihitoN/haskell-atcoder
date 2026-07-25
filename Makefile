# AtCoder Haskell Environment
# Usage:
#   make new CONTEST=abc360 TASK=a    -- create problem file + register executable
#   make build CONTEST=abc360 TASK=a  -- build a specific problem
#   make test CONTEST=abc360 TASK=a   -- run sample testcases
#   make dl CONTEST=abc360 TASK=a     -- download testcases with oj
#   make run CONTEST=abc360 TASK=a    -- run interactively

CONTEST ?= abc999
TASK ?= a
PROB = $(CONTEST)-$(TASK)

new:
	@./scripts/add-problem.sh $(CONTEST) $(TASK)

dl:
	@./scripts/dl-testcase.sh $(CONTEST) $(TASK)

build:
	cabal build $(PROB) --project-file=cabal.project

test:
	@./scripts/test-problem.sh $(CONTEST) $(TASK)

run: build
	@EXEC=$$(cabal list-bin $(PROB) --project-file=cabal.project 2>/dev/null) && \
	$$EXEC

.PHONY: new dl build test run
