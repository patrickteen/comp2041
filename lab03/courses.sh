#/bin/sh

# pages to download
# http://www.handbook.unsw.edu.au/vbook2011/brCoursesByAtoZ.jsp?StudyLevel=Undergraduate&descr=#
# http://www.handbook.unsw.edu.au/vbook2012/brCoursesByAtoZ.jsp?StudyLevel=Postgraduate&descr=#

urlUndergrad="http://www.handbook.unsw.edu.au/vbook2011/brCoursesByAtoZ.jsp?StudyLevel=Undergraduate&descr="`echo $1 | tr a-z A-Z | cut -c1`
urlPostgrad="http://www.handbook.unsw.edu.au/vbook2011/brCoursesByAtoZ.jsp?StudyLevel=Postgraduate&descr="`echo $1 | tr a-z A-Z | cut -c1`

#set -x

# grab the data

underGrad=`wget -qO- $urlUndergrad | \
	   egrep -o \
	   "<TD class=\"(evenTableCell)?\"><A href=\"http://www.handbook\.unsw\.edu\.au/undergraduate/courses/201[0-9]/$1[0-9]{4}\.html\">.+?</A></TD>" | \
	   sed -r "s/<TD.+?($1[0-9]{4}).+?>(.+?)<\/A>.+?TD>/\1 \2\\n/g"`
	
# remove html tags

echo $underGrad
