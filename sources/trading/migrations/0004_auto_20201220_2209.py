# Generated by Django 3.1.4 on 2020-12-20 22:09

import trading.models
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('trading', '0003_auto_20201217_1029'),
    ]

    operations = [
        migrations.AlterField(
            model_name='offer',
            name='order_type',
            field=models.CharField(choices=[('SELL', 'Sell'), ('BUY', 'Buy')], default=trading.models.OrderType['SELL'], max_length=4),
        ),
        migrations.AlterField(
            model_name='price',
            name='date',
            field=models.DateTimeField(auto_now_add=True, unique=True),
        ),
    ]
