# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0003_auto_20160221_2104'),
    ]

    operations = [
        migrations.RenameField(
            model_name='civi',
            old_name='refernce',
            new_name='reference',
        ),
    ]
