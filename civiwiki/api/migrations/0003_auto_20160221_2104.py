# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import django.contrib.postgres.fields


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0002_auto_20160218_0155'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='account',
            name='awards',
        ),
        migrations.RemoveField(
            model_name='account',
            name='friends',
        ),
        migrations.RemoveField(
            model_name='account',
            name='history',
        ),
        migrations.RemoveField(
            model_name='account',
            name='pinned',
        ),
        migrations.RemoveField(
            model_name='civi',
            name='AND_NEGATIVE',
        ),
        migrations.RemoveField(
            model_name='civi',
            name='AND_POSITIVE',
        ),
        migrations.RemoveField(
            model_name='civi',
            name='AT',
        ),
        migrations.RemoveField(
            model_name='civi',
            name='REFERENCE',
        ),
        migrations.AddField(
            model_name='account',
            name='award_list',
            field=django.contrib.postgres.fields.ArrayField(default=[], size=None, base_field=models.CharField(max_length=127, null=True), blank=True),
        ),
        migrations.AddField(
            model_name='account',
            name='civi_history',
            field=django.contrib.postgres.fields.ArrayField(default=[], size=10, base_field=models.CharField(max_length=127, null=True), blank=True),
        ),
        migrations.AddField(
            model_name='account',
            name='civi_pins',
            field=django.contrib.postgres.fields.ArrayField(default=[], size=None, base_field=models.CharField(max_length=127, null=True), blank=True),
        ),
        migrations.AddField(
            model_name='account',
            name='friend_list',
            field=django.contrib.postgres.fields.ArrayField(default=[], size=None, base_field=models.CharField(max_length=127, null=True), blank=True),
        ),
        migrations.AddField(
            model_name='civi',
            name='and_negative',
            field=django.contrib.postgres.fields.ArrayField(default=[], size=None, base_field=models.CharField(max_length=127, null=True), blank=True),
        ),
        migrations.AddField(
            model_name='civi',
            name='and_positive',
            field=django.contrib.postgres.fields.ArrayField(default=[], size=None, base_field=models.CharField(max_length=127, null=True), blank=True),
        ),
        migrations.AddField(
            model_name='civi',
            name='at',
            field=django.contrib.postgres.fields.ArrayField(default=[], size=None, base_field=models.CharField(max_length=127, null=True), blank=True),
        ),
        migrations.AddField(
            model_name='civi',
            name='refernce',
            field=django.contrib.postgres.fields.ArrayField(default=[], size=None, base_field=models.CharField(max_length=127, null=True), blank=True),
        ),
    ]
