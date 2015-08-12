#! /bin/sh
# svnblame.sh <svn-tool> <diff-app> <options> [<revision> <name> <target>]+

open_sh="${0%/*}/open.sh"
svn="$1"; diff="$2"; options="$3"
shift 3

dir="/tmp/svnx"; n=0
while ([ ! -d $dir ] && ! mkdir $dir &> /dev/null); do
	dir="/tmp/svnx$((n++))"
done
chmod -f a+rw $dir

until [ -z "$1" ]; do
	name="blame r$1 $2"
	dest="$dir/$name"; n=0
	while [ -e "$dest" ]; do
		dest="$dir/$((n++)) $name"
	done

	"$svn" blame -r $1 $options "$3" > "$dest"
	if [ $? -a -s "$dest" ]; then
		"$open_sh" "$diff" '2' "$dest"
	else
		rm -f "$dest"
	fi

	shift 3
done

