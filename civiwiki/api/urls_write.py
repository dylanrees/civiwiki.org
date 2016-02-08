from django.conf.urls import url
import views_write as v

urlpatterns = [
    url(r'^addcivi$', v.addCivi, name='add civi'),
    url(r'^reportvote$', v.reportVote, name='report vote'),
]
