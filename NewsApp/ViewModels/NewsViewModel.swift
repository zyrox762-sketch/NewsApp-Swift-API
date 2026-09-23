//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by !---------? on 20/09/2026.
//

import Foundation

@MainActor
class NewsViewModel:ObservableObject{
    @Published var articles:[Article] = []
    @Published var isLoading:Bool = false
    @Published var errorMessage:String?
    
    @Published var networkManager = NetworkManager()
    
    func fetchNews(category:String) async {
        isLoading = true
        errorMessage = nil
        do{
            let article = try await networkManager.fetchNews(category: category)
            articles = article.articles
            print("Loading:", isLoading)
            
        }
        catch{
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
