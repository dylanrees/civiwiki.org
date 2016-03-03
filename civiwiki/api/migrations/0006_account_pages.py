# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import django.contrib.postgres.fields


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0005_account_interests'),
    ]

    operations = [
        migrations.AddField(
            model_name='account',
            name='pages',
            field=django.contrib.postgres.fields.ArrayField(default=[], size=None, base_field=models.CharField(max_length=127, null=True), blank=True),
        ),
    ]
