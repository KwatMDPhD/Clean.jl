function date() {

	bal=$(echo $ba | awk '{print tolower($0)}')

	if [[ $bal =~ \\.(jpeg|jpg)$ ]]

	then

		ba2=$(exiftool -CreateDate $1 | awk '/ Date/{print $4"_"$5}' | sed "s/:/./g")

		if [ -z $ba2 ]

		then

			echo "🗓️ $1."

		else

			mv -vn $1 "$di/$ba2.jpg"

		fi

	elif [[ $bal =~ \\.heic$ ]]

	then

		ba2=$(exiftool -CreateDate $1 | awk '/ Date/{print $4"_"$5}' | sed "s/:/./g")

		if [ -z $ba2 ]

		then

			echo "🗓️ $1."

		else

			mv -vn $1 "$di/$ba2.heic"

		fi

	elif [[ $bal =~ \\.mov$ ]]

	then

		ba2=$(exiftool -CreationDate $1 | awk '/ Date/{print $4"_"$5}' | sed "s/:/./g")

		if [ -z $ba2 ]

		then

			echo "🗓️ $1."

		else

			mv -vn $1 "$di/$ba2.mov"

		fi

	elif [[ $bal =~ \\.mp4$ ]]

	then

		ba2=$(exiftool -CreationDate $1 | awk '/ Date/{print $4"_"$5}' | sed "s/:/./g")

		if [ -z $ba2 ]

		then

			ba2=$(exiftool -CreateDate $1 | awk '/ Date/{print $4"_"$5}' | sed "s/:/./g")

		fi

		if [ -z $ba2 ]

		then

			echo "🗓️ $1."

		else

			mv -vn $1 "$di/$ba2.mp4"

		fi

	else

		echo "👽 $1."

	fi

}
