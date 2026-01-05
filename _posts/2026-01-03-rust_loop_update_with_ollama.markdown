---
layout: post
category: rust
title: "rust loop update with ollama"
---

```bash
#!/bin/bash

for i in $(seq 5); do
echo ${i}

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
ollama run rnj-1 "\"$(cat output_prompt.txt)\"" \
  | awk 'BEGIN{in_block=0} /^```/ {in_block = !in_block; next} in_block' \
  | tee src/main.rs

date

done
```

