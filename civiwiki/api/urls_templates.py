from django.conf.urls import url
import views_templates as v

urlpatterns = [
    url(r'^login$', v.login_view, name='login'),
    url(r'^home$', v.home_view, name='home'),
    url(r'', v.home_view, name='home')
]