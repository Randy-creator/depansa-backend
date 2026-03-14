#!/bin/sh
rm -rf ./clients
rm -rf ./docs/openapi.json

npx openapi-generator-cli generate -i ./docs/api.yml -g typescript-fetch -o ./clients
npx openapi-generator-cli generate -i ./docs/api.yml -g openapi -o ./docs

rm -rf ./clients/.openapi-*
rm -rf ./clients/.git*
rm -rf ./clients/git*

rm -rf ./docs/.openapi-*
rm -rf ./docs/.git*
rm -rf ./docs/git*
rm -rf ./docs/README.md

npx prettier --write ./clients
npx prettier --write ./docs

git add clients
git add docs
git commit -m 'chore: generate new client & docs'