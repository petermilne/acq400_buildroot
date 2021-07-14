################################################################################
#
# cegui
#
################################################################################

CEGUI_VERSION = 00b4e1fe174da53b7ed726ab5970ba51bd5b5ee0
CEGUI_SITE = $(call github,cegui,cegui,$(CEGUI_VERSION))
CEGUI_LICENSE = MIT
CEGUI_LICENSE_FILES = COPYING
CEGUI_INSTALL_STAGING = YES
CEGUI_CONF_OPTS = \
	-DCEGUI_HAS_MINIZIP_RESOURCE_PROVIDER=OFF \
	-DCEGUI_BUILD_RENDERER_IRRLICHT=OFF \
	-DCEGUI_BUILD_RENDERER_OGRE=OFF \
	-DCEGUI_BUILD_XMLPARSER_XERCES=OFF \
	-DCEGUI_USE_FRIBIDI=OFF \
	-DCEGUI_SAMPLES_ENABLED=OFF \
	-DCEGUI_BUILD_APPLICATION_TEMPLATES=OFF
CEGUI_DEPENDENCIES = glm \
	$(if $(BR2_PACKAGE_LIBGLFW),libglfw) \
	$(if $(BR2_PACKAGE_HAS_LIBGL),libgl) \
	$(if $(BR2_PACKAGE_HAS_LIBGLES),libgles) \
	$(if $(BR2_PACKAGE_LIBICONV),libiconv)

# libepoxy support cannot be enabled together with libglew
ifeq ($(BR2_PACKAGE_LIBGLEW)$(BR2_PACKAGE_LIBGLU),yy)
CEGUI_DEPENDENCIES += libglew libglu
CEGUI_CONF_OPTS += -DCEGUI_USE_GLEW=ON -DCEGUI_USE_EPOXY=OFF \
	-DCEGUI_BUILD_RENDERER_OPENGL=ON \
	-DCEGUI_BUILD_RENDERER_OPENGL3=ON
else ifeq ($(BR2_PACKAGE_LIBEPOXY),y)
CEGUI_DEPENDENCIES += libepoxy
# old OpenGL renderer module is only supported using GLEW
CEGUI_CONF_OPTS += -DCEGUI_USE_EPOXY=ON -DCEGUI_USE_GLEW=OFF \
	-DCEGUI_BUILD_RENDERER_OPENGL=OFF \
	-DCEGUI_BUILD_RENDERER_OPENGL3=ON
else
CEGUI_CONF_OPTS += -DCEGUI_USE_EPOXY=OFF -DCEGUI_USE_GLEW=OFF \
	-DCEGUI_BUILD_RENDERER_OPENGL=OFF \
	-DCEGUI_BUILD_RENDERER_OPENGL3=OFF
endif

ifeq ($(BR2_PACKAGE_EXPAT),y)
CEGUI_DEPENDENCIES += expat
CEGUI_CONF_OPTS += -DCEGUI_BUILD_XMLPARSER_EXPAT=ON
else
CEGUI_CONF_OPTS += -DCEGUI_BUILD_XMLPARSER_EXPAT=OFF
endif

ifeq ($(BR2_PACKAGE_SDL2)$(BR2_PACKAGE_SDL2_IMAGE),yy)
CEGUI_DEPENDENCIES += sdl2 sdl2_image
CEGUI_CONF_OPTS += -DCEGUI_BUILD_IMAGECODEC_SDL2=ON
else
CEGUI_CONF_OPTS += -DCEGUI_BUILD_IMAGECODEC_SDL2=OFF
endif

ifeq ($(BR2_PACKAGE_PCRE),y)
CEGUI_DEPENDENCIES += pcre
CEGUI_CONF_OPTS += -DCEGUI_HAS_PCRE_REGEX=ON
else
CEGUI_CONF_OPTS += -DCEGUI_HAS_PCRE_REGEX=OFF
endif

ifeq ($(BR2_PACKAGE_FREETYPE),y)
CEGUI_DEPENDENCIES += freetype
CEGUI_CONF_OPTS += -DCEGUI_HAS_FREETYPE=ON
else
CEGUI_CONF_OPTS += -DCEGUI_HAS_FREETYPE=OFF
endif

ifeq ($(BR2_PACKAGE_LIBXML2),y)
CEGUI_DEPENDENCIES += libxml2
CEGUI_CONF_OPTS += -DCEGUI_BUILD_XMLPARSER_LIBXML2=ON
else
CEGUI_CONF_OPTS += -DCEGUI_BUILD_XMLPARSER_LIBXML2=OFF
endif

ifeq ($(BR2_PACKAGE_RAPIDXML),y)
CEGUI_DEPENDENCIES += rapidxml
CEGUI_CONF_OPTS += -DCEGUI_BUILD_XMLPARSER_RAPIDXML=ON
else
CEGUI_CONF_OPTS += -DCEGUI_BUILD_XMLPARSER_RAPIDXML=OFF
endif

ifeq ($(BR2_PACKAGE_TINYXML),y)
CEGUI_DEPENDENCIES += tinyxml
CEGUI_CONF_OPTS += -DCEGUI_BUILD_XMLPARSER_TINYXML=ON
else
CEGUI_CONF_OPTS += -DCEGUI_BUILD_XMLPARSER_TINYXML=OFF
endif

ifeq ($(BR2_PACKAGE_LIBFREEIMAGE),y)
CEGUI_DEPENDENCIES += libfreeimage
CEGUI_CONF_OPTS += -DCEGUI_BUILD_IMAGECODEC_FREEIMAGE=ON
else
CEGUI_CONF_OPTS += -DCEGUI_BUILD_IMAGECODEC_FREEIMAGE=OFF
endif

$(eval $(cmake-package))
