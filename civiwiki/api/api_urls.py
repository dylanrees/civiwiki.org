from django.conf.urls import url
import api_views as views
import login_views as access
import step

urlpatterns = [
    url(r'^getcivi$', views.getCivi, name='civi'),
    url(r'^topten$', views.topTen, name='example'),
    url(r'^articles$', views.getArticles, name='get articles'),
    url(r'^categories$', views.getCategories, name='get categories'),
    url(r'^user$', views.getUser, name='get user'),
    url(r'^adduser$', views.addUser, name='add user'),
    url(r'^addcivi$', views.addCivi, name='add civi'),
    url(r'^reportvote$', views.reportVote, name='report vote'),
    url(r'^getblock$', views.getBlock, name='get block'),
    url(r'^step$', step.stepTest, name='step algo'),
    url(r'^backend/link$',views.linkCivis, name='link civis'),
    url(r'^login', access.login, name='login'),
    url(r'^register', access.register, name='login'),
    url(r'^getlevel$', views.getCiviLevel, name='get level')
]
