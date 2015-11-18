# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0002_auto_20151115_1737'),
    ]

    operations = [
        migrations.AlterField(
            model_name='article',
            name='bill',
            field=models.URLField(default='', null=True),
        ),
        migrations.AlterField(
            model_name='civi',
            name='article',
            field=models.ForeignKey(default=None, to='api.Article', null=True),
        ),
        migrations.AlterField(
            model_name='civi',
            name='author',
            field=models.ForeignKey(default=None, to='api.Account', null=True),
        ),
        migrations.AlterField(
            model_name='civi',
            name='visits',
            field=models.IntegerField(default=0, null=True),
        ),
        migrations.AlterField(
            model_name='civi',
            name='votes_negative1',
            field=models.IntegerField(default=0, null=True),
        ),
        migrations.AlterField(
            model_name='civi',
            name='votes_negative2',
            field=models.IntegerField(default=0, null=True),
        ),
        migrations.AlterField(
            model_name='civi',
            name='votes_neutral',
            field=models.IntegerField(default=0, null=True),
        ),
        migrations.AlterField(
            model_name='civi',
            name='votes_positive1',
            field=models.IntegerField(default=0, null=True),
        ),
        migrations.AlterField(
            model_name='civi',
            name='votes_positive2',
            field=models.IntegerField(default=0, null=True),
        ),
    ]
