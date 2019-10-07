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

# RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-4.7.10-Linux-x86_64.sh -O ~/miniconda.sh && \
#     /bin/bash ~/miniconda.sh -b -p /opt/conda && \
#     rm ~/miniconda.sh && \
#     /opt/conda/bin/conda clean -tipsy && \
#     ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
#     echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
#     echo "conda active base" >> ~/.bashrc
#
# RUN echo "conda update -y conda" >> ~/.bashrc && \
#     echo "conda install -y -c conda-forge spacy" >> ~/.bashrc && \
#     echo "conda create -y -n spacy_condaenv python=3.6 spacy" >> ~/.bashrc && \
#     echo "conda activate spacy_condaenv" >> ~/.bashrc && \
#     echo "python -m spacy download en" >> ~/.bashrc && \
#     echo "python -m spacy download de" >> ~/.bashrc


COPY ./shinyserver/shiny-server.conf /srv/shiny-server/shiny-server.conf
COPY ./shinyserver/shiny-server.sh /usr/bin/shiny-server.sh
COPY ./app.R /srv/shiny-server/

EXPOSE 3838

RUN ["chmod", "+x", "/usr/bin/shiny-server.sh"]
