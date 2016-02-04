from django.conf.urls import url
import frontend_views as views

urlpatterns = [
    url(r'^login$', views.login_view, name='login'),
    url(r'^bar$',views.blah_view, name='blah')
]
