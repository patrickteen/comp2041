#!/bin/sh

#write a shell script email_image.sh which given a list of image files as arguments displays them one-by-one. 
#After the 
#user has viewed each image the script should prompt the user for an e-mail address. 
#If the user does enter an email #address, the script should prompt the user for a message to accompany the image and 
# then send the image to e-mail addres
# to that address.


#% ./email_image.sh penguins.png treefrog.png 
#Address to e-mail this image to? andrewt@cse.unsw.edu.au
#Message to accompany image? Penguins are cool.
#penguins.png sent to andrewt@cse.unsw.edu.au
#Address to e-mail this image to? andrewt@cse.unsw.edu.au
#Message to accompany image? This is a White-lipped Tree Frog
#treefrog.png sent to andrewt@cse.unsw.edu.au

# format: ./email_image.sh file ...

for file in $*
do
	display $file

	echo -n "Address to e-mail this image to? "
	read email

	echo -n "Message to accompany image? "
	read message

	mail $email $message &&
	echo "$file sent to $email"
done