# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import datetime


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0010_auto_20151129_2245'),
    ]

    operations = [
        migrations.AlterField(
            model_name='account',
            name='cover_image',
            field=models.ImageField(default='cover/generic-cover.jpg', upload_to='cover'),
        ),
        migrations.AlterField(
            model_name='account',
            name='last_login',
            field=models.CharField(default=datetime.datetime(2015, 11, 29, 23, 1, 26, 822341), max_length=63),
        ),
        migrations.AlterField(
            model_name='account',
            name='profile_image',
            field=models.ImageField(default='profile/generic-profile.png', upload_to='profile'),
        ),
    ]
