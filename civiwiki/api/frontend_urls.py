from django.conf.urls import url
import frontend_views as views

urlpatterns = [
    url(r'^login$', views.login_view, name='login'),
    url(r'^home$',views.home_view, name='home'),
    url(r'',views.home_view, name='home')
]
