from rest_framework import viewsets

from .models import Spending
from spendings.serializers import SpendingSerializers

class SpendingViewSet(viewsets.ModelViewSet):
    serializer_class = SpendingSerializers
    queryset  = Spending.objects.all()

    def get_queryset(self):
        response = self.queryset
        currency = self.request.query_params.get('currency')
        order_by = self.request.query_params.get('orderBy')
        if currency:
            response = response.filter(currency=currency)
        if order_by:
            response = response.order_by(order_by)
        return response

    def perform_create(self, serializer):
        serializer.save()