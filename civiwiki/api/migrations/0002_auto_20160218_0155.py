# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Topic',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('topic', models.CharField(default='', max_length=63)),
                ('bill', models.URLField(default='', null=True)),
                ('category', models.ForeignKey(default=None, to='api.Category', null=True)),
            ],
        ),
        migrations.RemoveField(
            model_name='article',
            name='category',
        ),
        migrations.RemoveField(
            model_name='civi',
            name='article',
        ),
        migrations.DeleteModel(
            name='Article',
        ),
        migrations.AddField(
            model_name='civi',
            name='topic',
            field=models.ForeignKey(default=None, to='api.Topic', null=True),
        ),
    ]
