FROM continuumio/miniconda3
RUN conda create -n env python=3.7
RUN echo "source activate env" > ~/.bashrc
ENV PATH /opt/conda/envs/env/bin:$PATH

RUN pip install --upgrade pip
RUN pip install connexion[swagger-ui]

COPY . /app
WORKDIR /app

RUN python -m pip install -e .

EXPOSE 5000

RUN useradd -m myuser
USER myuser

CMD python -m swagger_server --port "$PORT"