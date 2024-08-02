function rename-with-date() {

	di=$(dirname $1)

	ba=$(basename $1)

	if [[ $ba =~ ^[0-9]{4}\\.[0-9]{2}\\.[0-9]{2}(\\.|" ") ]]

	then

		echo "🎄 $1."

		return

	fi

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

function clean-name() {

	rename --sanitize --lower-case --expr "s/-/_/g" --force $1

}

function recursively-chmod() {

    ig="-not -path \"*/.git/*\" -not -path \"*/node_modules/*\" -not -path \"*/.svelte-kit/*\""

    find . -type f $(echo $ig) -print0 | xargs -0 chmod 644 &&

	find . -type d $(echo $ig) -print0 | xargs -0 chmod 755

}

function recursively-sed() {

	rg --no-ignore --files-with-matches $1 | xargs sed -i "" "s/$1/$2/g"

}
