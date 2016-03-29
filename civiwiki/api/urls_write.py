from django.conf.urls import url
import views_write as v

urlpatterns = [
    url(r'^createpage$', v.createPage, name='add page'),
    url(r'^createcivi$', v.createCivi, name='add civi'),
    url(r'^edituser$',v.editUser, name='edit user'),
    url(r'^requestfriend$',v.requestFriend, name='request friend'),
    url(r'^acceptfriend$',v.acceptFriend, name='accept friend'),
    url(r'^removefriend$',v.removeFriend, name='remove friend'),
    url(r'^followpage$',v.followPage, name='follow page'),
    url(r'^unfollowpage$', v.unfollowPage, name='unfollow page')
]
