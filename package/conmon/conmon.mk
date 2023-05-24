CONMON_VERSION = v2.1.5
CONMON_SITE = $(call github,containers,conmon,$(CONMON_VERSION))
CONMON_LICENSE = Apache Licene 2.0
CONMON_LICENSE_FILES = LICENSE
CONMON_DEPENDENCIES = host-pkgconf libglib2 libseccomp

ifeq ($(BR2_PACKAGE_LIBSECCOMP),y)
	CONMON_DEPENDENCIES += libseccomp
endif

# See if we install into the podman directory or not
ifeq ($(BR2_PACKAGE_PODMAN),y)
	INSTALL_FLAG=podman
endif

define CONMON_BUILD_CMDS
	PKG_CONFIG="$(PKG_CONFIG_HOST_BINARY)" \
	PREFIX=$(TARGET_DIR) CC=$(TARGET_CC) $(MAKE) -C  $(@D) $(CONMON_MAKE_ENV)
endef

define CONMON_INSTALL_TARGET_CMDS
	PREFIX=$(TARGET_DIR) $(MAKE) -C $(@D) $(CONMON_MAKE_OPTS) install $(INSTALL_FLAG)
endef

$(eval $(generic-package))
