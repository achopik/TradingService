# Generated by Django 3.1.5 on 2021-01-04 21:55

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('trading', '0010_auto_20210101_1115'),
    ]

    operations = [
        migrations.CreateModel(
            name='ItemStats',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('creation_date', models.DateTimeField(auto_now_add=True)),
                ('average_price', models.DecimalField(decimal_places=3, default=0, max_digits=30)),
                ('minimum_price', models.DecimalField(decimal_places=3, default=0, max_digits=30)),
                ('maximum_price', models.DecimalField(decimal_places=3, default=0, max_digits=30)),
                ('item', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to='trading.item')),
            ],
            options={
                'verbose_name': 'ItemStat',
                'verbose_name_plural': 'ItemStats',
            },
        ),
    ]