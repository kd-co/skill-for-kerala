from django.db import models
from random import choice
from django.utils.translation import ugettext_lazy as _
from django.contrib.auth.models import User

class Profile(models.Model):
    user = models.OneToOneField(User)
    skill = models.CharField(_('Skill'), max_length=50, blank=True, null=True)
    bio = models.TextField(_('Bio'), blank=True, null=True)
    location = models.CharField(_('Location'), max_length=40, blank=True, null=True)
    # token = models.CharField(_('Token'), max_length=15, unique=True, db_index=True, null=True)

    def set_token(self):
	    self.token = ''.join([choice('abcdefghijklmnopqrstuvwxyz0123456789') for i in range(15)])

    def save(self, *args, **kwargs):
	    super(Profile, self).save(*args, **kwargs)
	    self.set_token()