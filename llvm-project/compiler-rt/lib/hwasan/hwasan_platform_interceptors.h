#ifndef HWASAN_PLATFORM_INTERCEPTORS_H
#define HWASAN_PLATFORM_INTERCEPTORS_H

#include "sanitizer_common/sanitizer_platform_interceptors.h"

// This file cancels out most of the sanitizer_common interception, thus
// allowing HWASan to selectively reuse some of the interceptors.
//
// To re-enable sanitizer_common's interception of a function, comment out
// the corresponding '#undef SANITIZER_INTERCEPT_fn' and
// '#define SANITIZER_INTERCEPT_fn 0':
// - We prefer to comment out rather than delete the lines, to show that
//   it is deliberate, rather than an accidental omission.
// - We do not use '#define SANITIZE_INTERCEPT_fn 1', because
//   interception is usually conditional (e.g., based on SI_POSIX); we let
//   the condition in sanitizers_platform_interceptors.h take effect.

// Originally generated with:
//     cat ../sanitizer_common/sanitizer_platform_interceptors.h  | grep '^#define SANITIZER_INTERCEPT' | cut -d ' ' -f 2 | while read x; do echo "#undef $x"; echo "#define $x 0"; echo; done
#undef SANITIZER_INTERCEPT_STRLEN
#define SANITIZER_INTERCEPT_STRLEN 0

#undef SANITIZER_INTERCEPT_STRNLEN
#define SANITIZER_INTERCEPT_STRNLEN 0

#undef SANITIZER_INTERCEPT_STRCMP
#define SANITIZER_INTERCEPT_STRCMP 0

#undef SANITIZER_INTERCEPT_STRSTR
#define SANITIZER_INTERCEPT_STRSTR 0

#undef SANITIZER_INTERCEPT_STRCASESTR
#define SANITIZER_INTERCEPT_STRCASESTR 0

#undef SANITIZER_INTERCEPT_STRTOK
#define SANITIZER_INTERCEPT_STRTOK 0

#undef SANITIZER_INTERCEPT_STRCHR
#define SANITIZER_INTERCEPT_STRCHR 0

#undef SANITIZER_INTERCEPT_STRCHRNUL
#define SANITIZER_INTERCEPT_STRCHRNUL 0

#undef SANITIZER_INTERCEPT_STRRCHR
#define SANITIZER_INTERCEPT_STRRCHR 0

#undef SANITIZER_INTERCEPT_STRSPN
#define SANITIZER_INTERCEPT_STRSPN 0

#undef SANITIZER_INTERCEPT_STRPBRK
#define SANITIZER_INTERCEPT_STRPBRK 0

#undef SANITIZER_INTERCEPT_TEXTDOMAIN
#define SANITIZER_INTERCEPT_TEXTDOMAIN 0

#undef SANITIZER_INTERCEPT_STRCASECMP
#define SANITIZER_INTERCEPT_STRCASECMP 0

// #undef SANITIZER_INTERCEPT_MEMSET
// #define SANITIZER_INTERCEPT_MEMSET 0

// #undef SANITIZER_INTERCEPT_MEMMOVE
// #define SANITIZER_INTERCEPT_MEMMOVE 0

// #undef SANITIZER_INTERCEPT_MEMCPY
// #define SANITIZER_INTERCEPT_MEMCPY 0

// #undef SANITIZER_INTERCEPT_MEMCMP
// #define SANITIZER_INTERCEPT_MEMCMP 0

// #undef SANITIZER_INTERCEPT_BCMP
// #define SANITIZER_INTERCEPT_BCMP 0

#undef SANITIZER_INTERCEPT_STRNDUP
#define SANITIZER_INTERCEPT_STRNDUP 0

#undef SANITIZER_INTERCEPT___STRNDUP
#define SANITIZER_INTERCEPT___STRNDUP 0

#undef SANITIZER_INTERCEPT_MEMMEM
#define SANITIZER_INTERCEPT_MEMMEM 0

#undef SANITIZER_INTERCEPT_MEMCHR
#define SANITIZER_INTERCEPT_MEMCHR 0

#undef SANITIZER_INTERCEPT_MEMRCHR
#define SANITIZER_INTERCEPT_MEMRCHR 0

#undef SANITIZER_INTERCEPT_READ
#define SANITIZER_INTERCEPT_READ 0

#undef SANITIZER_INTERCEPT_PREAD
#define SANITIZER_INTERCEPT_PREAD 0

#undef SANITIZER_INTERCEPT_WRITE
#define SANITIZER_INTERCEPT_WRITE 0

#undef SANITIZER_INTERCEPT_PWRITE
#define SANITIZER_INTERCEPT_PWRITE 0

#undef SANITIZER_INTERCEPT_FREAD
#define SANITIZER_INTERCEPT_FREAD 0

#undef SANITIZER_INTERCEPT_FWRITE
#define SANITIZER_INTERCEPT_FWRITE 0

#undef SANITIZER_INTERCEPT_FGETS
#define SANITIZER_INTERCEPT_FGETS 0

#undef SANITIZER_INTERCEPT_FPUTS
#define SANITIZER_INTERCEPT_FPUTS 0

#undef SANITIZER_INTERCEPT_PUTS
#define SANITIZER_INTERCEPT_PUTS 0

#undef SANITIZER_INTERCEPT_PREAD64
#define SANITIZER_INTERCEPT_PREAD64 0

#undef SANITIZER_INTERCEPT_PWRITE64
#define SANITIZER_INTERCEPT_PWRITE64 0

#undef SANITIZER_INTERCEPT_READV
#define SANITIZER_INTERCEPT_READV 0

#undef SANITIZER_INTERCEPT_WRITEV
#define SANITIZER_INTERCEPT_WRITEV 0

#undef SANITIZER_INTERCEPT_PREADV
#define SANITIZER_INTERCEPT_PREADV 0

