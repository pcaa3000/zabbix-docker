
ARG ZABBIX_AGENT_IMAGE=zabbix/zabbix-agent:alpine-7.4-latest
FROM $ZABBIX_AGENT_IMAGE
# Set environment variable to accept EULA for Microsoft ODBC Driver
ENV ACCEPT_EULA=Y
ENV ARCH_OS amd64

USER root
# Install necessary dependencies, unixodbc-dev is required for building the ODBC driver, curl is required for downloading the ODBC driver and the Microsoft ODBC Driver for SQL Server
RUN apk update && apk add --no-cache curl \
    unixodbc-dev unixodbc libssl3 libstdc++

# Verify the arhitecture of the system
RUN case $(uname -m) in \
    arm64) ARCH_OS="arm64" ;; \
    x86_64) ARCH_OS="amd64" ;; \
    *) exit 1 ;; \
esac

# download the Microsoft ODBC Driver for SQL Server and SQL tools
RUN curl -O https://download.microsoft.com/download/9dcab408-e0d4-4571-a81a-5a0951e3445f/msodbcsql18_18.6.1.1-1_${ARCH_OS}.apk
RUN curl -O https://download.microsoft.com/download/b60bb8b6-d398-4819-9950-2e30cf725fb0/mssql-tools18_18.6.1.1-1_${ARCH_OS}.apk

# Add Microsoft alpine repository
# RUN curl -O https://packages.microsoft.com/keys/microsoft.asc && \
#     apk add --no-cache gnupg && \
#     gpg --dearmor microsoft.asc > /usr/share/keyrings/microsoft.asc.gpg && \
#     echo "https://packages.microsoft.com/" >> /etc/apk/repositories

# Install the Microsoft ODBC Driver for SQL Server and SQL tools
RUN apk add --allow-untrusted msodbcsql18_18.6.1.1-1_${ARCH_OS}.apk 
RUN apk add --allow-untrusted mssql-tools18_18.6.1.1-1_${ARCH_OS}.apk

# Clean up
RUN rm -f msodbcsql18_18.6.1.1-1_${ARCH_OS}.apk \
    mssql-tools18_18.6.1.1-1_${ARCH_OS}.apk

# Install the driver
# RUN apk add --no-cache msodbcsql18 mssql-tools

# Clean up
# RUN rm -rf /var/cache/apk/*
