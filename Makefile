# Set the shell to bash always
SHELL := /bin/bash

# Look for a .env file, and if present, set make variables from it.
ifneq (,$(wildcard ./.env))
	include .env
	export $(shell sed 's/=.*//' .env)
endif

ORG_NAME := krateoplatformops
GIT_REPO := krateo-runtime-providers
CHART_REPO_URL := https://$(ORG_NAME).github.io/$(GIT_REPO)

PACKAGE_PATH := .cr-release-packages

# Tools
CR=$(shell which cr)
HELM=$(shell which helm)

.PHONY: help

.DEFAULT_GOAL := help


## help: Print this help
help: Makefile
	@echo
	@echo " Choose a command run in "$(PROJECT_NAME)":"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo

## argocd.package: Create the ArgoCD Login Provider package
argocd.package: clean
	$(HELM) package charts/provider-argocd-token --destination $(PACKAGE_PATH)

## argocd.upload: Upload the ArgoCD Login Provider package to the GIT Repository
argocd.upload: argocd.package
	$(CR) upload --owner $(ORG_NAME) --git-repo $(GIT_REPO) --package-path $(PACKAGE_PATH)
	$(CR) index --owner $(ORG_NAME) --git-repo $(GIT_REPO) --charts-repo $(CHART_REPO_URL) \
	--package-path $(PACKAGE_PATH) --push

## vsphere.package: Create the vSphere Provider package
vsphere.package: clean
	$(HELM) package charts/provider-vsphere --destination $(PACKAGE_PATH)

## vsphere.upload: Upload the vSphere Provider package
vsphere.upload:
	$(CR) upload --owner $(ORG_NAME) --git-repo $(GIT_REPO) --package-path $(PACKAGE_PATH)
	$(CR) index --owner $(ORG_NAME) --git-repo $(GIT_REPO) --charts-repo $(CHART_REPO_URL) \
	--package-path $(PACKAGE_PATH) --push


## license.package: Create the License Provider package
license.package: clean
	$(HELM) package charts/provider-license --destination $(PACKAGE_PATH)

## license.upload: Upload the License Provider package
license.upload:
	$(CR) upload --owner $(ORG_NAME) --git-repo $(GIT_REPO) --package-path $(PACKAGE_PATH)
	$(CR) index --owner $(ORG_NAME) --git-repo $(GIT_REPO) --charts-repo $(CHART_REPO_URL) \
	--package-path $(PACKAGE_PATH) --push


clean:
	rm -f $(PACKAGE_PATH)/*