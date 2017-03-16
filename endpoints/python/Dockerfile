FROM python:3.3
COPY requirements.txt /srv/
COPY main.py /srv/server.py
EXPOSE 11000
WORKDIR /srv
RUN pip install -r requirements.txt
CMD ["python", "/srv/server.py"]
