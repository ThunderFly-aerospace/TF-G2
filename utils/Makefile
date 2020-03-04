VPATH = $(SRC_DIR)

SOURCES=$(wildcard $(SRC_DIR)/*.scad)
AMF_TARGETS=$(patsubst $(SRC_DIR)/%.scad, $(AMF_DIR)/%.amf, $(SOURCES))
GCD_TARGETS=$(patsubst $(SRC_DIR)/%.scad, $(GCD_DIR)/%.gcode, $(SOURCES))

OUTPUT_FOLDER=CAD

RED=" \e[91m "
GRN=" \e[32m "
YEL=" \e[33m "
DEF=" \e[39m "

all: default

default: $(AMF_TARGETS)
$(AMF_DIR)/%.amf: $(SRC_DIR)/%.scad
	@echo ============== $<
	processor3D --output_folder $(GIT_ROOT)/$(OUTPUT_FOLDER) $<


# gdefault: $(TARGETS)
# $(GCD_DIR)/%.gcode: $(SRC_DIR)/%.scad
# #     @echo ============== $<
#       processor3D --output_folder $(GIT_ROOT) $<

model:
	echo $(f)
	processor3D --output_folder $(GIT_ROOT) $(f)


