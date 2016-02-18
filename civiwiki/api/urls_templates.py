from django.conf.urls import url
import views_templates as v

urlpatterns = [
    url(r'^createpage', v.create_page, name='add page'),
    url(r'^login$', v.login_view, name='login'),
    url(r'^home$', v.home_view, name='home'),
    url(r'^support_us$', v.support_us_view, name='support us'),
    url(r'', v.does_not_exist, name='404')
]
