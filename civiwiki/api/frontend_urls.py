from django.conf.urls import url
import template_views as views

urlpatterns = [
    url(r'^foo$', views.hello_view, name='foo'),
    url(r'^supportus$', views.support_us_view, name='supportus')
]
