from django.http import JsonResponse
from django.conf import settings
from django.shortcuts import render


def index(request):
    return render(request, "home.html", {})


def about(request):
    return render(request, "about.html", {})


def healthz(request):
    return JsonResponse({
        "status": "ok",
        "debug": settings.DEBUG,
    })

# Create your views here.
