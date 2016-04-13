from django.http import Http404, HttpResponse, HttpResponseRedirect
from django.test import TestCase
from api.models import *
from django.http import JsonResponse
import json

# Create your tests here.
def hashtag_view(request):
   hashtagstrings= ""
   hashtags = Hashtag.objects.all()
   for h in hashtags:
      hashtagstrings += h.title + ", "
   
   return HttpResponse(hashtagstrings)

def category_view(request):
   names= ""
   objs = Category.objects.all()
   for o in objs:
      c = Category.objects.serialize(o)
      names+=c+" | "
   
   return HttpResponse(names)

def test_view2(request):
	cat = Category.objects.get(id=0)
	return JsonResponse({"result":json.dumps(Category.objects.serialize(cat))})


def test_view(request):
   # names= ""
   # objs = C.objects.all()
   # for o in objs:
   #    c = Topic.objects.serialize(o)
   #    names+=c+" | "
   names = Civi.objects.serialize(Civi.objects.get(id=2))
   return HttpResponse(names)
