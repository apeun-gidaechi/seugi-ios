.PHONY: generate
generate:
	TUIST_ROOT_DIR=${PWD} mise exec -- tuist generate
go:
	mise exec -- tuist fetch
	make generate