#undef SANITIZER_INTERCEPT_PWRITEV
#define SANITIZER_INTERCEPT_PWRITEV 0

#undef SANITIZER_INTERCEPT_PREADV64
#define SANITIZER_INTERCEPT_PREADV64 0

#undef SANITIZER_INTERCEPT_PWRITEV64
#define SANITIZER_INTERCEPT_PWRITEV64 0

#undef SANITIZER_INTERCEPT_PRCTL
#define SANITIZER_INTERCEPT_PRCTL 0

#undef SANITIZER_INTERCEPT_LOCALTIME_AND_FRIENDS
#define SANITIZER_INTERCEPT_LOCALTIME_AND_FRIENDS 0

#undef SANITIZER_INTERCEPT_STRPTIME
#define SANITIZER_INTERCEPT_STRPTIME 0

#undef SANITIZER_INTERCEPT_SCANF
#define SANITIZER_INTERCEPT_SCANF 0

#undef SANITIZER_INTERCEPT_ISOC99_SCANF
#define SANITIZER_INTERCEPT_ISOC99_SCANF 0

#undef SANITIZER_INTERCEPT_PRINTF
#define SANITIZER_INTERCEPT_PRINTF 0

#undef SANITIZER_INTERCEPT_PRINTF_L
#define SANITIZER_INTERCEPT_PRINTF_L 0

#undef SANITIZER_INTERCEPT_ISOC99_PRINTF
#define SANITIZER_INTERCEPT_ISOC99_PRINTF 0

#undef SANITIZER_INTERCEPT___PRINTF_CHK
#define SANITIZER_INTERCEPT___PRINTF_CHK 0

#undef SANITIZER_INTERCEPT_FREXP
#define SANITIZER_INTERCEPT_FREXP 0

#undef SANITIZER_INTERCEPT_FREXPF_FREXPL
#define SANITIZER_INTERCEPT_FREXPF_FREXPL 0

#undef SANITIZER_INTERCEPT_GETPWNAM_AND_FRIENDS
#define SANITIZER_INTERCEPT_GETPWNAM_AND_FRIENDS 0

#undef SANITIZER_INTERCEPT_GETPWNAM_R_AND_FRIENDS
#define SANITIZER_INTERCEPT_GETPWNAM_R_AND_FRIENDS 0

#undef SANITIZER_INTERCEPT_GETPWENT
#define SANITIZER_INTERCEPT_GETPWENT 0

#undef SANITIZER_INTERCEPT_FGETGRENT_R
#define SANITIZER_INTERCEPT_FGETGRENT_R 0

#undef SANITIZER_INTERCEPT_FGETPWENT
#define SANITIZER_INTERCEPT_FGETPWENT 0

#undef SANITIZER_INTERCEPT_GETPWENT_R
#define SANITIZER_INTERCEPT_GETPWENT_R 0

#undef SANITIZER_INTERCEPT_FGETPWENT_R
#define SANITIZER_INTERCEPT_FGETPWENT_R 0

#undef SANITIZER_INTERCEPT_SETPWENT
#define SANITIZER_INTERCEPT_SETPWENT 0

#undef SANITIZER_INTERCEPT_CLOCK_GETTIME
#define SANITIZER_INTERCEPT_CLOCK_GETTIME 0

#undef SANITIZER_INTERCEPT_CLOCK_GETCPUCLOCKID
#define SANITIZER_INTERCEPT_CLOCK_GETCPUCLOCKID 0

#undef SANITIZER_INTERCEPT_TIMER_CREATE
#define SANITIZER_INTERCEPT_TIMER_CREATE 0

#undef SANITIZER_INTERCEPT_GETITIMER
#define SANITIZER_INTERCEPT_GETITIMER 0

#undef SANITIZER_INTERCEPT_TIME
#define SANITIZER_INTERCEPT_TIME 0

#undef SANITIZER_INTERCEPT_GLOB
#define SANITIZER_INTERCEPT_GLOB 0

#undef SANITIZER_INTERCEPT_GLOB64
#define SANITIZER_INTERCEPT_GLOB64 0

#undef SANITIZER_INTERCEPT___B64_TO
#define SANITIZER_INTERCEPT___B64_TO 0

#undef SANITIZER_INTERCEPT_DN_COMP_EXPAND
#define SANITIZER_INTERCEPT_DN_COMP_EXPAND 0

#undef SANITIZER_INTERCEPT_POSIX_SPAWN
#define SANITIZER_INTERCEPT_POSIX_SPAWN 0

#undef SANITIZER_INTERCEPT_WAIT
#define SANITIZER_INTERCEPT_WAIT 0

#undef SANITIZER_INTERCEPT_INET
#define SANITIZER_INTERCEPT_INET 0

#undef SANITIZER_INTERCEPT_PTHREAD_GETSCHEDPARAM
#define SANITIZER_INTERCEPT_PTHREAD_GETSCHEDPARAM 0

#undef SANITIZER_INTERCEPT_GETADDRINFO
#define SANITIZER_INTERCEPT_GETADDRINFO 0

#undef SANITIZER_INTERCEPT_GETNAMEINFO
#define SANITIZER_INTERCEPT_GETNAMEINFO 0

#undef SANITIZER_INTERCEPT_GETSOCKNAME
#define SANITIZER_INTERCEPT_GETSOCKNAME 0

#undef SANITIZER_INTERCEPT_GETHOSTBYNAME
#define SANITIZER_INTERCEPT_GETHOSTBYNAME 0

#undef SANITIZER_INTERCEPT_GETHOSTBYNAME2
#define SANITIZER_INTERCEPT_GETHOSTBYNAME2 0

#undef SANITIZER_INTERCEPT_GETHOSTBYNAME_R
#define SANITIZER_INTERCEPT_GETHOSTBYNAME_R 0

