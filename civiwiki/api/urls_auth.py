from django.conf.urls import url
import views_auth as v
urlpatterns = [
    url(r'^login', v.cw_login, name='login'),
    url(r'^logout', v.cw_logout, name='logout'),
    url(r'^register', v.cw_register, name='register'),
    url(r'^validate/(?P<activation_key>\w+)/$', v.cw_validate, name='validate')
]
