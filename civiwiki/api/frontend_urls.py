from django.conf.urls import url
import template_views as views

urlpatterns = [
    url(r'^db$', views.database_view, name='database')
]
