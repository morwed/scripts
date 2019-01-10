#!/bin/sh

find . \( -iname ".classpath" -o -iname ".project" -o -iname ".settings" -o -iname ".externaltoolbuilders" -o -iname ".pmd" -o -iname "ruleset.xml" -o -iname ".springbeans" -o -iname ".ruleset" \) -exec rm -rv {} \;
