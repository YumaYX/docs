---
layout: post
category: linux
title: "easy backup restore"
---

about easy backup & restore

# backup

```sh
#!/usr/bin/env bash

dest='/samba/share/backup.xz'
sudo tar Jvcf "${dest}" /work /root/.ssh /home/*/.ssh /var/spool/cron
```

# restore

```sh
#!/usr/bin/env bash

exit
target='/samba/share/backup.xz'
ls "${target}" && sudo tar xJvf "${target}" -C /
```

