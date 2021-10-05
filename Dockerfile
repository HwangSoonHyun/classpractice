FROM python:3.9.0

WORKDIR /home/

RUN echo 'reset_2'

RUN git clone https://github.com/HwangSoonHyun/FirstClass.git

WORKDIR /home/classpractice/

RUN pip install -r requirements.txt

RUN pip install gunicorn

RUN pip install mysqlclient

EXPOSE 8000

CMD ["bash", "-c", "python manage.py collectstatic --noinput --settings=classpractice.settings.deploy && python manage.py migrate --settings=classpractice.settings.deploy && gunicorn --env DJANGO_SETTINGS_MODULE=classpractice.settings.deploy classpractice.wsgi --bind 0.0.0.0:8000"]