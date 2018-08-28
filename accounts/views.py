# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.shortcuts import render
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login
from django.http import HttpResponseRedirect, HttpResponse
from django import forms
from forms import RegisterForm, ProfileForm
from .models import Profile

def home(request):
    profiles = Profile.objects.all()
    context = {
        'profiles': profiles
    }
    return render(request, 'accounts/home.html', context)


def register(request):
    if request.method == 'POST':
            register = RegisterForm(request.POST, prefix='register')
            usrprofile = ProfileForm(request.POST, prefix='profile')
            print register
            if register.is_valid() * usrprofile.is_valid():
                user = register.save()
                usrprof = usrprofile.save(commit=False)
                usrprof.user = user
                # usrprof.set_token()
                usrprof.subscribed = '1'
                usrprof.save()
                return HttpResponse('congrats')
            else:
                return HttpResponse('errors')
    else:
        userform = RegisterForm(prefix='register')
        userprofileform = ProfileForm(prefix='profile')
        return render(request, 'accounts/register.html', {'userform': userform, 'userprofileform': userprofileform})