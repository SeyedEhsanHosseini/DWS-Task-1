FROM python:3.9.2-slim-buster

WORKDIR /src

RUN pip install -U pip

COPY ./requirements.txt .

RUN pip install -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["./startup.sh"]
