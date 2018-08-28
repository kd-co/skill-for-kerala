from django import forms
from django.contrib.auth.models import User
from .models import Profile
from django.utils.translation import ugettext_lazy as _


class RegisterForm(forms.ModelForm):
    password = forms.CharField(widget=forms.PasswordInput())

    class Meta:
        model = User
        fields = ['email', 'first_name', 'last_name', 'password', 'username']


class ProfileForm(forms.ModelForm):

    class Meta:
        model = Profile
        fields = ['skill', 'location']