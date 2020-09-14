#!/bin/bash
# travis-ci.org
cd public_gitee
git config user.name "codingriver"
git config user.email "codingriver@163.com"
git init
git add .
msg="rebuilding site `date`"
git commit -m "deploy page"
git remote add origin git@gitee.com:codingriver/codingriver.git
git push --force origin master:master
cd ..