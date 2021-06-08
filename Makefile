BINDIR  := $(CURDIR)/bin
BINNAME ?= version

SRC := $(shell find . -type f -name '*.go' -print) go.mod

GIT_COMMIT = $(shell git rev-parse HEAD)
GIT_SHA    = $(shell git rev-parse --short HEAD)
GIT_TAG    = $(shell git describe --tags 2>/dev/null)
GIT_DIRTY  = $(shell test -n "`git status --porcelain`" && echo "dirty" || echo "clean")

VERSION ?= $(GIT_TAG)

LDFLAGS := -w -s
LDFLAGS += -X main.version=${VERSION}
LDFLAGS += -X main.gitCommit=${GIT_COMMIT}
LDFLAGS += -X main.gitTreeState=${GIT_DIRTY}

.PHONY: info
info:
	@echo "Version:           ${VERSION}"
	@echo "Git Tag:           ${GIT_TAG}"
	@echo "Git Commit:        ${GIT_COMMIT}"
	@echo "Git Tree State:    ${GIT_DIRTY}"

build: $(BINDIR)/$(BINNAME)

$(BINDIR)/$(BINNAME): $(SRC)
	GO11MODULE=on go build $(GOFLAGS) -ldflags '$(LDFLAGS)' -o '$(BINDIR)/$(BINNAME)' ./cmd/version

.PHONY: clean
clean:
	@rm -rf '$(BINDIR)'
