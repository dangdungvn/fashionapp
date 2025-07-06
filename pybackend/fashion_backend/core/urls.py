from django.contrib import admin
from django.urls import path
from core import views


urlpatterns = [
    path("categories/", views.CategoryList.as_view(), name="category-list"),
    path(
        "categories/home/", views.HomeCategoryList.as_view(), name="home-category-list"
    ),
    # Admin Category CRUD endpoints
    path(
        "categories/create/", views.CategoryCreateView.as_view(), name="category-create"
    ),
    path(
        "categories/<int:id>/",
        views.CategoryDetailView.as_view(),
        name="category-detail",
    ),
    path(
        "categories/<int:id>/update/",
        views.CategoryUpdateView.as_view(),
        name="category-update",
    ),
    path(
        "categories/<int:id>/delete/",
        views.CategoryDeleteView.as_view(),
        name="category-delete",
    ),
    # Admin check endpoint
    path("admin/check/", views.AdminCheckView.as_view(), name="admin-check"),
    path("", views.ProductList.as_view(), name="product-list"),
    path("popular/", views.PopularProductList.as_view(), name="popular-list"),
    path("byType/", views.ProductListByClothesType.as_view(), name="list-by-type"),
    path("search/", views.SearchProductByTitle.as_view(), name="search"),
    path(
        "category/",
        views.FilterProductsByCategory.as_view(),
        name="products-by-category",
    ),
    path("recommendations/", views.SimilarProducts.as_view(), name="similar-products"),
    path("<int:pk>/", views.ProductById.as_view(), name="product-detail"),
]
