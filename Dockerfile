FROM python:3.9.0

WORKDIR /home/

RUN git clone https://github.com/HwangSoonHyun/FirstClass.git

WORKDIR /home/FirstClass/

RUN echo "SECRET_KEY=django-insecure-1@5yii300p*f_hla*l7i&+axnzcaplid8x&+7_x%f!&2^3qy1v" > .env

RUN pip install -r requirements.txt

RUN python manage.py migrate

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]