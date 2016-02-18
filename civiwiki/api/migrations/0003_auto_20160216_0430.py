# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import datetime


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0002_auto_20160216_0356'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='page',
            name='contributors',
        ),
        migrations.RemoveField(
            model_name='page',
            name='owner',
        ),
        migrations.AlterField(
            model_name='account',
            name='last_login',
            field=models.CharField(default=datetime.datetime(2016, 2, 16, 4, 30, 23, 822623), max_length=63),
        ),
        migrations.AlterField(
            model_name='civi',
            name='author',
            field=models.ForeignKey(default=None, to='api.Account', null=True),
        ),
        migrations.DeleteModel(
            name='Page',
        ),
    ]
