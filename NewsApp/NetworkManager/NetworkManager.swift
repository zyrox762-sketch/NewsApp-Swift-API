//
//  NetworkManager.swift
//  NewsApp
//
//  Created by !---------? on 20/09/2026.
//

import Foundation

enum NetworkErrors:Error{
    case invalidURL
    case serverError
    case networkError
    case decodingError
}

class NetworkManager{
    
    func fetchNews(category:String) async throws -> ArticleResponse{
        
        //URL Components
        guard var components = URLComponents(string: "https://newsapi.org/v2/top-headlines") else{
            throw NetworkErrors.invalidURL
        }
        components.queryItems = [URLQueryItem(name: "country", value: "us"),
        URLQueryItem(name: "apiKey", value: "cb1be06237f340009845995ac385626f"),
        URLQueryItem(name: "category", value: "\(category)")]
        
        //URL
        guard let url = components.url else{
            throw NetworkErrors.invalidURL
        }
        
        //Request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //URL Session
        let (data,response) = try await URLSession.shared.data(for: request)
        
        //Response
        if let response = response as? HTTPURLResponse {
            if response.statusCode != 200{
                throw NetworkErrors.serverError
            }
            print("Status Code:\(response.statusCode)")
        }
        do{
            let result = try JSONDecoder().decode(ArticleResponse.self, from: data)
            print("Request started")
            print("Articles: \(result.articles.count)")
            return result
        }
        catch{
            print("DECODING ERROR:", error)
            throw error
        }
    }
}
