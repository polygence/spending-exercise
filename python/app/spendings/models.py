from django.db import models
from datetime import datetime

class Spending(models.Model):
    id = models.AutoField(primary_key=True)
    description = models.CharField(max_length=255)
    amount = models.DecimalField(max_digits=6, decimal_places=2, default=0)
    spent_at = models.DateTimeField('Time spent', default=datetime.now())
    currency = models.CharField(max_length=3, default='HUF')

    def __str__(self):
        return self.id
