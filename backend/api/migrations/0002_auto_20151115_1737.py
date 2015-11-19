# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Article',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('topic', models.CharField(default='', max_length=31)),
                ('bill', models.URLField()),
            ],
        ),
        migrations.CreateModel(
            name='Category',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(default='', max_length=31)),
            ],
        ),
        migrations.RemoveField(
            model_name='civi',
            name='category',
        ),
        migrations.RemoveField(
            model_name='civi',
            name='rating',
        ),
        migrations.RemoveField(
            model_name='hashtag',
            name='civi',
        ),
        migrations.AddField(
            model_name='civi',
            name='hashtags',
            field=models.ManyToManyField(to='api.Hashtag'),
        ),
        migrations.AddField(
            model_name='civi',
            name='visits',
            field=models.IntegerField(default=0),
        ),
        migrations.AddField(
            model_name='civi',
            name='votes_negative1',
            field=models.IntegerField(default=0),
        ),
        migrations.AddField(
            model_name='civi',
            name='votes_negative2',
            field=models.IntegerField(default=0),
        ),
        migrations.AddField(
            model_name='civi',
            name='votes_neutral',
            field=models.IntegerField(default=0),
        ),
        migrations.AddField(
            model_name='civi',
            name='votes_positive1',
            field=models.IntegerField(default=0),
        ),
        migrations.AddField(
            model_name='civi',
            name='votes_positive2',
            field=models.IntegerField(default=0),
        ),
        migrations.AddField(
            model_name='hashtag',
            name='votes',
            field=models.IntegerField(default=0),
        ),
        migrations.AlterField(
            model_name='civi',
            name='author',
            field=models.ForeignKey(default=None, to='api.Account'),
        ),
        migrations.AddField(
            model_name='article',
            name='category',
            field=models.ForeignKey(to='api.Category'),
        ),
        migrations.AddField(
            model_name='civi',
            name='article',
            field=models.ForeignKey(default=None, to='api.Article'),
        ),
    ]
