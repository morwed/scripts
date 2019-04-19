#!/bin/sh

docker run -d --rm -p 1521:1521 -v ~/projects/the-database:/opt/oracle/oradata mindshift.cms/database
