#!/bin/sh

#create a digraph for installed brew packages and their dependencies

brew graph --installed --highlight-leaves
