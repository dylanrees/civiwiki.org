from django.conf.urls import url
import views

urlpatterns = [
    url(r'^foo$', views.foo, name='example'),
    url(r'^articles$', views.getArticles, name='get articles'),
    url(r'^categories$', views.getCategories, name='get categories')

]
