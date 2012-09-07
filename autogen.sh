echo "Nhopkg autogen script"
echo
echo "If this script fails, please download a recent source tarball from http://nhopkg.sourceforge.net/downloads.php"
echo
# Cleaning up
echo "Cleaning previous files..."
rm -rf  configure config.log aclocal.m4 config.status autom4te.cache libtool
rm -f Makefile.in Makefile
rm -f */Makefile.in */Makefile
echo "done."
# Checking for needed programs.
echo "Checking for aclocal..."
if [[ $(aclocal --version 2> /dev/null) ]]; then
	aclocal --version | head -1
else
	echo "you need aclocal >= 1.10.1 in your sistem."
	exit 1
fi
echo "done."
echo "Checking for autoheader..."
if [[ $(autoheader --version 2> /dev/null) ]]; then
	autoheader --version | head -1
else
	echo "you need autoheader >= 2.63 in your sistem."
	exit 1
fi
echo "done."
echo "Checking for libtoolize..."
if [[ $(libtoolize --version 2> /dev/null) ]]; then
	libtoolize --version | head -1
else
	echo "you need libtoolize >= 1.5.26 in your sistem."
	exit 1
fi
echo "done."
echo "Checking for autoconf..."
if [[ $(autoconf --version 2> /dev/null) ]]; then
	autoconf --version | head -1
else
	echo "you need autoconf >= 2.63 in your sistem."
	exit 1
fi
echo "done."
echo "Checking for automake..."
if [[ $(automake --version 2> /dev/null) ]]; then
	automake --version | head -1
else
	echo "you need automake >= 1.10.1 in your sistem."
	exit 1
fi
echo "done."
# Runing programs to generate tarball.
echo "Running Aclocal..."
aclocal -I .
echo "done."
echo "Running Autoheader..."
autoheader
echo "done."
echo "Running Libtoolize..."
libtoolize --automake -c -f
echo "done."
echo "Running Autoconf..."
autoconf
echo "done."
echo "Running Automake..."
automake -a -c
echo "done."
# Check that all is good.
echo "Checking generate files..."
if [[ ! -f configure ]] \
|| [[ ! -f Makefile.in ]]; then
	echo "FAILED!"
	echo "Error: Unable to generate all required files!"
	echo "Please make sure you have autoconf >= 2.5, automake >= 1.7, libtool >= 1.5 autoheader and aclocal installed."
	exit 1
fi
echo "done."
# Finish.
echo "Now run ./configure, see ./configure --help for more information."
