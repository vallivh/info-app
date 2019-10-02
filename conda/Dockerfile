FROM continuumio/miniconda3

RUN conda update -y -n base -c defaults conda \
    && conda install -y -c conda-forge spacy

RUN conda create -y -n spacy_condaenv spacy
# RUN conda init bash \
#     && conda activate spacy_condaenv

RUN python -m spacy download en_core_web_sm && \
    python -m spacy download de_core_news_sm

CMD ["/bin/bash", "-c", "conda activate spacy_condaenv"]
