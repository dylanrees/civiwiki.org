from django.conf.urls import url
import views_write as v

urlpatterns = [
    url(r'^creategroup$', v.createGroup, name='add group'),
    url(r'^createcivi$', v.createCivi, name='add civi'),
    url(r'^edituser$',v.editUser, name='edit user'),
    url(r'^requestfriend$',v.requestFriend, name='request friend'),
    url(r'^acceptfriend$',v.acceptFriend, name='accept friend'),
    url(r'^removefriend$',v.removeFriend, name='remove friend'),
    url(r'^followgroup$',v.followGroup, name='follow group'),
    url(r'^unfollowgroup$', v.unfollowGroup, name='unfollow group'),
    url(r'^pincivi$', v.pinCivi, name='pin civi'),
    url(r'^unpincivi$', v.unpinCivi, name='unpin civi')
    # url(r'^reportvote$', v.reportVote, name='report vote')
]
