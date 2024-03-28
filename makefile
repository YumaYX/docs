s:	install
	#bundle exec jekyll server -H 0.0.0.0 -P 4001
	bundle exec jekyll server -H localhost -P 4001

install:
	bundle install

pub:
	git status
	sleep 5
	git add .
	git commit -am 'update'
	git push

