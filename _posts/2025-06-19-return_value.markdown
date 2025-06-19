---
layout: post
category: shell
---

```sh
get_username() {
    echo "alice"
    return ${?}
}

user=$(get_username)
echo "User: $user"
```

```
$ sh sample.sh 
User: alice
$  
```
