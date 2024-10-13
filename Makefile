.PHONY: generate
generate:
	TUIST_ROOT_DIR=${PWD} mise exec -- tuist generate
install:
	mise exec -- tuist install
go:
	make install
	make generate
edit:
	mise exec -- tuist edit
cache:
	mise exec -- tuist cache
