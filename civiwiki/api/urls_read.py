from django.conf.urls import url
import views_read as v

urlpatterns = [
    url(r'^getcivi$', v.getCivi, name='civi'),
    url(r'^topten$', v.topTen, name='example'),
    url(r'^topics$', v.getTopics, name='get topics'),
    url(r'^categories$', v.getCategories, name='get categories'),
    url(r'^user$', v.getUser, name='get user'),
    url(r'^getblock$', v.getBlock, name='get block'),
]
