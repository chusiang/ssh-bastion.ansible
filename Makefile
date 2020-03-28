.PHONY: main init check syntax_check lint_check yaml_check travis_check	\
	boot run clean

# Parser each playbooks with `*.yml`, and no include `requirements*.yml`.
PLAYBOOKS = $(shell ls *.yml | sed '/requirements/d')

main: check

init:
	@echo "==> Create ansible-retry/ directory .."
	if [ ! -d "ansible-retry" ]; then mkdir "ansible-retry"; fi
	@echo
	@echo "==> Run playbook of setup_control_machine.yml .."
	ansible-playbook setup_control_machine.yml

# - Check ---------------------------------------------------------------------

check: syntax_check lint_check yaml_check

syntax_check:
	@echo "==> Checking Ansible playbooks syntax .."
	ansible-playbook --syntax-check $(PLAYBOOKS)

lint_check:
	@echo "==> Checking Ansible playbooks lint .."
	ansible-lint $(PLAYBOOKS)

yaml_check:
	@echo "==> Checking YAML syntax .."
	find -name "*.yml" -type f -not -path "./roles/*"		\
		-exec yamllint -c .yamllint.yaml {} \;

travis_check:
	@echo "==> Checking Travis CI syntax .."
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

# - Ansible -------------------------------------------------------------------

ping:
	@echo "==> Run playbook of ping_all.yml .."
	ansible-playbook ping_all.yml

# - Clean ---------------------------------------------------------------------

clean:
	-rm -f setup.retry ansible-retry/*				\
		ubuntu-*-cloudimg-console.log				\
		/tmp/ssh-vagrant@*

cleanall: clean
	vagrant destroy -f
