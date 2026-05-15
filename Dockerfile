FROM python:3.9

# Ne pas lancer en root
RUN useradd flask

WORKDIR /home/flask

# Copier tous les fichiers
ADD . .

# Installer les dépendances
RUN pip install -r requirements.txt

RUN chmod a+x app.py test.py && \
    chown -R flask:flask ./

ENV FLASK_APP=app.py

EXPOSE 5000

USER flask

CMD ["python", "app.py"]