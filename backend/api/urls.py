from django.conf.urls import url
import views

urlpatterns = [
    url(r'^getcivi$', views.getCivi, name='civi'),
    url(r'^topten$', views.topTen, name='example'),
    url(r'^login$', views.login, name='login'),
    url(r'^articles$', views.getArticles, name='get articles'),
    url(r'^categories$', views.getCategories, name='get categories'),
    url(r'^user$', views.getUser, name='get user'),
    url(r'^adduser$', views.addUser, name='add user'),
    url(r'^addcivi$', views.addCivi, name='add civi'),
    url(r'^reportvote$', views.reportVote, name='report vote'),
    url(r'^getblock$', views.getBlock, name='get block'),
    url(r'^backend/link$',views.linkCivis, name='link civis')
]
