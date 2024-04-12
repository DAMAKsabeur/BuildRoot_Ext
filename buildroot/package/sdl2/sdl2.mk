################################################################################
#
# sdl2
#
################################################################################

SDL2_VERSION = 2.28.5
SDL2_SOURCE = SDL2-$(SDL2_VERSION).tar.gz
SDL2_SITE = http://www.libsdl.org/release
SDL2_LICENSE = Zlib
SDL2_LICENSE_FILES = LICENSE.txt
SDL2_CPE_ID_VENDOR = libsdl
SDL2_CPE_ID_PRODUCT = simple_directmedia_layer
SDL2_INSTALL_STAGING = YES
SDL2_CONFIG_SCRIPTS = sdl2-config

SDL2_CONF_OPTS += \
	--disable-rpath \
	--disable-arts \
	--disable-esd \
	--disable-dbus \
	--disable-pulseaudio \
	--disable-video-vivante \
	--disable-video-cocoa \
	--disable-video-metal \
	--disable-video-wayland \
	--disable-video-dummy \
	--disable-video-offscreen \
	--disable-video-vulkan \
	--disable-ime \
	--disable-ibus \
	--disable-fcitx \
	--disable-joystick-mfi \
	--disable-directx \
	--disable-xinput \
	--disable-wasapi \
	--disable-hidapi-joystick \
	--disable-hidapi-libusb \
	--disable-joystick-virtual \
	--disable-render-d3d

# We are using autotools build system for sdl2, so the sdl2-config.cmake
# include path are not resolved like for sdl2-config script.
# Change the absolute /usr path to resolve relatively to the sdl2-config.cmake location.
# https://bugzilla.libsdl.org/show_bug.cgi?id=4597
define SDL2_FIX_SDL2_CONFIG_CMAKE
	$(SED) '2iget_filename_component(PACKAGE_PREFIX_DIR "$${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)\n' \
		$(STAGING_DIR)/usr/lib/cmake/SDL2/sdl2-config.cmake
	$(SED) 's%"/usr"%$${PACKAGE_PREFIX_DIR}%' \
		$(STAGING_DIR)/usr/lib/cmake/SDL2/sdl2-config.cmake
endef
SDL2_POST_INSTALL_STAGING_HOOKS += SDL2_FIX_SDL2_CONFIG_CMAKE

# We must enable static build to get compilation successful.
SDL2_CONF_OPTS += --enable-static

ifeq ($(BR2_ARM_INSTRUCTIONS_THUMB),y)
SDL2_CONF_ENV += CFLAGS="$(TARGET_CFLAGS) -marm"
endif

ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
SDL2_DEPENDENCIES += udev
SDL2_CONF_OPTS += --enable-libudev
else
SDL2_CONF_OPTS += --disable-libudev
endif

ifeq ($(BR2_X86_CPU_HAS_SSE),y)
SDL2_CONF_OPTS += --enable-sse
else
SDL2_CONF_OPTS += --disable-sse
endif

ifeq ($(BR2_X86_CPU_HAS_3DNOW),y)
SDL2_CONF_OPTS += --enable-3dnow
else
SDL2_CONF_OPTS += --disable-3dnow
endif

SDL2_CONF_OPTS += --disable-video-directfb

#~ ifeq ($(BR2_PACKAGE_SDL2_OPENGLES)$(BR2_PACKAGE_RPI_USERLAND),yy)
#~ SDL2_DEPENDENCIES += rpi-userland
#~ SDL2_CONF_OPTS += --enable-video-rpi
#~ else
#~ SDL2_CONF_OPTS += --disable-video-rpi
#~ endif
SDL2_CONF_OPTS += --disable-video-rpi
# x-includes and x-libraries must be set for cross-compiling
# By default x_includes and x_libraries contains unsafe paths.
# (/usr/X11R6/include and /usr/X11R6/lib)

SDL2_CONF_OPTS += --disable-video-x11-xcursor
SDL2_CONF_OPTS += --disable-video-x11-xinput
SDL2_CONF_OPTS += --disable-video-x11-xrandr
SDL2_CONF_OPTS += --enable-video-opengl 
SDL2_CONF_OPTS += \
	--enable-video-opengles \
	--enable-video-opengles1 \
	--enable-video-opengles2

SDL2_DEPENDENCIES += libgles
ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
SDL2_DEPENDENCIES += alsa-lib
SDL2_CONF_OPTS += --enable-alsa
else
SDL2_CONF_OPTS += --disable-alsa
endif

#~ ifeq ($(BR2_PACKAGE_SDL2_KMSDRM),y)
#~ SDL2_DEPENDENCIES += libdrm libgbm libegl
#~ SDL2_CONF_OPTS += --enable-video-kmsdrm
#~ else
#~ SDL2_CONF_OPTS += --disable-video-kmsdrm
#~ endif
SDL2_DEPENDENCIES += libdrm libgbm libegl
SDL2_CONF_OPTS += --enable-video-kmsdrm
$(eval $(autotools-package))
