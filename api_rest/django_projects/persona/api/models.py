from django.db import models

# Create your models here.
class Persona(models.Model):

    id = primary_key=True
    nombre = models.CharField(max_length=100, help_text='name')
    apellido = models.CharField(max_length=100, help_text='apellid')
    email = models.CharField(max_length=100, help_text='email')
    
    class Meta:
        ordering = ['id']