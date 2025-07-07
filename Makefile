.PHONY: all docs lint test check-prereqs git-clean test-os test-scenarios

ALL_TAGS = \
  opensuse-15.6 \
  debian-12 \
  debian-sid \
  arch \
  ubuntu-22.04 \
  ubuntu-24.04 \
  rockylinux-9 \
  tumbleweed

TAGS ?= $(ALL_TAGS)

default: check-prereqs

check-prereqs:
	@command -v molecule >/dev/null 2>&1 || { echo "❌ 'molecule' not found in PATH. Please install it."; exit 1; }
	@command -v act >/dev/null 2>&1 || { echo "❌ 'act' not found in PATH. Please install it."; exit 1; }
	@command -v docsible >/dev/null 2>&1 || { echo "❌ 'docsible' not found in PATH. Please install it."; exit 1; }
	@echo "✅ All prerequisites found."

all: lint test docs git-clean

test: test-os test-scenarios

docs: check-prereqs
	docsible -nob -nod -r . -com -ru https://github.com/SweBarre/opkssh-role -rt github -rb main -a

lint: check-prereqs
	act pull_request --job lint

test-scenarios: check-prereqs
	@mkdir -p test-logs
	@echo "Running all Molecule scenarios..."
	@pass=0; fail=0; \
	for d in molecule/*/; do \
		scenario=$$(basename $$d); \
		logfile="test-logs/$$scenario.log"; \
		printf "==> %-16s" "$$scenario"; \
		start=$$(date +%s); \
		( molecule test -s $$scenario 2>&1 | tee "$$logfile" >/dev/null ); \
		exitcode=$$?; \
		end=$$(date +%s); \
		secs=$$((end - start)); \
		mins=$$(($$secs / 60)); \
		rem=$$(($$secs % 60)); \
		if [ $$exitcode -ne 0 ] || grep -Eq 'CRITICAL|ERROR|FAILED:' "$$logfile"; then \
			echo "❌ FAIL ($${mins}m$${rem}s) (see $$logfile)"; fail=$$((fail+1)); \
		else \
			echo "✅ PASS ($${mins}m$${rem}s)"; pass=$$((pass+1)); \
		fi; \
	done; \
	total=$$((pass+fail)); \
	echo ""; \
	echo "============================"; \
	echo "Summary: $$pass of $$total passed"; \
	echo "         $$fail of $$total failed"; \
	echo "============================"; \
	if [ $$fail -ne 0 ]; then \
		exit 1; \
	fi

git-clean:
	@if ! git diff --quiet || [ -n "$$(git ls-files --others --exclude-standard)" ]; then \
		if [ "$(FORCE)" != "1" ]; then \
			echo "❌ Git working directory has unstaged or untracked changes."; \
			echo "Here's the diff:"; \
			git --no-pager diff; \
			echo ""; \
			echo "💡 To override this check, run with: make <target> FORCE=1"; \
			exit 1; \
		else \
			echo "⚠️  Git repo is dirty (unstaged/untracked), but FORCE=1 is set — continuing anyway."; \
		fi \
	else \
		echo "✅ Git repo is clean (no unstaged or untracked changes)."; \
	fi

test-os: check-prereqs
	@mkdir -p test-logs
	@echo "Running molecule test for each MOLECULE_TAG..."
	@echo "💡 Use TAG to select what to run; make test-os TAGS=\"debian-12 arch tumbleweed\""
	@pass=0; fail=0; \
	for tag in $(TAGS); do \
		printf "==> %-16s" "$$tag"; \
		start=$$(date +%s); \
		logfile="test-logs/tag-$$tag.log"; \
		( MOLECULE_TAG=$$tag molecule test 2>&1 | tee "$$logfile" >/dev/null ); \
		status=$$?; \
		end=$$(date +%s); \
		secs=$$((end - start)); \
		mins=$$((secs / 60)); \
		rem=$$((secs % 60)); \
		if [ $$status -ne 0 ] || grep -Eq 'CRITICAL|ERROR|FAILED!|fatal:' "$$logfile"; then \
			echo "❌ FAIL ($${mins}m$${rem}s) (see $$logfile)"; \
			fail=$$((fail + 1)); \
		else \
			echo "✅ PASS ($${mins}m$${rem}s)"; \
			pass=$$((pass + 1)); \
		fi; \
	done; \
	total=$$((pass + fail)); \
	echo ""; \
	echo "============================"; \
	echo "Tag Summary: $$pass of $$total passed"; \
	echo "             $$fail of $$total failed"; \
	echo "============================"; \
	if [ $$fail -ne 0 ]; then \
		exit 1; \
	fi
