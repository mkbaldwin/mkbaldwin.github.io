#! /bin/bash

#For dev mode run and process future dated posts and enable drafts.
bundle exec jekyll serve --future --drafts --config _config.yml,_dev-config.yml
