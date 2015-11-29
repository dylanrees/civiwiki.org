# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import datetime


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0011_auto_20151129_2301'),
    ]

    operations = [
        migrations.AddField(
            model_name='account',
            name='statistics',
            field=models.TextField(default='No statistics at this time.'),
        ),
        migrations.AlterField(
            model_name='account',
            name='last_login',
            field=models.CharField(default=datetime.datetime(2015, 11, 29, 23, 3, 52, 888710), max_length=63),
        ),
    ]
