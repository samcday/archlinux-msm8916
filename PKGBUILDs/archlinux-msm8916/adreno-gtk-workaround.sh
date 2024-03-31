#!/bin/sh
# GTK4 shipped the new ngl renderer which crashes hard on Adreno 306.
# https://gitlab.com/postmarketOS/pmaports/-/issues/2681
# https://gitlab.gnome.org/GNOME/gtk/-/issues/6594
export GSK_RENDERER=gl
