#/bin/sh

# convert all JPEG files in current directory to PNG
# --------------------------------------------------

for file in *
do
	if test `echo "$file" | awk -F '.' '{print $NF}'` == 'jpg'
	then
		png_file=`basename "$file" ".jpg"`.png
		if ls "$png_file" >/dev/null 2>/dev/null
		then
			echo "$png_file already exists"
		else
                	convert "$file" "$png_file"
			rm "$file"           
		fi
	fi
done
