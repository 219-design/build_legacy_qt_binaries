#configuration
CONFIG +=  shared def_files_disabled exceptions no_mocdepend release stl qt_no_framework
QT_ARCH = x86_64
QT_EDITION = OpenSource
QT_CONFIG +=  minimal-config small-config medium-config large-config full-config accessibility opengl shared reduce_exports ipv6 clock-gettime clock-monotonic mremap getaddrinfo ipv6ifname getifaddrs inotify png system-freetype zlib nis iconv glib dbus x11sm xshape xvideo xsync xrender mitshm fontconfig xkb pulseaudio concurrent multimedia audio-backend svg release

#versioning
QT_VERSION = 4.8.7
QT_MAJOR_VERSION = 4
QT_MINOR_VERSION = 8
QT_PATCH_VERSION = 7

#namespaces
QT_LIBINFIX = 
QT_NAMESPACE = 
QT_NAMESPACE_MAC_CRC = 

QMAKE_RPATHDIR += "/opt/legacy_qt/qt487_desktop/lib"
QT_GCC_MAJOR_VERSION = 7
QT_GCC_MINOR_VERSION = 0
QT_GCC_PATCH_VERSION = 0
