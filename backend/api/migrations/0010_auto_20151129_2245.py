# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import datetime


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0009_auto_20151129_2135'),
    ]

    operations = [
        migrations.AlterField(
            model_name='account',
            name='cover_image',
            field=models.ImageField(default='', upload_to='cover_image'),
        ),
        migrations.AlterField(
            model_name='account',
            name='last_login',
            field=models.CharField(default=datetime.datetime(2015, 11, 29, 22, 45, 36, 356286), max_length=63),
        ),
        migrations.AlterField(
            model_name='account',
            name='profile_image',
            field=models.ImageField(default='', upload_to='profile_image'),
        ),
    ]
