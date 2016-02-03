from django.conf.urls import url
import template_views as views

urlpatterns = [
    url(r'^foo$', views.hello_view, name='foo')
]
