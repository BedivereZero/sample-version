#!/bin/bash

sample::hack::lib::version::get_version_vars() {
	SAMPLE_GIT_COMMIT="$(git rev-parse HEAD 2>/dev/null)"

	if git_status="$(git status --porcelain 2>/dev/null)" && [[ -z "${git_status}" ]]; then
		SAMPLE_GIT_TREE_STATE="clean"
	else
		SAMPLE_GIT_TREE_STATE="dirty"
	fi

	SAMPLE_GIT_VERSION="$(git describe --tags --match='v*' 2>/dev/null)"
	DASH_IN_VERSION="$(echo "${SAMPLE_GIT_VERSION}" | sed "s/[^-]//g")"
	if [[ "${DASH_IN_VERSION}" == "---" ]]; then
		SAMPLE_GIT_VERSION="$(echo "${SAMPLE_GIT_VERSION}" | sed "s/-\([0-9]\{1,\}\)-g\([0-9a-f]\{7\}\)$/.\1+\2/")"
	fi
	if [[ "${SAMPLE_GIT_TREE_STATE}" == "dirty" ]]; then
		SAMPLE_GIT_VERSION+="-dirty"
	fi

	# major and minor
	if [[ "${SAMPLE_GIT_VERSION}" =~ ^v([0-9]+)\.([0-9]+)(\.[0-9]+)?([-].*)?([+].*)?$ ]]; then
		SAMPLE_GIT_MAJOR="${BASH_REMATCH[1]}"
		SAMPLE_GIT_MINOR="${BASH_REMATCH[2]}"
		if [[ -n "${BASH_REMATCH[4]}" ]]; then
			SAMPLE_GIT_MINOR+="+"
		fi
	fi
}
