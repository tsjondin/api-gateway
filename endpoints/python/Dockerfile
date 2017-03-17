FROM python:3.5.3-alpine
COPY requirements.txt /srv/
COPY main.py /srv/server.py
EXPOSE 11000
WORKDIR /srv
RUN pip install -r requirements.txt
CMD ["python", "/srv/server.py"]
