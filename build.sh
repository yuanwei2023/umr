#!/usr/bin/env bash


# sudo yum install libpciaccess-devel
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="${BUILD_DIR:-${ROOT_DIR}/build}"
JOBS="${JOBS:-$(nproc)}"

for command in cmake cpack rpmbuild rpm; do
  if ! command -v "${command}" >/dev/null 2>&1; then
    echo "Missing required command: ${command}" >&2
    exit 1
  fi
done

cmake -S "${ROOT_DIR}" -B "${BUILD_DIR}" \
  -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  -DUMR_NO_LLVM=ON \
  -DUMR_NO_DRM=ON \
  -DUMR_NO_GUI=ON \
  -DUMR_NO_SERVER=ON

cmake --build "${BUILD_DIR}" --parallel "${JOBS}"

(
  cd "${BUILD_DIR}"
  cpack -G RPM \
    -D "CPACK_RPM_PACKAGE_REQUIRES=ncurses-libs, libpciaccess, zlib" \
    -D "CPACK_RPM_EXCLUDE_FROM_AUTO_FILELIST_ADDITION=/usr/local;/usr/local/bin;/usr/local/lib64;/usr/local/share;/usr/local/share/man;/usr/local/share/man/man1"
)

shopt -s nullglob
rpms=("${BUILD_DIR}"/umr-*.rpm)
if ((${#rpms[@]} == 0)); then
  echo "RPM was not generated under ${BUILD_DIR}" >&2
  exit 1
fi

for rpm_path in "${rpms[@]}"; do
  rpm -K "${rpm_path}"
  rpm -qpl "${rpm_path}" >/dev/null
  echo "Generated RPM: ${rpm_path}"
done
