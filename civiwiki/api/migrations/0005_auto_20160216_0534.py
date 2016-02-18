# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import datetime


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0004_auto_20160216_0532'),
    ]

    operations = [
        migrations.AlterField(
            model_name='account',
            name='last_login',
            field=models.CharField(default=datetime.datetime(2016, 2, 16, 5, 34, 8, 350518), max_length=63),
        ),
    ]
