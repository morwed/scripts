#!/bin/sh

git branch --merged >./merged-branches && nano ./merged-branches && xargs git branch -d <./merged-branches
