# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import datetime


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0006_auto_20151122_2211'),
    ]

    operations = [
        migrations.AddField(
            model_name='account',
            name='cover_image',
            field=models.CharField(default='', max_length=255),
        ),
        migrations.AddField(
            model_name='account',
            name='profile_image',
            field=models.CharField(default='', max_length=255),
        ),
        migrations.AddField(
            model_name='account',
            name='valid',
            field=models.BooleanField(default=False),
        ),
        migrations.AlterField(
            model_name='account',
            name='last_login',
            field=models.CharField(default=datetime.datetime(2015, 11, 29, 21, 0, 21, 339791), max_length=63),
        ),
    ]
