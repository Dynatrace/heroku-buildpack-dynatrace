################################################################################
#       Logs
################################################################################
toLog() {
        if [ -w "${LOG_FILE}" ]; then
                echo "$(date -u +"%Y-%m-%d %H:%M:%S") UTC" "$@" >> ${LOG_FILE}
        fi
}

toConsoleOnly() {
        echo "$(date +"%H:%M:%S")" "$@"
}

toLogInfo() {
        toLog "[INFO]" "$@"
}

toLogWarning() {
        toLog "[WARN]" "$@"
}

toLogError() {
        toLog "[ERROR]" "$@"
}

toConsoleInfo() {
        toConsoleOnly "$@"
        toLogInfo "$@"
}

toConsoleWarning() {
        toConsoleOnly "Warning:" "$@"
        toLogWarning "$@"
}

toConsoleError() {
        toConsoleOnly "Error:" "$@"
        toLogError "$@"
}

################################################################################
#       Heroku buildpack
################################################################################
indent() {
  sed -u 's/^/       /'
}

export_env_dir() {
  env_dir=$1
  whitelist_regex=${2:-''}
  blacklist_regex=${3:-'^(PATH|GIT_DIR|CPATH|CPPATH|LD_PRELOAD|LIBRARY_PATH)$'}
  if [ -d "$env_dir" ]; then
    for e in $(ls $env_dir); do
      echo "$e" | grep -E "$whitelist_regex" | grep -qvE "$blacklist_regex" &&
      export "$e=$(cat $env_dir/$e)"
      :
    done
  fi
}

validate_command_exists() {
  "$@" > /dev/null 2>&1
  if [ $? -eq 127 ]; then
    return 1
  fi
  return 0
}
