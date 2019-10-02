FROM rocker/shiny

RUN apt-get update && apt-get install -y gnupg2 \
     libssl-dev \
     libsasl2-dev \
     && apt-get clean \
     && rm -rf /var/lib/apt/lists/ \
     && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

RUN R -e "install.packages(c('shiny', \
                              'shinydashboard', \
                              'mongolite', \
                              'nycflights13', \
                              'spacyr'), \
          repos='https://cran.r-project.org')"

COPY ./shinyserver/shiny-server.conf /srv/shiny-server/shiny-server.conf
COPY ./shinyserver/shiny-server.sh /usr/bin/shiny-server.sh
COPY ./app.R /srv/shiny-server/
COPY ./mongo/data /data/db

EXPOSE 3838

RUN ["chmod", "+x", "/usr/bin/shiny-server.sh"]