#undef SANITIZER_INTERCEPT_GETHOSTBYNAME2_R
#define SANITIZER_INTERCEPT_GETHOSTBYNAME2_R 0

#undef SANITIZER_INTERCEPT_GETHOSTBYADDR_R
#define SANITIZER_INTERCEPT_GETHOSTBYADDR_R 0

#undef SANITIZER_INTERCEPT_GETHOSTENT_R
#define SANITIZER_INTERCEPT_GETHOSTENT_R 0

#undef SANITIZER_INTERCEPT_GETSOCKOPT
#define SANITIZER_INTERCEPT_GETSOCKOPT 0

#undef SANITIZER_INTERCEPT_ACCEPT
#define SANITIZER_INTERCEPT_ACCEPT 0

#undef SANITIZER_INTERCEPT_ACCEPT4
#define SANITIZER_INTERCEPT_ACCEPT4 0

#undef SANITIZER_INTERCEPT_PACCEPT
#define SANITIZER_INTERCEPT_PACCEPT 0

#undef SANITIZER_INTERCEPT_MODF
#define SANITIZER_INTERCEPT_MODF 0

#undef SANITIZER_INTERCEPT_RECVMSG
#define SANITIZER_INTERCEPT_RECVMSG 0

#undef SANITIZER_INTERCEPT_SENDMSG
#define SANITIZER_INTERCEPT_SENDMSG 0

#undef SANITIZER_INTERCEPT_RECVMMSG
#define SANITIZER_INTERCEPT_RECVMMSG 0

#undef SANITIZER_INTERCEPT_SENDMMSG
#define SANITIZER_INTERCEPT_SENDMMSG 0

#undef SANITIZER_INTERCEPT_SYSMSG
#define SANITIZER_INTERCEPT_SYSMSG 0

#undef SANITIZER_INTERCEPT_GETPEERNAME
#define SANITIZER_INTERCEPT_GETPEERNAME 0

#undef SANITIZER_INTERCEPT_IOCTL
#define SANITIZER_INTERCEPT_IOCTL 0

#undef SANITIZER_INTERCEPT_INET_ATON
#define SANITIZER_INTERCEPT_INET_ATON 0

#undef SANITIZER_INTERCEPT_SYSINFO
#define SANITIZER_INTERCEPT_SYSINFO 0

#undef SANITIZER_INTERCEPT_READDIR
#define SANITIZER_INTERCEPT_READDIR 0

#undef SANITIZER_INTERCEPT_READDIR64
#define SANITIZER_INTERCEPT_READDIR64 0

#undef SANITIZER_INTERCEPT_PTRACE
#define SANITIZER_INTERCEPT_PTRACE 0

#undef SANITIZER_INTERCEPT_PTRACE
#define SANITIZER_INTERCEPT_PTRACE 0

#undef SANITIZER_INTERCEPT_SETLOCALE
#define SANITIZER_INTERCEPT_SETLOCALE 0

#undef SANITIZER_INTERCEPT_GETCWD
#define SANITIZER_INTERCEPT_GETCWD 0

#undef SANITIZER_INTERCEPT_GET_CURRENT_DIR_NAME
#define SANITIZER_INTERCEPT_GET_CURRENT_DIR_NAME 0

#undef SANITIZER_INTERCEPT_STRTOIMAX
#define SANITIZER_INTERCEPT_STRTOIMAX 0

#undef SANITIZER_INTERCEPT_MBSTOWCS
#define SANITIZER_INTERCEPT_MBSTOWCS 0

#undef SANITIZER_INTERCEPT_MBSNRTOWCS
#define SANITIZER_INTERCEPT_MBSNRTOWCS 0

#undef SANITIZER_INTERCEPT_WCSTOMBS
#define SANITIZER_INTERCEPT_WCSTOMBS 0

#undef SANITIZER_INTERCEPT_STRXFRM
#define SANITIZER_INTERCEPT_STRXFRM 0

#undef SANITIZER_INTERCEPT___STRXFRM_L
#define SANITIZER_INTERCEPT___STRXFRM_L 0

#undef SANITIZER_INTERCEPT_WCSXFRM
#define SANITIZER_INTERCEPT_WCSXFRM 0

#undef SANITIZER_INTERCEPT___WCSXFRM_L
#define SANITIZER_INTERCEPT___WCSXFRM_L 0

#undef SANITIZER_INTERCEPT_WCSNRTOMBS
#define SANITIZER_INTERCEPT_WCSNRTOMBS 0

#undef SANITIZER_INTERCEPT_WCRTOMB
#define SANITIZER_INTERCEPT_WCRTOMB 0

#undef SANITIZER_INTERCEPT_WCTOMB
#define SANITIZER_INTERCEPT_WCTOMB 0

#undef SANITIZER_INTERCEPT_TCGETATTR
#define SANITIZER_INTERCEPT_TCGETATTR 0

#undef SANITIZER_INTERCEPT_REALPATH
#define SANITIZER_INTERCEPT_REALPATH 0

#undef SANITIZER_INTERCEPT_CANONICALIZE_FILE_NAME
#define SANITIZER_INTERCEPT_CANONICALIZE_FILE_NAME 0

#undef SANITIZER_INTERCEPT_CONFSTR
#define SANITIZER_INTERCEPT_CONFSTR 0

#undef SANITIZER_INTERCEPT_SCHED_GETAFFINITY
#define SANITIZER_INTERCEPT_SCHED_GETAFFINITY 0

#undef SANITIZER_INTERCEPT_SCHED_GETPARAM
#define SANITIZER_INTERCEPT_SCHED_GETPARAM 0

#undef SANITIZER_INTERCEPT_STRERROR
#define SANITIZER_INTERCEPT_STRERROR 0

