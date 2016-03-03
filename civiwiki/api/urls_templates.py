from django.conf.urls import url
import views_templates as v

urlpatterns = [
    url(r'^createpage', v.create_page, name='add page'),
    url(r'^login', v.login_view, name='login'),
    url(r'^supportus', v.support_us_view, name='support us'),
    url(r'^beta', v.beta_view, name='beta'),
    url(r'^about', v.about_view, name='about'),
    url(r'^account', v.account_home, name='account home'),
    url(r'^$', v.home_view, name='home'),
    url(r'', v.does_not_exist, name='404')
]
