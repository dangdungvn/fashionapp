from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.views import APIView
from rest_framework import status
from core.models import Product
from order.models import Order
from . import models, serializers
from django.shortcuts import get_object_or_404
from django.db.models import Avg


class AddReview(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        try:
            data = request.data

            rating_value = data["rating"]

            if rating_value is None:
                return Response(
                    {"message": "Rating value must be provided"},
                    status=status.HTTP_400_BAD_REQUEST,
                )

            try:
                rating_value = float(rating_value)
            except ValueError:
                return Response(
                    {"message": "Rating value must be a number"},
                    status=status.HTTP_400_BAD_REQUEST,
                )

            if not (1.0 <= rating_value and rating_value <= 5.0):
                return Response(
                    {"message": "Rating value must be between 1 to 5 inclusive"},
                    status=status.HTTP_400_BAD_REQUEST,
                )

            user = request.user

            product_id = data["product"]

            order_id = data["order"]

            if not product_id:
                return Response(
                    {"message": "Product value must be provided"},
                    status=status.HTTP_400_BAD_REQUEST,
                )

            product = get_object_or_404(Product, id=product_id)

            rating = models.Rating(
                rating=rating_value,
                review=data["review"],
                product=product,
                order=data["order"],
                userId=user,
            )

            rating.save()

            product_ratings = models.Rating.objects.filter(product=product)
            average_rating = product_ratings.aggregate(Avg("rating"))["rating__avg"]

            product.ratings = average_rating
            product.save()

            order = get_object_or_404(Order, id=order_id)

            if product_id not in order.rated:
                order.rated.append(product_id)
                order.save()

            return Response(
                {"message": "Rating created successfully"},
                status=status.HTTP_201_CREATED,
            )
        except Product.DoesNotExist:
            return Response(
                {"message": "Product not found"}, status=status.HTTP_404_NOT_FOUND
            )
        except Order.DoesNotExist:
            return Response(
                {"message": "Order not found"}, status=status.HTTP_404_NOT_FOUND
            )
        except Exception as e:
            print(str(e))
            return Response(
                {"message": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )
