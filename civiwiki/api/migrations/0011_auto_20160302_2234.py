# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0010_account_friends'),
    ]

    operations = [
        migrations.RenameField(
            model_name='account',
            old_name='friend_list',
            new_name='friend_requests',
        ),
    ]
