# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0004_auto_20151115_1942'),
    ]

    operations = [
        migrations.AlterField(
            model_name='account',
            name='name',
            field=models.CharField(max_length=63),
        ),
        migrations.AlterField(
            model_name='article',
            name='topic',
            field=models.CharField(default='', max_length=63),
        ),
        migrations.AlterField(
            model_name='category',
            name='name',
            field=models.CharField(default='', max_length=63),
        ),
        migrations.AlterField(
            model_name='hashtag',
            name='title',
            field=models.CharField(default='', max_length=63),
        ),
    ]
