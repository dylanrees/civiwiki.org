from django.conf.urls import url
import views_write as v

urlpatterns = [
    url(r'^addpage$', v.addPage, name='add page'),
    url(r'^addcivi$', v.addCivi, name='add civi'),
    url(r'^editUser$',v.editUser, name='edit user'),
    url(r'^reportvote$', v.reportVote, name='report vote')
]
