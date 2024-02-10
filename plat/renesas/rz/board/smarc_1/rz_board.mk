#
# Copyright (c) 2021, Renesas Electronics Corporation. All rights reserved.
#
# SPDX-License-Identifier: BSD-3-Clause
#

DDR_SOURCES +=  plat/renesas/rz/soc/${PLAT}/drivers/ddr/param_mc_C-011_D4-01-2.c \
				plat/renesas/rz/common/drivers/ddr/param_swizzle_T3bc.c

DDR_PLL4    := 1600
$(eval $(call add_define,DDR_PLL4))

