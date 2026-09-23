//
//  ArticlerRowView.swift
//  NewsApp
//
//  Created by !---------? on 20/09/2026.
//

import SwiftUI

struct ArticlerRowView: View {
    let article:Article
    var body: some View {
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
            
            AsyncImage(url: URL(string: article.urlToImage ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 180)
                    .clipped()
                    
            } placeholder: {
                ProgressView()
            }
            Text(article.description ?? "")
                .font(.subheadline).foregroundColor(.secondary)
            Text(article.publishedAt)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct ArticlerRowView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlerRowView(article: Article(source: Source(name: ""), author: "" , title: "", description: "" , url: "", urlToImage: "" , publishedAt: "", content: "" ))
    }
}
