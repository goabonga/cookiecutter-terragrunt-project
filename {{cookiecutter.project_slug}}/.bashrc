BLACK=`tput -Txterm setaf 0`
RED=`tput -Txterm setaf 1`
GREEN=`tput -Txterm setaf 2`
YELLOW=`tput -Txterm setaf 3`
LIGHTPURPLE=`tput -Txterm setaf 4`
PURPLE=`tput -Txterm setaf 5`
BLUE=`tput -Txterm setaf 6`
WHITE=`tput -Txterm setaf 7`
RESET=`tput -Txterm sgr0`

export ENV=dev

function switch_env(){
	if [[ -z "${1}" ]]
	then
		echo "usage: switch_env [environment]"
		return 1
	fi
	if [[ ! -f "config.${1}.yaml" ]]
	then
		echo "${RED}Error: file \"config.${1}.yaml\" not founds.${RESET}"
		return 1
	fi
	project_id=`cat config.${1}.yaml | yq -r .project.project_id`

	clean --silent
	echo "${WHITE}Swith to environment${RESET} ${PURPLE}${1}${RESET}"
    gcloud config set project ${project_id}
	export ENV=${1}
}

# terraform like function

function init(){
	if [[ -z "${1}" ]]
	then
		echo "usage: init ./path/service"
		return 1
	fi
    terragrunt run-all init \
	-reconfigure --terragrunt-non-interactive \
	--terragrunt-working-dir=${1}
}

function providers(){
	if [[ -z "${1}" ]]
	then
		echo "usage: providers ./path/service"
		return 1
	fi
    terragrunt providers ${2} \
	--terragrunt-non-interactive \
	--terragrunt-working-dir=${1}
}

function import(){
	if [[ -z "${1}" ]]
	then
		echo "usage: import ./path/service resource uuid"
		return 1
	fi
    terragrunt import ${2} ${3} \
	--terragrunt-non-interactive \
	--terragrunt-working-dir=${1}
}

function state(){
	if [[ -z "${1}" ]]
	then
		echo "usage: state ./path/service "
		return 1
	fi
    terragrunt state ${2} ${3} \
	--terragrunt-non-interactive \
	--terragrunt-working-dir=${1}
}

function apply(){
	if [[ -z "${1}" ]]
	then
		echo "usage: apply ./path/service"
		return 1
	fi
    terragrunt run-all apply \
    -auto-approve --terragrunt-non-interactive \
	--terragrunt-working-dir=${1}
}

function plan(){
	if [[ -z "${1}" ]]
	then
		echo "usage: plan ./path/service"
		return 1
	fi
    terragrunt run-all plan \
	--terragrunt-non-interactive \
	--terragrunt-working-dir=${1} ${2}
}

function output(){
	if [[ -z "${1}" ]]
	then
		echo "usage: output ./path/service"
		return 1
	fi
    terragrunt run-all output ${2} \
	--terragrunt-non-interactive \
	--terragrunt-working-dir=${1} 2> /dev/null
}

function show(){
	if [[ -z "${1}" ]]
	then
		echo "usage: show ./path/service"
		return 1
	fi
    terragrunt show ${2} \
	--terragrunt-non-interactive \
	--terragrunt-working-dir=${1}
}

function graph(){
	if [[ -z "${1}" ]]
	then
		echo "usage: graph ./path/service"
		return 1
	fi
    terragrunt run-all graph \
	--terragrunt-non-interactive \
	--terragrunt-working-dir=${1}
}

function refresh(){
	if [[ -z "${1}" ]]
	then
		echo "usage: refresh ./path/service"
		return 1
	fi
    terragrunt run-all refresh \
	--terragrunt-non-interactive \
	--terragrunt-working-dir=${1}
}

function destroy(){
	if [[ -z "${1}" ]]
	then
		echo "usage: destroy ./path/service"
		return 1
	fi
    terragrunt run-all destroy \
	--terragrunt-non-interactive \
	--terragrunt-working-dir=${1}
}

function clean(){
	if [[ ! "$@" =~ .*"--silent".* ]]; then
		echo "${GREEN}Clean directory${RESET}"
	fi
	rm -Rf graph
	find ./ -type d -name ".terragrunt-cache" \
	-o -type f -name ".terraform.lock.hcl" \
	-o -type d -name ".terraform" \
	-o -type f -name "generated_*.tf" | \
	xargs rm -Rf
}


