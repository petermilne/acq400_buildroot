################################################################################
#
# python-pyepics
#
################################################################################

PYTHON_PYEPICS_VERSION = 3.5.0
PYTHON_PYEPICS_SOURCE = pyepics-$(PYTHON_PYEPICS_VERSION).tar.gz
PYTHON_PYEPICS_SITE = https://files.pythonhosted.org/packages/22/f2/3b15bc9b2d148a19686d5de8901a55f2bbd0a67a63681a0c1ef12c998fa2
PYTHON_PYEPICS_SETUP_TYPE = setuptools
PYTHON_PYEPICS_LICENSE = Epics Open License
PYTHON_PYEPICS_LICENSE_FILES = LICENSE

$(eval $(python-package))
