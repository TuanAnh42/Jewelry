import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Product } from './show-product.interface';
@Injectable({
  providedIn: 'root'
})
export class ShowProductService {
  apiUrl = 'https://localhost:7051/api/products';

  constructor(private http: HttpClient) { }

  getAllProducts(): Observable<Product[]> {
    return this.http.get<Product[]>(this.apiUrl);
  }


  getProductById(id: number): Observable<Product> {
    const url = `${this.apiUrl}/${id}`;
    return this.http.get<Product>(url);
  }

  updateProduct(product: Product): Observable<Product> {
    const url = `${this.apiUrl}/${product.id}`;
    return this.http.put<Product>(url, product);
  }

  searchProducts(name: string, minPrice: number, maxPrice: number): Observable<Product[]> {
    const url = `${this.apiUrl}?title=${name}&price_gte=${minPrice}&price_lte=${maxPrice}`;
    return this.http.get<Product[]>(url);
  }
 
}
