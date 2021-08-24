from django.http import HttpResponseRedirect
from django.shortcuts import render

# Create your views here.
from django.urls import reverse
from django.views.generic import RedirectView

from articleapp.models import Article
from likeapp.models import LikeRecord


class LikeArticleView(RedirectView):
    def get(self, request, *args, **kwargs):
        user = request.user
        article = Article.objects.get(pk=kwargs['article_pk'])

        like_record = LikeRecord.objects.filter(user=user,
                                                article=article)
        if like_record.exists():
            return HttpResponseRedirect('article:detail',
                                        kwargs={'pk': kwargs['article_pk']})
        else:
            LikeArticleView(user=user, article=article).save()
        article.like += 1
        article.save()
        return super().get(request, *args, **kwargs)

    def get_redirect_url(self, *args, **kwargs):
        return reverse('articleapp:detail', kwargs={'pk': kwargs['article_pk']})
