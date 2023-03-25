set -o errexit

pip install -r requirements.txt

python3 manage.py collectstatic --no-input
python3 manage.py makemigrations
python3 manage.py migrate

export DJANGO_SUPERUSER_EMAIL=alumnodb@alumnodb.com
export DJANGO_SUPERUSER_USERNAME=alumnodb
export DJANGO_SUPERUSER_PASSWORD=alumnodb

python3 manage.py createsuperuser --noinput
