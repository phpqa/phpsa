#!/usr/bin/env sh
set -e

isCommand() {
  for cmd in \
    "check" \
    "compile" \
    "help" \
    "list" \
    "config:dump-documentation" \
    "config:dump-reference"
  do
    if [ -z "${cmd#"$1"}" ]; then
      return 0
    fi
  done

  return 1
}

if [ "$(printf %c "$1")" = '-' ]; then
  set -- /sbin/tini -- php /composer/vendor/bin/phpsa "$@"
elif [ "$1" = "/composer/vendor/bin/phpsa" ]; then
  set -- /sbin/tini -- php "$@"
elif [ "$1" = "phpsa" ]; then
  set -- /sbin/tini -- php /composer/vendor/bin/"$@"
elif isCommand "$1"; then
  set -- /sbin/tini -- php /composer/vendor/bin/phpsa "$@"
fi

exec "$@"
