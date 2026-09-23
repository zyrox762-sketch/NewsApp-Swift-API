//
//  SearchView.swift
//  NewsApp
//
//  Created by !---------? on 20/09/2026.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var vm:NewsViewModel
    @State var searchField:String = ""
    
    var filteredArticles:[Article]{
        if searchField.isEmpty{
            return vm.articles
        }
        else{
            return  vm.articles.filter { article in
                article.title.lowercased().contains(searchField.lowercased()) || (article.description ?? "").lowercased().contains(searchField.lowercased()) || (article.author ?? "").lowercased().contains(searchField.lowercased()) || (article.source.name).lowercased().contains(searchField.lowercased())
            }
        }
    }
   
    var body: some View {
        NavigationView{
            VStack{
                TextField("Enter a article...", text: $searchField)
                    .padding()
                    .font(.system(size: 30, weight: .semibold))
                    .background(.gray.opacity(0.6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                List(filteredArticles){ article in
                    NavigationLink {
                        ArticleDetailView(detailView: article)
                    } label: {
                        VStack(alignment:.leading,spacing:12){
                            Text(article.source.name)
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                                .tracking(1)
                            Text(article.title)
                                .font(.headline)
                                .foregroundColor(.primary)
                                .lineLimit(4)
                            Text(article.author ?? "")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                            Text(article.description ?? "")
                                .font(.subheadline).foregroundColor(.secondary)
                            Text(article.publishedAt)
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                            AsyncImage(url: URL(string: article.urlToImage ?? "")) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 180)
                                    .clipped()
                                    
                            } placeholder: {
                                Text("Loading...")
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 4)
                    }
                    }

            }
            .padding(.vertical)
        }
        }
        
        .onAppear {
            Task{
                await vm.fetchNews(category: "general")
            }
        }
}
}
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
