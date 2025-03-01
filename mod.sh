#!/bin/bash

find _site -name "*.html" \
    | xargs -I@ sed -i 's/<table>/<table class="u-full-width">/g' @
