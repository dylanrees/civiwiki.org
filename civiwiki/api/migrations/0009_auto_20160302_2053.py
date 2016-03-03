# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0008_auto_20160301_2340'),
    ]

    operations = [
        migrations.RenameField(
            model_name='page',
            old_name='body',
            new_name='description',
        ),
        migrations.RemoveField(
            model_name='civi',
            name='author',
        ),
        migrations.AddField(
            model_name='civi',
            name='category',
            field=models.ForeignKey(default=None, to='api.Category', null=True),
        ),
        migrations.AddField(
            model_name='civi',
            name='creator',
            field=models.ForeignKey(default=None, to='api.Account', null=True),
        ),
        migrations.AddField(
            model_name='civi',
            name='page',
            field=models.ForeignKey(default=None, to='api.Page', null=True),
        ),
    ]
