#!/bin/bash
set -ex

if [ -z "${gradle_file}" ] ; then
	echo "# Error"
	echo '* Required input `$gradle_file` not provided!'
	exit 1
fi

if [ -z "${gradlew_file_path}" ] ; then
	echo "# Error"
	echo '* Required input `$gradlew_file_path` not provided!'
	exit 1
fi

if [ -z "${ktlint_task}" ] ; then
	echo "# Error"
	echo '* Required input `$ktlint_task` not provided!'
	exit 1
fi

echo "# Configuration"
echo "* - GradleFile: *${gradle_file}*"
echo "* - GradlewPath: *${gradlew_file_path}*"
echo "* - Ktlint task: *${ktlint_task}*"

output=$($gradlew_file_path -q $ktlint_task; result_status=$?;)

if [ $result_status = 0 ];
then
  envman add --key BITRISE_KTLINT_RESULT --value "succeeded"
else
  envman add --key BITRISE_KTLINT_RESULT --value "failed"
	envman add --key BITRISE_KTLINT_ERRORS --value $output
fi
