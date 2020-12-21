# Generated by Django 3.1.4 on 2020-12-16 15:00

import django.db.models.deletion
import trading.models
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name="Currency",
            fields=[
                (
                    "id",
                    models.AutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("name", models.CharField(max_length=200, unique=True)),
                ("code", models.CharField(max_length=10, unique=True)),
            ],
            options={
                "verbose_name": "Currency",
                "verbose_name_plural": "Currencies",
            },
        ),
        migrations.CreateModel(
            name="Item",
            fields=[
                (
                    "id",
                    models.AutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("name", models.CharField(max_length=200, unique=True)),
                ("code", models.CharField(max_length=10, unique=True)),
                ("price", models.DecimalField(decimal_places=2, max_digits=7)),
                (
                    "details",
                    models.TextField(
                        blank=True, max_length=512, null=True, verbose_name="Details"
                    ),
                ),
                (
                    "currency",
                    models.ForeignKey(
                        blank=True,
                        default=1,
                        on_delete=django.db.models.deletion.SET_DEFAULT,
                        to="trading.currency",
                    ),
                ),
            ],
            options={
                "abstract": False,
            },
        ),
        migrations.CreateModel(
            name="Offer",
            fields=[
                (
                    "id",
                    models.AutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                (
                    "entry_quantity",
                    models.PositiveIntegerField(verbose_name="Requested quantity"),
                ),
                (
                    "quantity",
                    models.PositiveIntegerField(verbose_name="Actual quantity"),
                ),
                (
                    "order_type",
                    models.CharField(
                        choices=[("SELL", "Sell"), ("BUY", "Buy")],
                        default=trading.models.OrderType["SELL"],
                        max_length=2,
                    ),
                ),
                ("price", models.DecimalField(decimal_places=2, max_digits=7)),
                ("is_active", models.BooleanField(default=True)),
                (
                    "item",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE, to="trading.item"
                    ),
                ),
            ],
        ),
        migrations.CreateModel(
            name="WatchList",
            fields=[
                (
                    "id",
                    models.AutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                (
                    "item",
                    models.ManyToManyField(
                        blank=True, related_name="watchlist", to="trading.Item"
                    ),
                ),
                (
                    "user",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        to=settings.AUTH_USER_MODEL,
                    ),
                ),
            ],
        ),
        migrations.CreateModel(
            name="Trade",
            fields=[
                (
                    "id",
                    models.AutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("quantity", models.PositiveIntegerField()),
                ("unit_price", models.DecimalField(decimal_places=2, max_digits=7)),
                ("description", models.TextField(blank=True, null=True)),
                (
                    "buyer",
                    models.ForeignKey(
                        blank=True,
                        null=True,
                        on_delete=django.db.models.deletion.SET_NULL,
                        related_name="buyer_trade",
                        related_query_name="buyer_trade",
                        to=settings.AUTH_USER_MODEL,
                    ),
                ),
                (
                    "buyer_offer",
                    models.ForeignKey(
                        blank=True,
                        null=True,
                        on_delete=django.db.models.deletion.SET_NULL,
                        related_name="buyer_trade",
                        related_query_name="buyer_trade",
                        to="trading.offer",
                    ),
                ),
                (
                    "item",
                    models.ForeignKey(
                        blank=True,
                        null=True,
                        on_delete=django.db.models.deletion.SET_NULL,
                        to="trading.item",
                    ),
                ),
                (
                    "seller",
                    models.ForeignKey(
                        blank=True,
                        null=True,
                        on_delete=django.db.models.deletion.SET_NULL,
                        related_name="seller_trade",
                        related_query_name="seller_trade",
                        to=settings.AUTH_USER_MODEL,
                    ),
                ),
                (
                    "seller_offer",
                    models.ForeignKey(
                        blank=True,
                        null=True,
                        on_delete=django.db.models.deletion.SET_NULL,
                        related_name="seller_trade",
                        related_query_name="seller_trade",
                        to="trading.offer",
                    ),
                ),
            ],
        ),
        migrations.CreateModel(
            name="Price",
            fields=[
                (
                    "id",
                    models.AutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("price", models.DecimalField(decimal_places=2, max_digits=7)),
                ("date", models.DateTimeField(blank=True, unique=True)),
                (
                    "currency",
                    models.ForeignKey(
                        blank=True,
                        default=1,
                        on_delete=django.db.models.deletion.SET_DEFAULT,
                        to="trading.currency",
                    ),
                ),
                (
                    "item",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        related_name="prices",
                        related_query_name="prices",
                        to="trading.item",
                    ),
                ),
            ],
        ),
        migrations.CreateModel(
            name="Inventory",
            fields=[
                (
                    "id",
                    models.AutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                (
                    "quantity",
                    models.PositiveIntegerField(
                        default=0, verbose_name="Stocks quantity"
                    ),
                ),
                (
                    "item",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE, to="trading.item"
                    ),
                ),
                (
                    "user",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        to=settings.AUTH_USER_MODEL,
                    ),
                ),
            ],
        ),
        migrations.CreateModel(
            name="Balance",
            fields=[
                (
                    "id",
                    models.AutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                (
                    "amount",
                    models.DecimalField(decimal_places=3, default=0, max_digits=30),
                ),
                (
                    "currency",
                    models.ForeignKey(
                        null=True,
                        on_delete=django.db.models.deletion.SET_NULL,
                        to="trading.currency",
                    ),
                ),
                (
                    "user",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        to=settings.AUTH_USER_MODEL,
                    ),
                ),
            ],
        ),
    ]
