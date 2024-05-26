s:	install
	bundle exec jekyll server -H 0.0.0.0 -P 4001

install:
	bundle install

pub:
	ruby app.rb
	git status
	sleep 5
	git add .
	git commit -am 'update'
	git push

port:
	sudo dnf -y install firewalld
	sudo systemctl restart firewalld
	sudo firewall-cmd --permanent --zone=public --add-port=4001/tcp
	sudo firewall-cmd --reload

