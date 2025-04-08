#!/usr/bin/env bash
echo "Run checkstyle script"

# run gofmt
echo "Run 'gofmt'"
unformatted=$(gofmt -l `pwd`/src/)
if [[ -n $unformatted ]]; then
	echo >&2 "Error: Found files not formatted by gofmt"
	for fi in $unformatted; do
		echo >&2 $fi
	done
	echo "Please run 'gofmt -w' for files listed."
	exit 1
fi

# run goimports
echo "Try update 'goimports'"
GOPATH=`pwd`/Tools go get golang.org/x/tools/cmd/goimports

echo "Run 'go vet'"
ln -s `pwd` `pwd`/vendor/src/github.com/aws/session-manager-plugin
go vet ./src/...
