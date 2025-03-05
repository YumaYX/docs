#!/bin/bash

find _site -name "*.html" \
    | xargs -I@ sed -e 's/<table>/<table class="u-full-width">/g' -i @