#undef SANITIZER_INTERCEPT_STRERROR_R
#define SANITIZER_INTERCEPT_STRERROR_R 0

#undef SANITIZER_INTERCEPT_XPG_STRERROR_R
#define SANITIZER_INTERCEPT_XPG_STRERROR_R 0

#undef SANITIZER_INTERCEPT_SCANDIR
#define SANITIZER_INTERCEPT_SCANDIR 0

#undef SANITIZER_INTERCEPT_SCANDIR64
#define SANITIZER_INTERCEPT_SCANDIR64 0

#undef SANITIZER_INTERCEPT_GETGROUPS
#define SANITIZER_INTERCEPT_GETGROUPS 0

#undef SANITIZER_INTERCEPT_POLL
#define SANITIZER_INTERCEPT_POLL 0

#undef SANITIZER_INTERCEPT_PPOLL
#define SANITIZER_INTERCEPT_PPOLL 0

#undef SANITIZER_INTERCEPT_WORDEXP
#define SANITIZER_INTERCEPT_WORDEXP 0

#undef SANITIZER_INTERCEPT_SIGWAIT
#define SANITIZER_INTERCEPT_SIGWAIT 0

#undef SANITIZER_INTERCEPT_SIGWAITINFO
#define SANITIZER_INTERCEPT_SIGWAITINFO 0

#undef SANITIZER_INTERCEPT_SIGTIMEDWAIT
#define SANITIZER_INTERCEPT_SIGTIMEDWAIT 0

#undef SANITIZER_INTERCEPT_SIGSETOPS
#define SANITIZER_INTERCEPT_SIGSETOPS 0

#undef SANITIZER_INTERCEPT_SIGSET_LOGICOPS
#define SANITIZER_INTERCEPT_SIGSET_LOGICOPS 0

#undef SANITIZER_INTERCEPT_SIGPENDING
#define SANITIZER_INTERCEPT_SIGPENDING 0

#undef SANITIZER_INTERCEPT_SIGPROCMASK
#define SANITIZER_INTERCEPT_SIGPROCMASK 0

#undef SANITIZER_INTERCEPT_PTHREAD_SIGMASK
#define SANITIZER_INTERCEPT_PTHREAD_SIGMASK 0

#undef SANITIZER_INTERCEPT_BACKTRACE
#define SANITIZER_INTERCEPT_BACKTRACE 0

#undef SANITIZER_INTERCEPT_GETMNTENT
#define SANITIZER_INTERCEPT_GETMNTENT 0

#undef SANITIZER_INTERCEPT_GETMNTENT_R
#define SANITIZER_INTERCEPT_GETMNTENT_R 0

#undef SANITIZER_INTERCEPT_STATFS
#define SANITIZER_INTERCEPT_STATFS 0

#undef SANITIZER_INTERCEPT_STATFS64
#define SANITIZER_INTERCEPT_STATFS64 0

#undef SANITIZER_INTERCEPT_STATVFS
#define SANITIZER_INTERCEPT_STATVFS 0

#undef SANITIZER_INTERCEPT_STATVFS64
#define SANITIZER_INTERCEPT_STATVFS64 0

#undef SANITIZER_INTERCEPT_INITGROUPS
#define SANITIZER_INTERCEPT_INITGROUPS 0

#undef SANITIZER_INTERCEPT_ETHER_NTOA_ATON
#define SANITIZER_INTERCEPT_ETHER_NTOA_ATON 0

#undef SANITIZER_INTERCEPT_ETHER_HOST
#define SANITIZER_INTERCEPT_ETHER_HOST 0

#undef SANITIZER_INTERCEPT_ETHER_R
#define SANITIZER_INTERCEPT_ETHER_R 0

#undef SANITIZER_INTERCEPT_SHMCTL
#define SANITIZER_INTERCEPT_SHMCTL 0

#undef SANITIZER_INTERCEPT_RANDOM_R
#define SANITIZER_INTERCEPT_RANDOM_R 0

#undef SANITIZER_INTERCEPT_PTHREAD_ATTR_GET
#define SANITIZER_INTERCEPT_PTHREAD_ATTR_GET 0

#undef SANITIZER_INTERCEPT_PTHREAD_ATTR_GETINHERITSCHED
#define SANITIZER_INTERCEPT_PTHREAD_ATTR_GETINHERITSCHED 0

#undef SANITIZER_INTERCEPT_PTHREAD_ATTR_GETAFFINITY_NP
#define SANITIZER_INTERCEPT_PTHREAD_ATTR_GETAFFINITY_NP 0

#undef SANITIZER_INTERCEPT_PTHREAD_GETAFFINITY_NP
#define SANITIZER_INTERCEPT_PTHREAD_GETAFFINITY_NP 0

#undef SANITIZER_INTERCEPT_PTHREAD_ATTR_GET_SCHED
#define SANITIZER_INTERCEPT_PTHREAD_ATTR_GET_SCHED 0

#undef SANITIZER_INTERCEPT_PTHREAD_MUTEXATTR_GETPSHARED
#define SANITIZER_INTERCEPT_PTHREAD_MUTEXATTR_GETPSHARED 0

#undef SANITIZER_INTERCEPT_PTHREAD_MUTEXATTR_GETTYPE
#define SANITIZER_INTERCEPT_PTHREAD_MUTEXATTR_GETTYPE 0

#undef SANITIZER_INTERCEPT_PTHREAD_MUTEXATTR_GETPROTOCOL
#define SANITIZER_INTERCEPT_PTHREAD_MUTEXATTR_GETPROTOCOL 0

#undef SANITIZER_INTERCEPT_PTHREAD_MUTEXATTR_GETPRIOCEILING
#define SANITIZER_INTERCEPT_PTHREAD_MUTEXATTR_GETPRIOCEILING 0

