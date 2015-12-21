# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import datetime


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Account',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('username', models.CharField(default='', unique=True, max_length=63)),
                ('first_name', models.CharField(default='', max_length=63)),
                ('last_name', models.CharField(default='', max_length=63)),
                ('email', models.CharField(unique=True, max_length=63)),
                ('last_login', models.CharField(default=datetime.datetime(2015, 12, 21, 5, 24, 15, 156359), max_length=63)),
                ('password', models.CharField(default='', max_length=63)),
                ('about_me', models.CharField(default='', max_length=511)),
                ('valid', models.BooleanField(default=False)),
                ('profile_image', models.ImageField(default='profile/generic-profile.png', upload_to='profile')),
                ('cover_image', models.ImageField(default='cover/generic-cover.jpg', upload_to='cover')),
                ('secret_key', models.CharField(default='', max_length=255)),
                ('statistics', models.TextField(default='No statistics at this time.')),
                ('history', models.TextField(default='[]')),
                ('friends', models.TextField(default='[]')),
                ('awards', models.TextField(default='[]')),
            ],
        ),
        migrations.CreateModel(
            name='Article',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('topic', models.CharField(default='', max_length=63)),
                ('bill', models.URLField(default='', null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Attachment',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('attachment', models.FileField(upload_to=b'')),
            ],
        ),
        migrations.CreateModel(
            name='Category',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(default='', max_length=63)),
            ],
        ),
        migrations.CreateModel(
            name='Civi',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('title', models.CharField(default='', max_length=63)),
                ('body', models.TextField(max_length=4095)),
                ('votes_negative2', models.IntegerField(default=0, null=True)),
                ('votes_negative1', models.IntegerField(default=0, null=True)),
                ('votes_neutral', models.IntegerField(default=0, null=True)),
                ('votes_positive1', models.IntegerField(default=0, null=True)),
                ('votes_positive2', models.IntegerField(default=0, null=True)),
                ('visits', models.IntegerField(default=0, null=True)),
                ('type', models.CharField(default='I', max_length=2)),
                ('AND_NEGATIVE', models.ForeignKey(related_name='AND_NEGATIVE_REL', default='', to='api.Civi', null=True)),
                ('AND_POSITIVE', models.ForeignKey(related_name='AND_POSITIVE_REL', default='', to='api.Civi', null=True)),
                ('AT', models.ForeignKey(related_name='AT_REL', default='', to='api.Civi', null=True)),
                ('REFERENCE', models.ForeignKey(related_name='REFERENCE_REL', default='', to='api.Civi', null=True)),
                ('article', models.ForeignKey(default=None, to='api.Article', null=True)),
                ('author', models.ForeignKey(default=None, to='api.Account', null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Comment',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('comment', models.CharField(default='', max_length=511)),
                ('author', models.ForeignKey(to='api.Account')),
                ('civi', models.ForeignKey(to='api.Civi')),
            ],
        ),
        migrations.CreateModel(
            name='Hashtag',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('title', models.CharField(default='', max_length=63)),
                ('votes_negative2', models.IntegerField(default=0, null=True)),
                ('votes_negative1', models.IntegerField(default=0, null=True)),
                ('votes_neutral', models.IntegerField(default=0, null=True)),
                ('votes_positive1', models.IntegerField(default=0, null=True)),
                ('votes_positive2', models.IntegerField(default=0, null=True)),
            ],
        ),
        migrations.AddField(
            model_name='civi',
            name='hashtags',
            field=models.ManyToManyField(to='api.Hashtag'),
        ),
        migrations.AddField(
            model_name='attachment',
            name='civi',
            field=models.ForeignKey(to='api.Civi'),
        ),
        migrations.AddField(
            model_name='article',
            name='category',
            field=models.ForeignKey(default=None, to='api.Category', null=True),
        ),
        migrations.AddField(
            model_name='account',
            name='pinned',
            field=models.ManyToManyField(to='api.Civi'),
        ),
    ]
