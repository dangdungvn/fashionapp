from rest_framework import generics, status
from rest_framework.response import Response
from rest_framework.views import APIView
from . import models, serializers
from django.db.models import Count
import random
import unicodedata
from django.db.models import Q
from rest_framework.pagination import PageNumberPagination


class StandardResultsSetPagination(PageNumberPagination):
    page_size = 5
    page_size_query_param = "page_size"
    max_page_size = 100


class CategoryList(generics.ListAPIView):
    serializer_class = serializers.CategorySerializer
    queryset = models.Category.objects.all()
    pagination_class = PageNumberPagination


class HomeCategoryList(generics.ListAPIView):
    serializer_class = serializers.CategorySerializer

    def get_queryset(self):
        queryset = models.Category.objects.all()
        queryset = queryset.annotate(random_order=Count("id"))
        queryset = list(queryset)
        random.shuffle(queryset)
        return queryset[:5]


class BrandList(generics.ListAPIView):
    serializer_class = serializers.BrandSerializer
    queryset = models.Brand.objects.all()


class ProductList(generics.ListAPIView):
    serializer_class = serializers.ProductSerializer
    pagination_class = StandardResultsSetPagination

    def get_queryset(self):
        queryset = models.Product.objects.all()
        return queryset


class PopularProductList(generics.ListAPIView):
    serializer_class = serializers.ProductSerializer

    def get_queryset(self):
        queryset = models.Product.objects.filter(ratings__gte=4.0, ratings__lte=5.0)
        queryset = queryset.annotate(random_order=Count("id"))
        queryset = list(queryset)
        random.shuffle(queryset)
        return queryset[:20]


class ProductListByClothesType(APIView):
    serializer_class = serializers.ProductSerializer

    def get(self, request):
        query = request.query_params.get("clothesType", None)
        if query:
            queryset = models.Product.objects.filter(clothesType=query)
            queryset = queryset.annotate(random_order=Count("id"))
            products_list = list(queryset)
            random.shuffle(products_list)
            limited_products = products_list[:20]
            serializer = serializers.ProductSerializer(limited_products, many=True)
            return Response(serializer.data)
        else:
            return Response(
                {"message": "No query provided"}, status=status.HTTP_400_BAD_REQUEST
            )


class ProductById(APIView):
    def get(self, request, pk):
        try:
            product = models.Product.objects.get(id=pk)
            serializer = serializers.ProductSerializer(product)
            return Response(serializer.data)
        except models.Product.DoesNotExist:
            return Response(
                {"message": "Product not found"}, status=status.HTTP_404_NOT_FOUND
            )


class SimilarProducts(APIView):
    def get(self, request):
        query = request.query_params.get("category", None)

        if query:
            products = models.Product.objects.filter(category=query)
            product_list = list(products)
            random.shuffle(product_list)
            limited_products = product_list[:6]
            serializer = serializers.ProductSerializer(limited_products, many=True)
            return Response(serializer.data)
        else:
            return Response(
                {"message": "No query provided"}, status=status.HTTP_400_BAD_REQUEST
            )


def remove_accents(input_str):
    nfkd_form = unicodedata.normalize("NFKD", input_str)
    return "".join([c for c in nfkd_form if not unicodedata.combining(c)])


class SearchProductByTitle(APIView):
    def get(self, request):
        query = request.query_params.get("q", None)

        if query:
            # Loại bỏ dấu tiếng Việt từ chuỗi tìm kiếm
            query_no_accents = remove_accents(query)

            # Tìm kiếm sản phẩm với tiêu đề không dấu
            products = models.Product.objects.filter(
                Q(title__icontains=query) | Q(title__icontains=query_no_accents)
            )
            serializer = serializers.ProductSerializer(products, many=True)
            return Response(serializer.data)
        else:
            return Response(
                {"message": "No query provided"}, status=status.HTTP_400_BAD_REQUEST
            )


class FilterProductsByCategory(APIView):
    def get(self, request):
        query = request.query_params.get("category", None)

        if query:
            products = models.Product.objects.filter(category=query)
            serializer = serializers.ProductSerializer(products, many=True)
            return Response(serializer.data)
        else:
            return Response(
                {"message": "No query provided"}, status=status.HTTP_400_BAD_REQUEST
            )