#undef SANITIZER_INTERCEPT_PTHREAD_MUTEXATTR_GETROBUST
#define SANITIZER_INTERCEPT_PTHREAD_MUTEXATTR_GETROBUST 0

#undef SANITIZER_INTERCEPT_PTHREAD_MUTEXATTR_GETROBUST_NP
#define SANITIZER_INTERCEPT_PTHREAD_MUTEXATTR_GETROBUST_NP 0

#undef SANITIZER_INTERCEPT_PTHREAD_RWLOCKATTR_GETPSHARED
#define SANITIZER_INTERCEPT_PTHREAD_RWLOCKATTR_GETPSHARED 0

#undef SANITIZER_INTERCEPT_PTHREAD_RWLOCKATTR_GETKIND_NP
#define SANITIZER_INTERCEPT_PTHREAD_RWLOCKATTR_GETKIND_NP 0

#undef SANITIZER_INTERCEPT_PTHREAD_CONDATTR_GETPSHARED
#define SANITIZER_INTERCEPT_PTHREAD_CONDATTR_GETPSHARED 0

#undef SANITIZER_INTERCEPT_PTHREAD_CONDATTR_GETCLOCK
#define SANITIZER_INTERCEPT_PTHREAD_CONDATTR_GETCLOCK 0

#undef SANITIZER_INTERCEPT_PTHREAD_BARRIERATTR_GETPSHARED
#define SANITIZER_INTERCEPT_PTHREAD_BARRIERATTR_GETPSHARED 0

#undef SANITIZER_INTERCEPT_TRYJOIN
#define SANITIZER_INTERCEPT_TRYJOIN 0

#undef SANITIZER_INTERCEPT_TIMEDJOIN
#define SANITIZER_INTERCEPT_TIMEDJOIN 0

#undef SANITIZER_INTERCEPT_THR_EXIT
#define SANITIZER_INTERCEPT_THR_EXIT 0

#undef SANITIZER_INTERCEPT_TMPNAM
#define SANITIZER_INTERCEPT_TMPNAM 0

#undef SANITIZER_INTERCEPT_TMPNAM_R
#define SANITIZER_INTERCEPT_TMPNAM_R 0

#undef SANITIZER_INTERCEPT_PTSNAME
#define SANITIZER_INTERCEPT_PTSNAME 0

#undef SANITIZER_INTERCEPT_PTSNAME_R
#define SANITIZER_INTERCEPT_PTSNAME_R 0

#undef SANITIZER_INTERCEPT_TTYNAME
#define SANITIZER_INTERCEPT_TTYNAME 0

#undef SANITIZER_INTERCEPT_TTYNAME_R
#define SANITIZER_INTERCEPT_TTYNAME_R 0

#undef SANITIZER_INTERCEPT_TEMPNAM
#define SANITIZER_INTERCEPT_TEMPNAM 0

#undef SANITIZER_INTERCEPT_SINCOS
#define SANITIZER_INTERCEPT_SINCOS 0

#undef SANITIZER_INTERCEPT_REMQUO
#define SANITIZER_INTERCEPT_REMQUO 0

#undef SANITIZER_INTERCEPT_REMQUOL
#define SANITIZER_INTERCEPT_REMQUOL 0

#undef SANITIZER_INTERCEPT_LGAMMA
#define SANITIZER_INTERCEPT_LGAMMA 0

#undef SANITIZER_INTERCEPT_LGAMMAL
#define SANITIZER_INTERCEPT_LGAMMAL 0

#undef SANITIZER_INTERCEPT_LGAMMA_R
#define SANITIZER_INTERCEPT_LGAMMA_R 0

#undef SANITIZER_INTERCEPT_LGAMMAL_R
#define SANITIZER_INTERCEPT_LGAMMAL_R 0

#undef SANITIZER_INTERCEPT_DRAND48_R
#define SANITIZER_INTERCEPT_DRAND48_R 0

#undef SANITIZER_INTERCEPT_RAND_R
#define SANITIZER_INTERCEPT_RAND_R 0

#undef SANITIZER_INTERCEPT_ICONV
#define SANITIZER_INTERCEPT_ICONV 0

#undef SANITIZER_INTERCEPT_TIMES
#define SANITIZER_INTERCEPT_TIMES 0

#undef SANITIZER_INTERCEPT_GETLINE
#define SANITIZER_INTERCEPT_GETLINE 0

#undef SANITIZER_INTERCEPT__EXIT
#define SANITIZER_INTERCEPT__EXIT 0

#undef SANITIZER_INTERCEPT___LIBC_MUTEX
#define SANITIZER_INTERCEPT___LIBC_MUTEX 0

#undef SANITIZER_INTERCEPT_PTHREAD_SETNAME_NP
#define SANITIZER_INTERCEPT_PTHREAD_SETNAME_NP 0

#undef SANITIZER_INTERCEPT_PTHREAD_GETNAME_NP
#define SANITIZER_INTERCEPT_PTHREAD_GETNAME_NP 0

#undef SANITIZER_INTERCEPT_TLS_GET_ADDR
#define SANITIZER_INTERCEPT_TLS_GET_ADDR 0

#undef SANITIZER_INTERCEPT_LISTXATTR
#define SANITIZER_INTERCEPT_LISTXATTR 0

#undef SANITIZER_INTERCEPT_GETXATTR
#define SANITIZER_INTERCEPT_GETXATTR 0

#undef SANITIZER_INTERCEPT_GETRESID
#define SANITIZER_INTERCEPT_GETRESID 0

#undef SANITIZER_INTERCEPT_GETIFADDRS
#define SANITIZER_INTERCEPT_GETIFADDRS 0

#undef SANITIZER_INTERCEPT_IF_INDEXTONAME
#define SANITIZER_INTERCEPT_IF_INDEXTONAME 0

#undef SANITIZER_INTERCEPT_CAPGET
#define SANITIZER_INTERCEPT_CAPGET 0

#undef SANITIZER_INTERCEPT_AEABI_MEM
#define SANITIZER_INTERCEPT_AEABI_MEM 0

#undef SANITIZER_INTERCEPT_AEABI_MEM
#define SANITIZER_INTERCEPT_AEABI_MEM 0

#undef SANITIZER_INTERCEPT___BZERO
#define SANITIZER_INTERCEPT___BZERO 0

#undef SANITIZER_INTERCEPT_BZERO
#define SANITIZER_INTERCEPT_BZERO 0

#undef SANITIZER_INTERCEPT_FTIME
#define SANITIZER_INTERCEPT_FTIME 0

#undef SANITIZER_INTERCEPT_XDR
#define SANITIZER_INTERCEPT_XDR 0

#undef SANITIZER_INTERCEPT_XDRREC
#define SANITIZER_INTERCEPT_XDRREC 0

#undef SANITIZER_INTERCEPT_TSEARCH
#define SANITIZER_INTERCEPT_TSEARCH 0

#undef SANITIZER_INTERCEPT_LIBIO_INTERNALS
#define SANITIZER_INTERCEPT_LIBIO_INTERNALS 0

#undef SANITIZER_INTERCEPT_FOPEN
#define SANITIZER_INTERCEPT_FOPEN 0

#undef SANITIZER_INTERCEPT_FOPEN64
#define SANITIZER_INTERCEPT_FOPEN64 0

#undef SANITIZER_INTERCEPT_OPEN_MEMSTREAM
#define SANITIZER_INTERCEPT_OPEN_MEMSTREAM 0

#undef SANITIZER_INTERCEPT_OBSTACK
#define SANITIZER_INTERCEPT_OBSTACK 0

#undef SANITIZER_INTERCEPT_FFLUSH
#define SANITIZER_INTERCEPT_FFLUSH 0

#undef SANITIZER_INTERCEPT_FCLOSE
#define SANITIZER_INTERCEPT_FCLOSE 0

#undef SANITIZER_INTERCEPT_DLOPEN_DLCLOSE
#define SANITIZER_INTERCEPT_DLOPEN_DLCLOSE 0

#undef SANITIZER_INTERCEPT_GETPASS
#define SANITIZER_INTERCEPT_GETPASS 0

#undef SANITIZER_INTERCEPT_TIMERFD
#define SANITIZER_INTERCEPT_TIMERFD 0

#undef SANITIZER_INTERCEPT_MLOCKX
#define SANITIZER_INTERCEPT_MLOCKX 0

#undef SANITIZER_INTERCEPT_FOPENCOOKIE
#define SANITIZER_INTERCEPT_FOPENCOOKIE 0

#undef SANITIZER_INTERCEPT_SEM
#define SANITIZER_INTERCEPT_SEM 0

#undef SANITIZER_INTERCEPT_PTHREAD_SETCANCEL
#define SANITIZER_INTERCEPT_PTHREAD_SETCANCEL 0

#undef SANITIZER_INTERCEPT_MINCORE
#define SANITIZER_INTERCEPT_MINCORE 0

#undef SANITIZER_INTERCEPT_PROCESS_VM_READV
#define SANITIZER_INTERCEPT_PROCESS_VM_READV 0

#undef SANITIZER_INTERCEPT_CTERMID
#define SANITIZER_INTERCEPT_CTERMID 0

#undef SANITIZER_INTERCEPT_CTERMID_R
#define SANITIZER_INTERCEPT_CTERMID_R 0

#undef SANITIZER_INTERCEPTOR_HOOKS
#define SANITIZER_INTERCEPTOR_HOOKS 0

#undef SANITIZER_INTERCEPT_RECV_RECVFROM
#define SANITIZER_INTERCEPT_RECV_RECVFROM 0

#undef SANITIZER_INTERCEPT_SEND_SENDTO
#define SANITIZER_INTERCEPT_SEND_SENDTO 0

#undef SANITIZER_INTERCEPT_EVENTFD_READ_WRITE
#define SANITIZER_INTERCEPT_EVENTFD_READ_WRITE 0

#undef SANITIZER_INTERCEPT_STAT
#define SANITIZER_INTERCEPT_STAT 0

#undef SANITIZER_INTERCEPT_STAT64
#define SANITIZER_INTERCEPT_STAT64 0

#undef SANITIZER_INTERCEPT_LSTAT
#define SANITIZER_INTERCEPT_LSTAT 0

#undef SANITIZER_INTERCEPT___XSTAT
#define SANITIZER_INTERCEPT___XSTAT 0

#undef SANITIZER_INTERCEPT___XSTAT64
#define SANITIZER_INTERCEPT___XSTAT64 0

#undef SANITIZER_INTERCEPT___LXSTAT
#define SANITIZER_INTERCEPT___LXSTAT 0

#undef SANITIZER_INTERCEPT___LXSTAT64
#define SANITIZER_INTERCEPT___LXSTAT64 0

#undef SANITIZER_INTERCEPT_UTMP
#define SANITIZER_INTERCEPT_UTMP 0

#undef SANITIZER_INTERCEPT_UTMPX
#define SANITIZER_INTERCEPT_UTMPX 0

#undef SANITIZER_INTERCEPT_GETLOADAVG
#define SANITIZER_INTERCEPT_GETLOADAVG 0

// #undef SANITIZER_INTERCEPT_MMAP
// #define SANITIZER_INTERCEPT_MMAP 0

#undef SANITIZER_INTERCEPT_MMAP64
#define SANITIZER_INTERCEPT_MMAP64 0

#undef SANITIZER_INTERCEPT_MALLOPT_AND_MALLINFO
#define SANITIZER_INTERCEPT_MALLOPT_AND_MALLINFO 0

