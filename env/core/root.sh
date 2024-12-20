####################################################################################################
# Program Root
####################################################################################################

# load environment variables
source $variables_env

# load constants
source $constants_env

# load settings
source $settings_sh

# Load phase worker
source $phase_worker_sh

####################################################################################################
# Main Worker Script
####################################################################################################

# Phase Worker Function
execute_phase() {
    local phase_num="$1"
    local phase_file="$2"
    local phase_name="$3"
    local timed_out=0

    while true; do
        echo "# Type 'y' to proceed to Phase ${phase_num},"
        echo "# Type 'n' to exit, or"
        echo "# [Press Enter to skip]"
        read -t $PHASE_DELAY -r -p "# Proceed to Phase ${phase_num} (${phase_name})?: " cont

        if [[ $? -gt 0 ]]; then
            timed_out=1
        fi

        cont="${cont,,}"

        if [[ "$cont" == "y" ]]; then
            log "$EXECUTION_LOG" "# Executing Phase ${phase_num} (${phase_name})..."
            if [[ $? -ne 0 ]]; then
                log "$EXECUTION_LOG" "# Cannot execute Phase ${phase_num} failed due to previous errors."
                return 1
            else
                source "$phase_file"
                if [[ $? -ne 0 ]]; then
                    log "$EXECUTION_LOG" "# Phase ${phase_num} failed duringexecution."
                    return 1
                else
                    log "$EXECUTION_LOG" "# Phase ${phase_num} completed successfully."
                fi
            fi
            break
        elif [[ "$cont" == "n" ]]; then
            log "$EXECUTION_LOG" "# User chose to exit."
            exit 0
        elif [[ -z "$cont" && $timed_out -eq 0 ]]; then
            log "$EXECUTION_LOG" "# Skipping Phase ${phase_num}..."
            break
        elif [[ $timed_out -eq 1 ]]; then
            log "$EXECUTION_LOG" "# Timeout reached. Automatically proceeding to Phase ${phase_num} (${phase_name})."
            if [[ $? -ne 0 ]]; then
                log "$EXECUTION_LOG" "# Phase ${phase_num} could not be eexecuted due to previous errors."
            else
                source "$phase_file"
                if [[ $? -ne 0 ]]; then
                    log "$EXECUTION_LOG" "# Phase ${phase_num} failed during automatic execution."
                    return 1
                else
                    log "$EXECUTION_LOG" "# Phase ${phase_num} completed successfully."
                fi
            fi
            break
        else
            echo "# Invalid input. Please enter 'y', 'n', or press Enter to skip."
        fi
    done
}
