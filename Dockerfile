FROM continuumio/miniconda3
RUN conda create -n env python=3.7
RUN echo "source activate env" > ~/.bashrc
ENV PATH /opt/conda/envs/env/bin:$PATH

RUN pip install --upgrade pip
RUN pip install connexion[swagger-ui]

COPY . /app
WORKDIR /app

RUN python -m pip install -e .

RUN echo $PORT

# EXPOSE $PORT
EXPOSE 5000

# ENTRYPOINT ["python3"]


RUN useradd -m myuser
USER myuser

# CMD ["-m", "swagger_server", "--port", $PORT]
# CMD ["-m", "swagger_server", "--port", "5000"]
# CMD ["swagger_server/__main__.py", "--port", $PORT]

CMD python -m swagger_server --port "$PORT"