from rest_framework import serializers
from .models import Spending

from spendings import models

class SpendingSerializers(serializers.ModelSerializer):

    class Meta:
        model = Spending
        fields = ('description', 'amount', 'spent_at', 'currency')
        '''extra_kwwargs = {
            'description': {'max_length': 255},
            'amount': {'max_digits': 6, 'decimal_places': 2}
        }'''