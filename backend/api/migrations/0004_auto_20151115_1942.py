# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0003_auto_20151115_1745'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='hashtag',
            name='votes',
        ),
        migrations.AddField(
            model_name='account',
            name='about_me',
            field=models.CharField(default='', max_length=511),
        ),
        migrations.AddField(
            model_name='account',
            name='pinned',
            field=models.ManyToManyField(to='api.Civi'),
        ),
        migrations.AddField(
            model_name='civi',
            name='AND_NEGATIVE',
            field=models.ForeignKey(related_name='AND_NEGATIVE_REL', default='', to='api.Civi', null=True),
        ),
        migrations.AddField(
            model_name='civi',
            name='AND_POSITIVE',
            field=models.ForeignKey(related_name='AND_POSITIVE_REL', default='', to='api.Civi', null=True),
        ),
        migrations.AddField(
            model_name='civi',
            name='AT',
            field=models.ForeignKey(related_name='AT_REL', default='', to='api.Civi', null=True),
        ),
        migrations.AddField(
            model_name='civi',
            name='REFERENCE',
            field=models.ForeignKey(related_name='REFERENCE_REL', default='', to='api.Civi', null=True),
        ),
        migrations.AddField(
            model_name='hashtag',
            name='votes_negative1',
            field=models.IntegerField(default=0, null=True),
        ),
        migrations.AddField(
            model_name='hashtag',
            name='votes_negative2',
            field=models.IntegerField(default=0, null=True),
        ),
        migrations.AddField(
            model_name='hashtag',
            name='votes_neutral',
            field=models.IntegerField(default=0, null=True),
        ),
        migrations.AddField(
            model_name='hashtag',
            name='votes_positive1',
            field=models.IntegerField(default=0, null=True),
        ),
        migrations.AddField(
            model_name='hashtag',
            name='votes_positive2',
            field=models.IntegerField(default=0, null=True),
        ),
        migrations.AlterField(
            model_name='article',
            name='category',
            field=models.ForeignKey(default=None, to='api.Category', null=True),
        ),
    ]
