#!/bin/sh

# ldapsearch -x -LLL -h [host] -D [user] -w [password] -b [base DN] -s sub "([filter])" [attribute list]
ldapsearch -vx -LLL -h ldaps://int.secrz.com:636 -D cms.test-admin -w 8WkCpfFLmZtr