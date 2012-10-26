dnl                                               -*- Autoconf -*-
dnl Process this file with autoconf to produce a configure script.

AC_INIT([nhopkg], [0.5.1], [jaimegildesagredo@gmail.com])
AM_INIT_AUTOMAKE
AC_CONFIG_HEADERS(config.h)

dnl Option to disable gettext.

AM_GNU_GETTEXT([external])

dnl Check for pkg-config
PKG_PROG_PKG_CONFIG

dnl Nhopkg repository.

DEFAULT_NHOPKG_REPOSITORY="http://pub.jotahacker.es/nhopkg/repo/stable/`uname -m`"
AC_SUBST([NHOPKG_REPO])
AC_ARG_WITH([nhopkg-repo],
	[AC_HELP_STRING([--with-repo=DIR],
		[select other nhopkg repository as default.])],
	[NHOPKG_REPO=$withval], [NHOPKG_REPO=$DEFAULT_NHOPKG_REPOSITORY])

dnl Check for dependencies.

AC_PATH_PROG(BASH, bash, no)
if test x"$BASH" == x"no"; then
	exit 1
fi
AC_PATH_PROG(DU, du, no)
if test x"$DU" == x"no"; then
	exit 1
fi
AC_PATH_PROG(LN, ln, no)
if test x"$LN" == x"no"; then
	exit 1
fi
AC_PATH_PROG(PRINTF, printf, no)
if test x"$PRINTF" == x"no"; then
	exit 1
fi
AC_PATH_PROG(DATE, date, no)
if test x"$DATE" == x"no"; then
	exit 1
fi
AC_PATH_PROG(UNAME, uname, no)
if test x"$UNAME" == x"no"; then
	exit 1
fi
AC_PATH_PROG(MD5SUM, md5sum, no)
if test x"$MD5SUM" == x"no"; then
	exit 1
fi
AC_PATH_PROG(WGET, wget, no)
if test x"$WGET" == x"no"; then
	exit 1
fi
AC_PATH_PROG(BASENAME, basename, no)
if test x"$BASENAME" == x"no"; then
	exit 1
fi

AC_PATH_PROG(CAT, cat, no)
if test x"$CAT" == x"no"; then
	exit 1
fi
AC_PATH_PROG(XZCAT, xzcat, no)
if test x"$XZCAT" == x"no"; then
	exit 1
fi
AC_PATH_PROG(GREP, grep, no)
if test x"$GREP" == x"no"; then
	exit 1
fi
AC_PATH_PROG(XZGREP, xzgrep, no)
if test x"$XZGREP" == x"no"; then
	exit 1
fi
AC_PATH_PROG(HEAD, head, no)
if test x"$HEAD" == x"no"; then
	exit 1
fi
AC_PATH_PROG(TAIL, tail, no)
if test x"$TAIL" == x"no"; then
	exit 1
fi
AC_PATH_PROG(SORT, sort, no)
if test x"$SORT" == x"no"; then
	exit 1
fi
AC_PATH_PROG(FIND, find, no)
if test x"$FIND" == x"no"; then
	exit 1
fi
AC_PATH_PROG(LOCATE, locate, no)
if test x"$LOCATE" == x"no"; then
	exit 1
fi
AC_PATH_PROG(UPDATEDB, updatedb, no)
if test x"$UPDATEDB" == x"no"; then
	exit 1
fi

AC_PATH_PROG(TAR, tar, no)
if test x"$TAR" == x"no"; then
	exit 1
fi
AC_PATH_PROG(XZ, xz, no)
if test x"$XZ" == x"no"; then
	exit 1
fi

AC_CONFIG_FILES([ \
	Makefile \
	data/Makefile \
	data/nhopkg.8 \
	data/nhopkg.conf.5 \
	data/pixmaps/Makefile \
	po/Makefile.in \
	src/Makefile \
	src/nhopkg \
	src/nhopkg.conf \
	])

AC_OUTPUT

echo "
Configuration:

	Prefix:			${prefix}
	Sysconfig Dir:		${sysconfdir}
	Local State Dir:	${localstatedir}
	Software Repository:	${NHOPKG_REPO}
  After install ${PACKAGE} in your system, run ${PACKAGE_NAME} -u to initialize the database.
"
