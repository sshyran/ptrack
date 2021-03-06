# contrib/ptrack/Makefile

MODULE_big = ptrack
OBJS = ptrack.o datapagemap.o engine.o $(WIN32RES)
EXTENSION = ptrack
EXTVERSION = 2.1
DATA = ptrack.sql ptrack--2.0--2.1.sql
DATA_built = $(EXTENSION)--$(EXTVERSION).sql
PGFILEDESC = "ptrack - block-level incremental backup engine"

EXTRA_CLEAN = $(EXTENSION)--$(EXTVERSION).sql

TAP_TESTS = 1

ifdef USE_PGXS
PG_CONFIG ?= pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
else
subdir = contrib/ptrack
top_builddir = ../..
include $(top_builddir)/src/Makefile.global
include $(top_srcdir)/contrib/contrib-global.mk
endif

$(EXTENSION)--$(EXTVERSION).sql: ptrack.sql
	cat $^ > $@

# temp-install: EXTRA_INSTALL=contrib/ptrack

# check-tap: temp-install
# 	$(prove_check)

# check: check-tap
