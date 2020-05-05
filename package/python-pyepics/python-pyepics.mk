################################################################################
#
# python-pyepics
#
################################################################################

PYTHON_PYEPICS_VERSION = 3.4.1
PYTHON_PYEPICS_SOURCE = pyepics-$(PYTHON_PYEPICS_VERSION).tar.gz
PYTHON_PYEPICS_SITE = https://files.pythonhosted.org/packages/cb/64/f849f7aef93b7d3d713aa1d5e79ee4b67c84fa3fa1db3e2882e91c000ff6
PYTHON_PYEPICS_SETUP_TYPE = setuptools
PYTHON_PYEPICS_LICENSE = Epics Open License
PYTHON_PYEPICS_LICENSE_FILES = LICENSE

$(eval $(python-package))
