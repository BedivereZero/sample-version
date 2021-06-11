#!/bin/bash

sample::lib::version::get_version_vars() {
	GIT_COMMIT="$(git rev-parse HEAD 2>/dev/null)"

	if git_status="$(git status --porcelain 2>/dev/null)" && [[ -z "${git_status}" ]]; then
		GIT_TREE_STATE="clean"
	else
		GIT_TREE_STATE="dirty"
	fi

	GIT_VERSION="$(git describe --tags --match='v*' 2>/dev/null)"
	DASH_IN_VERSION="$(echo "${GIT_VERSION}" | sed "s/[^-]//g")"
	if [[ "${DASH_IN_VERSION}" == "---" ]]; then
		GIT_VERSION="$(echo "${GIT_VERSION}" | sed "s/-\([0-9]\{1,\}\)-g\([0-9a-f]\{7\}\)$/.\1+\2/")"
	fi
	if [[ "${GIT_TREE_STATE}" == "dirty" ]]; then
		GIT_VERSION+="-dirty"
	fi

	# major and minor
	if [[ "${GIT_VERSION}" =~ ^v([0-9]+)\.([0-9]+)(\.[0-9]+)?([-].*)?([+].*)?$ ]]; then
		GIT_MAJOR="${BASH_REMATCH[1]}"
		GIT_MINOR="${BASH_REMATCH[2]}"
		if [[ -n "${BASH_REMATCH[4]}" ]]; then
			GIT_MINOR+="+"
		fi
	fi
}