#undef SANITIZER_INTERCEPT_MEMALIGN
#define SANITIZER_INTERCEPT_MEMALIGN 0

#undef SANITIZER_INTERCEPT___LIBC_MEMALIGN
#define SANITIZER_INTERCEPT___LIBC_MEMALIGN 0

#undef SANITIZER_INTERCEPT_PVALLOC
#define SANITIZER_INTERCEPT_PVALLOC 0

#undef SANITIZER_INTERCEPT_CFREE
#define SANITIZER_INTERCEPT_CFREE 0

#undef SANITIZER_INTERCEPT_REALLOCARRAY
#define SANITIZER_INTERCEPT_REALLOCARRAY 0

#undef SANITIZER_INTERCEPT_ALIGNED_ALLOC
#define SANITIZER_INTERCEPT_ALIGNED_ALLOC 0

#undef SANITIZER_INTERCEPT_MALLOC_USABLE_SIZE
#define SANITIZER_INTERCEPT_MALLOC_USABLE_SIZE 0

#undef SANITIZER_INTERCEPT_MCHECK_MPROBE
#define SANITIZER_INTERCEPT_MCHECK_MPROBE 0

#undef SANITIZER_INTERCEPT_WCSLEN
#define SANITIZER_INTERCEPT_WCSLEN 0

#undef SANITIZER_INTERCEPT_WCSCAT
#define SANITIZER_INTERCEPT_WCSCAT 0

#undef SANITIZER_INTERCEPT_WCSDUP
#define SANITIZER_INTERCEPT_WCSDUP 0

#undef SANITIZER_INTERCEPT_SIGNAL_AND_SIGACTION
#define SANITIZER_INTERCEPT_SIGNAL_AND_SIGACTION 0

#undef SANITIZER_INTERCEPT_BSD_SIGNAL
#define SANITIZER_INTERCEPT_BSD_SIGNAL 0

#undef SANITIZER_INTERCEPT_ACCT
#define SANITIZER_INTERCEPT_ACCT 0

#undef SANITIZER_INTERCEPT_USER_FROM_UID
#define SANITIZER_INTERCEPT_USER_FROM_UID 0

#undef SANITIZER_INTERCEPT_UID_FROM_USER
#define SANITIZER_INTERCEPT_UID_FROM_USER 0

#undef SANITIZER_INTERCEPT_GROUP_FROM_GID
#define SANITIZER_INTERCEPT_GROUP_FROM_GID 0

#undef SANITIZER_INTERCEPT_GID_FROM_GROUP
#define SANITIZER_INTERCEPT_GID_FROM_GROUP 0

#undef SANITIZER_INTERCEPT_ACCESS
#define SANITIZER_INTERCEPT_ACCESS 0

#undef SANITIZER_INTERCEPT_FACCESSAT
#define SANITIZER_INTERCEPT_FACCESSAT 0

#undef SANITIZER_INTERCEPT_GETGROUPLIST
#define SANITIZER_INTERCEPT_GETGROUPLIST 0

#undef SANITIZER_INTERCEPT_STRLCPY
#define SANITIZER_INTERCEPT_STRLCPY 0

#undef SANITIZER_INTERCEPT_NAME_TO_HANDLE_AT
#define SANITIZER_INTERCEPT_NAME_TO_HANDLE_AT 0

#undef SANITIZER_INTERCEPT_OPEN_BY_HANDLE_AT
#define SANITIZER_INTERCEPT_OPEN_BY_HANDLE_AT 0

#undef SANITIZER_INTERCEPT_READLINK
#define SANITIZER_INTERCEPT_READLINK 0

#undef SANITIZER_INTERCEPT_READLINKAT
#define SANITIZER_INTERCEPT_READLINKAT 0

#undef SANITIZER_INTERCEPT_DEVNAME
#define SANITIZER_INTERCEPT_DEVNAME 0

#undef SANITIZER_INTERCEPT_DEVNAME_R
#define SANITIZER_INTERCEPT_DEVNAME_R 0

#undef SANITIZER_INTERCEPT_FGETLN
#define SANITIZER_INTERCEPT_FGETLN 0

#undef SANITIZER_INTERCEPT_STRMODE
#define SANITIZER_INTERCEPT_STRMODE 0

#undef SANITIZER_INTERCEPT_TTYENT
#define SANITIZER_INTERCEPT_TTYENT 0

#undef SANITIZER_INTERCEPT_TTYENTPATH
#define SANITIZER_INTERCEPT_TTYENTPATH 0

#undef SANITIZER_INTERCEPT_PROTOENT
#define SANITIZER_INTERCEPT_PROTOENT 0

#undef SANITIZER_INTERCEPT_PROTOENT_R
#define SANITIZER_INTERCEPT_PROTOENT_R 0

#undef SANITIZER_INTERCEPT_NETENT
#define SANITIZER_INTERCEPT_NETENT 0

#undef SANITIZER_INTERCEPT_SETVBUF
#define SANITIZER_INTERCEPT_SETVBUF 0

#undef SANITIZER_INTERCEPT_GETMNTINFO
#define SANITIZER_INTERCEPT_GETMNTINFO 0

#undef SANITIZER_INTERCEPT_MI_VECTOR_HASH
#define SANITIZER_INTERCEPT_MI_VECTOR_HASH 0

#undef SANITIZER_INTERCEPT_GETVFSSTAT
#define SANITIZER_INTERCEPT_GETVFSSTAT 0

#undef SANITIZER_INTERCEPT_REGEX
#define SANITIZER_INTERCEPT_REGEX 0

#undef SANITIZER_INTERCEPT_REGEXSUB
#define SANITIZER_INTERCEPT_REGEXSUB 0

#undef SANITIZER_INTERCEPT_FTS
#define SANITIZER_INTERCEPT_FTS 0

#undef SANITIZER_INTERCEPT_SYSCTL
#define SANITIZER_INTERCEPT_SYSCTL 0

