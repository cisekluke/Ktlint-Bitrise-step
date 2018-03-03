#!/bin/bash
set -ex

formatted_output_file_path="$BITRISE_STEP_FORMATTED_OUTPUT_FILE_PATH"


function echo_string_to_formatted_output {
	print_msg=$1
	is_dont_print_to_std_out=$2

	echo "${print_msg}" >> ${formatted_output_file_path}
	if [ -z ${is_dont_print_to_std_out} ]; then
		echo "${print_msg}"
	fi
}

function write_section_to_formatted_output {
	print_msg=$1
	is_dont_print_to_std_out=$2

	echo '' >> ${formatted_output_file_path}
	echo "${print_msg}" >> ${formatted_output_file_path}
	echo '' >> ${formatted_output_file_path}

	if [ -z ${is_dont_print_to_std_out} ]; then
		echo ''
		echo "${print_msg}"
		echo ''
	fi
}

function write_section_start_to_formatted_output {
	print_msg=$1
	is_dont_print_to_std_out=$2

	echo "${print_msg}" >> ${formatted_output_file_path}
	echo '' >> ${formatted_output_file_path}

	if [ -z ${is_dont_print_to_std_out} ]; then
		echo "${print_msg}"
		echo ''
	fi
}


echo "This is the value specified for the input 'example_step_input': ${example_step_input}"
echo "This is the value specified for the input 'ktlint_task': ${ktlint_task}"
echo "This is the value specified for the input 'gradlew_file_path': ${gradlew_file_path}"


if [ -z "${gradle_file}" ] ; then
	write_section_to_formatted_output "# Error"
	write_section_start_to_formatted_output '* Required input `$gradle_file` not provided!'
	exit 1
fi

if [ -z "${gradlew_file_path}" ] ; then
	write_section_to_formatted_output "# Error"
	write_section_start_to_formatted_output '* Required input `$gradlew_file_path` not provided!'
	exit 1
fi

if [ -z "${ktlint_task}" ] ; then
	write_section_to_formatted_output "# Error"
	write_section_start_to_formatted_output '* Required input `$ktlint_task` not provided!'
	exit 1
fi




#
# --- Export Environment Variables for other Steps:
# You can export Environment Variables for other Steps with
#  envman, which is automatically installed by `bitrise setup`.
# A very simple example:

envman add --key BITRISE_KTLINT_RESULT --value 'succeeded'


# Envman can handle piped inputs, which is useful if the text you want to
# share is complex and you don't want to deal with proper bash escaping:
#  cat file_with_complex_input | envman add --KEY EXAMPLE_STEP_OUTPUT
# You can find more usage examples on envman's GitHub page
#  at: https://github.com/bitrise-io/envman

#
# --- Exit codes:
# The exit code of your Step is very important. If you return
#  with a 0 exit code `bitrise` will register your Step as "successful".
# Any non zero exit code will be registered as "failed" by `bitrise`.

write_section_to_formatted_output "# Configuration"
echo_string_to_formatted_output "* - GradleFile: *${gradle_file}*"
echo_string_to_formatted_output "* - GradlewPath: *${gradlew_file_path}*"
echo_string_to_formatted_output "* - Ktlint task: *${ktlint_task}*"
