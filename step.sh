#!/bin/bash
set -ex

app_url=$(curl -u "${browserstack_user_name}:${browserstack_access_key}" -X POST "https://api-cloud.browserstack.com/app-automate/upload" -F "file=@$file_to_upload")

echo $app_url
  if [[ "$app_url" == *"app_url"* ]]
  then
    app_url=`echo $app_url | awk -F':' '{ print $2 ":" $3 }' | awk '{ print substr( $0, 2, length($0)-3 ) }'`
    #app_url=`awk '{ print substr( $0, 1, length($0)-1 ) }'`
    #app_url=${app_url%??}
    echo $app_url
    envman add --key BROWSERSTACK_APP_AUTOMATE_URL --value "$app_url"
    exit 0
  else
    echo $app_url
    echo "Error uploading file to Browserstack"
    exit 1
  fi
#
# --- Export Environment Variables for other Steps:
# You can export Environment Variables for other Steps with
#  envman, which is automatically installed by `bitrise setup`.
# A very simple example:

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
