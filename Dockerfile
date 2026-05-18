FROM python:3.9
RUN useradd flask
WORKDIR /home/flask
COPY requirements.txt .
RUN pip install -r requirements.txt
ADD . .
RUN chmod a+x app.py test.py && chown -R flask:flask ./
ENV FLASK_APP=app.py
EXPOSE 5000
USER flask
CMD ["python", "app.py"]