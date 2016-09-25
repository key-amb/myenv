__gcloud_sdk_root="${GCLOUD_SDK_ROOT:-/usr/local/google-cloud-sdk}"

__load_files+=(
  "${__gcloud_sdk_root}/path.bash.inc"
  "${__gcloud_sdk_root}/completion.bash.inc"
)

unset __gcloud_sdk_root