#undef SANITIZER_INTERCEPT_ASYSCTL
#define SANITIZER_INTERCEPT_ASYSCTL 0

#undef SANITIZER_INTERCEPT_SYSCTLGETMIBINFO
#define SANITIZER_INTERCEPT_SYSCTLGETMIBINFO 0

#undef SANITIZER_INTERCEPT_NL_LANGINFO
#define SANITIZER_INTERCEPT_NL_LANGINFO 0

#undef SANITIZER_INTERCEPT_MODCTL
#define SANITIZER_INTERCEPT_MODCTL 0

#undef SANITIZER_INTERCEPT_CAPSICUM
#define SANITIZER_INTERCEPT_CAPSICUM 0

#undef SANITIZER_INTERCEPT_STRTONUM
#define SANITIZER_INTERCEPT_STRTONUM 0

#undef SANITIZER_INTERCEPT_FPARSELN
#define SANITIZER_INTERCEPT_FPARSELN 0

#undef SANITIZER_INTERCEPT_STATVFS1
#define SANITIZER_INTERCEPT_STATVFS1 0

#undef SANITIZER_INTERCEPT_STRTOI
#define SANITIZER_INTERCEPT_STRTOI 0

#undef SANITIZER_INTERCEPT_CAPSICUM
#define SANITIZER_INTERCEPT_CAPSICUM 0

#undef SANITIZER_INTERCEPT_SHA1
#define SANITIZER_INTERCEPT_SHA1 0

#undef SANITIZER_INTERCEPT_MD4
#define SANITIZER_INTERCEPT_MD4 0

#undef SANITIZER_INTERCEPT_RMD160
#define SANITIZER_INTERCEPT_RMD160 0

#undef SANITIZER_INTERCEPT_MD5
#define SANITIZER_INTERCEPT_MD5 0

#undef SANITIZER_INTERCEPT_FSEEK
#define SANITIZER_INTERCEPT_FSEEK 0

#undef SANITIZER_INTERCEPT_MD2
#define SANITIZER_INTERCEPT_MD2 0

#undef SANITIZER_INTERCEPT_SHA2
#define SANITIZER_INTERCEPT_SHA2 0

#undef SANITIZER_INTERCEPT_CDB
#define SANITIZER_INTERCEPT_CDB 0

#undef SANITIZER_INTERCEPT_VIS
#define SANITIZER_INTERCEPT_VIS 0

#undef SANITIZER_INTERCEPT_POPEN
#define SANITIZER_INTERCEPT_POPEN 0

#undef SANITIZER_INTERCEPT_POPENVE
#define SANITIZER_INTERCEPT_POPENVE 0

#undef SANITIZER_INTERCEPT_PCLOSE
#define SANITIZER_INTERCEPT_PCLOSE 0

#undef SANITIZER_INTERCEPT_FUNOPEN
#define SANITIZER_INTERCEPT_FUNOPEN 0

#undef SANITIZER_INTERCEPT_FUNOPEN2
#define SANITIZER_INTERCEPT_FUNOPEN2 0

#undef SANITIZER_INTERCEPT_GETFSENT
#define SANITIZER_INTERCEPT_GETFSENT 0

#undef SANITIZER_INTERCEPT_ARC4RANDOM
#define SANITIZER_INTERCEPT_ARC4RANDOM 0

#undef SANITIZER_INTERCEPT_FDEVNAME
#define SANITIZER_INTERCEPT_FDEVNAME 0

#undef SANITIZER_INTERCEPT_GETUSERSHELL
#define SANITIZER_INTERCEPT_GETUSERSHELL 0

#undef SANITIZER_INTERCEPT_SL_INIT
#define SANITIZER_INTERCEPT_SL_INIT 0

#undef SANITIZER_INTERCEPT_GETRANDOM
#define SANITIZER_INTERCEPT_GETRANDOM 0

#undef SANITIZER_INTERCEPT___CXA_ATEXIT
#define SANITIZER_INTERCEPT___CXA_ATEXIT 0

#undef SANITIZER_INTERCEPT_ATEXIT
#define SANITIZER_INTERCEPT_ATEXIT 0

#undef SANITIZER_INTERCEPT_PTHREAD_ATFORK
#define SANITIZER_INTERCEPT_PTHREAD_ATFORK 0

#undef SANITIZER_INTERCEPT_GETENTROPY
#define SANITIZER_INTERCEPT_GETENTROPY 0

#undef SANITIZER_INTERCEPT_QSORT
#define SANITIZER_INTERCEPT_QSORT 0

#undef SANITIZER_INTERCEPT_QSORT_R
#define SANITIZER_INTERCEPT_QSORT_R 0

#undef SANITIZER_INTERCEPT_BSEARCH
#define SANITIZER_INTERCEPT_BSEARCH 0

#undef SANITIZER_INTERCEPT_SIGALTSTACK
#define SANITIZER_INTERCEPT_SIGALTSTACK 0

#undef SANITIZER_INTERCEPT_UNAME
#define SANITIZER_INTERCEPT_UNAME 0

#undef SANITIZER_INTERCEPT___XUNAME
#define SANITIZER_INTERCEPT___XUNAME 0

#undef SANITIZER_INTERCEPT_FLOPEN
#define SANITIZER_INTERCEPT_FLOPEN 0

#undef SANITIZER_INTERCEPT_PROCCTL
#define SANITIZER_INTERCEPT_PROCCTL 0

#undef SANITIZER_INTERCEPT_HEXDUMP
#define SANITIZER_INTERCEPT_HEXDUMP 0

#undef SANITIZER_INTERCEPT_ARGP_PARSE
#define SANITIZER_INTERCEPT_ARGP_PARSE 0

#endif // HWASAN_PLATFORM_INTERCEPTORS_H