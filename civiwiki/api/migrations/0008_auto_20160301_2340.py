# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0007_auto_20160301_1647'),
    ]

    operations = [
        migrations.AlterField(
            model_name='account',
            name='about_me',
            field=models.CharField(default='', max_length=511, null=True),
        ),
        migrations.AlterField(
            model_name='account',
            name='cover_image',
            field=models.CharField(max_length=255, null=True),
        ),
        migrations.AlterField(
            model_name='account',
            name='profile_image',
            field=models.CharField(max_length=255, null=True),
        ),
    ]
