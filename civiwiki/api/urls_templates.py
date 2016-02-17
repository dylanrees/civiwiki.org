from django.conf.urls import url
import views_templates as v

urlpatterns = [
	url(r'^privacy_policy$', v.privacyPolicy, name='privacy_policy'),
    url(r'^privacy_policy$', v.userAgreement, name='privacy_policy'),
    url(r'^login$', v.login_view, name='login'),
    url(r'^home$', v.home_view, name='home'),
    url(r'', v.home_view, name='home'),    
]
