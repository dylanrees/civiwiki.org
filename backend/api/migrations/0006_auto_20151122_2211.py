# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0005_auto_20151118_2340'),
    ]

    operations = [
        migrations.DeleteModel(
            name='Rating',
        ),
        migrations.RemoveField(
            model_name='account',
            name='name',
        ),
        migrations.AddField(
            model_name='account',
            name='email',
            field=models.CharField(default='', max_length=63),
        ),
        migrations.AddField(
            model_name='account',
            name='first_name',
            field=models.CharField(default='', max_length=63),
        ),
        migrations.AddField(
            model_name='account',
            name='last_login',
            field=models.CharField(default='', max_length=63),
        ),
        migrations.AddField(
            model_name='account',
            name='last_name',
            field=models.CharField(default='', max_length=63),
        ),
        migrations.AddField(
            model_name='account',
            name='password',
            field=models.CharField(default='', max_length=63),
        ),
        migrations.AddField(
            model_name='account',
            name='username',
            field=models.CharField(default='', max_length=63),
        ),
        migrations.AddField(
            model_name='civi',
            name='type',
            field=models.CharField(default='I', max_length=2),
        ),
    ]
