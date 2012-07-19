for f in .vim/bundle/*; do
		echo "Updating " $f;
		cd $f;
		git pull;
		cd -;
done
