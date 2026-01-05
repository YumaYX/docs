---
layout: post
category: rust
title: "rust loop update with ollama"
---

```bash
#!/bin/bash

while true; do

cargo build > output_cargo_build.txt 2>&1

cat <<EOF > output_prompt.txt
- update and fix rust codes.
- just answer with code block.
---
$(cat src/main.rs)
---
$(cat output_cargo_build.txt)
EOF

cp -v src/main.rs src/main.rs.$(date +%Y%m%d%H%M%S)-${$}.bak
ollama run rnj-1 "\"$(cat output_prompt.txt)\"" | /usr/local/bin/ys-ecb | tee src/main.rs

echo sleep 30
date
sleep 30
done
```
