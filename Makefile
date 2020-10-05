dirPre := $(shell pwd)
dir := $(shell echo $(dirPre) | sed -e 's/\//\\\//g')

ifeq ($(OS),Windows_NT)
    CCFLAGS += -D WIN32
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        CCFLAGS += -D LINUX
    endif
    ifeq ($(UNAME_S),Darwin)
        CCFLAGS += -D OSX
    endif
endif


all: php apache


php:
ifeq ($(CCFLAGS), -D OSX)
	composer install
	composer update
endif

apache: apacheClean
ifeq ($(CCFLAGS), -D OSX)
	sudo cp /etc/apache2/httpd.conf /etc/apache2/httpd.conf.mmCopy

	sudo sed -i '' -e '/.*LoadModule php7_module.*/s/#//g' /etc/apache2/httpd.conf
	sudo sed -i '' -e '/.*LoadModule rewrite_module*/s/#//g' /etc/apache2/httpd.conf
	sudo sed -i '' -e '/.*LoadModule deflate_module*/s/#//g' /etc/apache2/httpd.conf

	#sudo sed -i '' -e '/.*Include \/private\/etc\/apache2\/extra\/httpd-vhosts.conf.*/s/#//g' /etc/apache2/httpd.conf

	sudo sed -i '' -e "s/^DocumentRoot.*/DocumentRoot \"$(dir)\/webSpace\"/g" /etc/apache2/httpd.conf
	sudo sed -i '' -e "s/^<Directory \".*/<Directory \"$(dir)\/webSpace\">/g" /etc/apache2/httpd.conf

	sudo apachectl restart
endif

apacheClean:
ifeq ($(CCFLAGS), -D OSX)
	sudo cp -f /etc/apache2/httpd.conf.mmCopy /etc/apache2/httpd.conf 2>>/dev/null || :
	sudo rm -f /etc/apache2/httpd.conf.mmCopy
endif

clean: apacheClean
