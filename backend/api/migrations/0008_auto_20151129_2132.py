# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import datetime


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0007_auto_20151129_2100'),
    ]

    operations = [
        migrations.AddField(
            model_name='account',
            name='secret_key',
            field=models.CharField(default='', max_length=255),
        ),
        migrations.AlterField(
            model_name='account',
            name='email',
            field=models.CharField(default='', unique=True, max_length=63),
        ),
        migrations.AlterField(
            model_name='account',
            name='last_login',
            field=models.CharField(default=datetime.datetime(2015, 11, 29, 21, 32, 51, 699865), max_length=63),
        ),
        migrations.AlterField(
            model_name='account',
            name='username',
            field=models.CharField(default='', unique=True, max_length=63),
        ),
    ]
