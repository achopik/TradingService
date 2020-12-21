from celery import Celery

app = Celery('server', broker='redis://redis:6379/0')
app.config_from_object('django.conf:settings', namespace='CELERY')
app.autodiscover_tasks()

#
# @app.task()
# def bug(num):
#     print(num ** num)
#     return num
#
#
# bug.apply_async([9], countdown=0.1)
