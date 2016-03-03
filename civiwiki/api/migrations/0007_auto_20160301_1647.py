# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0006_account_pages'),
    ]

    operations = [
        migrations.AddField(
            model_name='page',
            name='admins',
            field=models.ManyToManyField(related_name='page_admin', to='api.Account'),
        ),
        migrations.RemoveField(
            model_name='account',
            name='pages',
        ),
        migrations.AddField(
            model_name='account',
            name='pages',
            field=models.ManyToManyField(related_name='user_pages', to='api.Page'),
        ),
        migrations.AlterField(
            model_name='page',
            name='contributors',
            field=models.ManyToManyField(related_name='page_member', to='api.Account'),
        ),
    ]
