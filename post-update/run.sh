#!/bin/sh

for f in `ls /etc/run.d/`
do
	sh /etc/run.d/$f
done

/usr/bin/supervisord