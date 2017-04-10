# our base image
FROM alpine:3.5

# Install python and pip
RUN apk add --update py2-pip git gcc make  build-base python-dev jpeg-dev zlib-dev
ENV LIBRARY_PATH=/lib:/usr/lib

RUN git clone https://github.com/labhackercd/wikilegis.git /usr/local/wikilegis

# install Python modules needed by the Python app
RUN pip install --no-cache-dir -r /usr/local/wikilegis/requirements.txt

RUN /usr/local/wikilegis/manage.py migrate
RUN /usr/local/wikilegis/manage.py createsuperuser

# tell the port number the container should expose
EXPOSE 8080

# run the application
CMD ["python", "/usr/local/wikilegis/manage.py", "runserver", "0.0.0.0:8080"]

