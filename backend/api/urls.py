from django.conf.urls import url
import views

urlpatterns = [
    url(r'^foo$', views.foo, name='example'),
    
]