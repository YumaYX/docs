cd _posts
ls -1 *.markdown  | while read line
do
category=$(grep ^categor $line | awk '{print $2}'); echo $category; echo $line; mv -v  "${line}" "${category}"; sleep 0.4
done
