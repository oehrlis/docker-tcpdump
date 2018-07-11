# ----------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ----------------------------------------------------------------------
# Name.......: Dockerfile
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2018.03.19
# Revision...: 1.0
# Purpose....: Dockerfile to build a tcpdump image
# Notes......: --
# Reference..: --
# License....: Licensed under the Universal Permissive License v 1.0 as
#              shown at http://oss.oracle.com/licenses/upl.
# ----------------------------------------------------------------------
# Modified...:
# see git revision history for more information on changes/updates
# ----------------------------------------------------------------------

# Pull base image
# ----------------------------------------------------------------------
FROM alpine

# Maintainer
# ----------------------------------------------------------------------
LABEL maintainer="stefan.oehrli@trivadis.com"

# Environment variables required for this build (do NOT change)
# -------------------------------------------------------------
ENV TCPDUMP="/tcpdump"

# RUN as user root
# ----------------------------------------------------------------------
# - install a package used to run tcpdump
RUN apk add --update --no-cache tcpdump && \
    rm -rf /var/cache/apk/*

# define a volume for the tcpdump files
VOLUME  [ "${TCPDUMP}" ]

# set workding directory
WORKDIR ${TCPDUMP}

# set the ENTRYPOINT
ENTRYPOINT [ "/usr/sbin/tcpdump" ]

# Define default command for tcpdump
CMD [ "-G", "900", "-v", "-i", "any", "-w", "${TCPDUMP}/tcpdump_%Y-%m-%d_%H:%M:%S.pcap", "-W","96"]