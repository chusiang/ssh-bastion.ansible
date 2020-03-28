.PHONY: main init check syntax_check lint_check yaml_check travis_check	\
	boot run clean

# Parser each playbooks with `*.yml`, and no include `requirements*.yml`.
PLAYBOOKS = $(shell ls *.yml | sed '/requirements/d')


main: check

init:
	if [ ! -d "ansible-retry" ]; then mkdir "ansible-retry"; fi
	ansible-galaxy install -f -p roles -r requirements.yml

# - Check ---------------------------------------------------------------------

check: syntax_check lint_check yaml_check

syntax_check:
	ansible-playbook --syntax-check $(PLAYBOOKS)

lint_check:
	ansible-lint $(PLAYBOOKS)

yaml_check:
	find -name "*.yml" -type f -not -path "./roles/*"		\
		-exec yamllint -c .yamllint.yaml {} \;

travis_check:
	travis lint .travis.yml

# - Vagrant ---------------------------------------------------------------------

up:
	vagrant up

ip:
	@echo "==> IP of jump:"
	vagrant ssh jump    -c "hostname -I" 2>/dev/null
	@echo
	@echo "==> IP of server1:"
	vagrant ssh server1 -c "hostname -I" 2>/dev/null
	@echo

run:
	vagrant provision

# - Clean ---------------------------------------------------------------------

clean:
	rm -f setup.retry ansible-retry/*				\
		builds/output.*.log tests/output.*.log			\
		ubuntu-*-cloudimg-console.log
	vagrant destroy -f
