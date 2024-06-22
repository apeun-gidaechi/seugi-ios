.PHONY: generate
generate:
	TUIST_ROOT_DIR=${PWD} mise exec -- tuist generate
