# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0011_auto_20160302_2234'),
    ]

    operations = [
        migrations.CreateModel(
            name='Group',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('title', models.CharField(default='', max_length=63)),
                ('description', models.TextField(max_length=4095)),
                ('profile_image', models.CharField(max_length=255)),
                ('cover_image', models.CharField(max_length=255)),
            ],
        ),
        migrations.RemoveField(
            model_name='page',
            name='admins',
        ),
        migrations.RemoveField(
            model_name='page',
            name='contributors',
        ),
        migrations.RemoveField(
            model_name='page',
            name='owner',
        ),
        migrations.RemoveField(
            model_name='account',
            name='pages',
        ),
        migrations.RemoveField(
            model_name='civi',
            name='page',
        ),
        migrations.DeleteModel(
            name='Page',
        ),
        migrations.AddField(
            model_name='group',
            name='admins',
            field=models.ManyToManyField(related_name='group_admin', to='api.Account'),
        ),
        migrations.AddField(
            model_name='group',
            name='contributors',
            field=models.ManyToManyField(related_name='group_member', to='api.Account'),
        ),
        migrations.AddField(
            model_name='group',
            name='owner',
            field=models.ForeignKey(related_name='group_owner', to='api.Account'),
        ),
        migrations.AddField(
            model_name='account',
            name='groups',
            field=models.ManyToManyField(related_name='user_groups', to='api.Group'),
        ),
        migrations.AddField(
            model_name='civi',
            name='group',
            field=models.ForeignKey(default=None, to='api.Group', null=True),
        ),
    ]
