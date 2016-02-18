# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import datetime


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0003_auto_20160216_0430'),
    ]

    operations = [
        migrations.CreateModel(
            name='Page',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('title', models.CharField(default='', max_length=63)),
                ('body', models.TextField(max_length=4095)),
                ('profile_image', models.CharField(max_length=255)),
                ('cover_image', models.CharField(max_length=255)),
            ],
        ),
        migrations.AlterField(
            model_name='account',
            name='last_login',
            field=models.CharField(default=datetime.datetime(2016, 2, 16, 5, 32, 59, 852270), max_length=63),
        ),
        migrations.AlterField(
            model_name='civi',
            name='author',
            field=models.ForeignKey(default=None, to='api.Page', null=True),
        ),
        migrations.AddField(
            model_name='page',
            name='contributors',
            field=models.ManyToManyField(to='api.Account'),
        ),
        migrations.AddField(
            model_name='page',
            name='owner',
            field=models.ForeignKey(related_name='page_owner', to='api.Account'),
        ),
    ]
