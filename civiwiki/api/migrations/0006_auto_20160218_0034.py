# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import datetime


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0005_auto_20160216_0534'),
    ]

    operations = [
        migrations.AlterField(
            model_name='account',
            name='last_login',
            field=models.CharField(default=datetime.datetime(2016, 2, 18, 0, 34, 14, 691804), max_length=63),
        ),
    ]
