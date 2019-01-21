#!/bin/sh
lsof -p $1 | grep cwd
