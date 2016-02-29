# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0003_auto_20160221_2104'),
    ]

    operations = [
        migrations.AddField(
            model_name='account',
            name='address1',
            field=models.CharField(max_length=255, null=True),
        ),
        migrations.AddField(
            model_name='account',
            name='address2',
            field=models.CharField(max_length=255, null=True),
        ),
        migrations.AddField(
            model_name='account',
            name='city',
            field=models.CharField(max_length=63, null=True),
        ),
        migrations.AddField(
            model_name='account',
            name='country',
            field=models.CharField(max_length=46, null=True),
        ),
        migrations.AddField(
            model_name='account',
            name='state',
            field=models.CharField(max_length=63, null=True),
        ),
        migrations.AddField(
            model_name='account',
            name='zip_code',
            field=models.CharField(max_length=6, null=True),
        ),
    ]
