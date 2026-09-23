//
//  ArticleDetailView.swift
//  NewsApp
//
//  Created by !---------? on 20/09/2026.
//

import SwiftUI

struct ArticleDetailView: View {
    
    let detailView:Article
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 12){
                AsyncImage(url: URL(string: detailView.urlToImage ?? "")) { image in
                        image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 180)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
                Text(detailView.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(4)
                Text(detailView.author ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                HStack {
                    Text("\(detailView.source.name) •")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .tracking(1)
                    Text(detailView.publishedAt)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Divider()
                
                Text("Description")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(detailView.content ?? "")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(8)
                
                
            }
            .padding()
            .background(Color("backgroundColor"))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.5), radius: 7, x: 0, y: 2)
            .padding(.horizontal)
        }
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailView( detailView: Article(source: Source(name: ""), author: "" , title: "", description: "" , url: "", urlToImage: "" , publishedAt: "", content: "" ))
            
    }
}
