#!/usr/bin/zsh
printy() {
  printf "\e[33;1m%s\n" "$1"
}
printg() {
  printf "\e[32m$1\e[m\n"
}
printr() {
  echo -e "\033[1;31m$1\033[0m"
}
check_status() {
  if [ $? -ne 0 ]
  then
    printg '\U0001F975 -->  ACHTING!!! '
    exit 1
  fi
}
printg '\U0001F4A5 -->  Check ERB files'
bundle exec erb_lint --lint-all
check_status
printg '\U0001F4A5 -->  Check JS files'
prettier --check app/**/*.js
check_status
printg '\U0001F4A5 -->  Check CSS files'
prettier --check app/**/*.css
# prettier --check public/*.html
check_status
printg '\U0001F4A5 -->  Check YAML files'
prettier --check config/locales/**/*.yml
check_status
printg '\U0001F4A5 -->  Check HTML files'
bundle exec htmlbeautifier -l app/views/**/*.erb --keep-blank-lines 1
check_status  
printg '\U0001F4A5 -->  Run rubocop'
bundle exec rubocop
check_status
printg '\U0001F4A5 -->  Run RSpec tests'
bundle exec rspec
check_status
printg '\U0001F4A5 -->  Run cucumber'
bundle exec cucumber  -S --fail-fast -f summary
check_status
printg '\U0001F4A5 -->  Run Reek'
bundle exec reek
check_status
bundle exec brakeman -q
check_status
printg '\U0001F4A5 -->  SUCCESS!!! You can PUSH code'
