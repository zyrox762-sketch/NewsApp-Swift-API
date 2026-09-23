//
//  HomeView.swift
//  NewsApp
//
//  Created by !---------? on 20/09/2026.
//

import SwiftUI
struct CategoryItem: Identifiable {
    let id = UUID()
    let name: String
    let apiKey: String
    let icon: String
}

struct HomeView: View {
    @State var selectedCategory:String = "General"
    @EnvironmentObject var vm:NewsViewModel
    
    private let categories: [CategoryItem] = [
            CategoryItem(name: "General", apiKey: "general", icon: "newspaper.fill"),
            CategoryItem(name: "Business", apiKey: "business", icon: "chart.bar.fill"),
            CategoryItem(name: "Tech", apiKey: "technology", icon: "cpu.fill"),
            CategoryItem(name: "Sports", apiKey: "sports", icon: "sportscourt.fill"),
            CategoryItem(name: "Science", apiKey: "science", icon: "atom"),
            CategoryItem(name: "Health", apiKey: "health", icon: "heart.fill")
        ]
    
    var body: some View {
        NavigationView {
                    VStack(spacing: 16) {
                        // Category Pills Selector
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(categories) { category in
                                    let isSelected = selectedCategory == category.apiKey
                                    
                                    Button {
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                            selectedCategory = category.apiKey
                                        }
                                        Task {
                                            await vm.fetchNews(category: category.apiKey)
                                        }
                                    } label: {
                                        HStack(spacing: 6) {
                                            Image(systemName: category.icon)
                                                .font(.subheadline)
                                            
                                            Text(category.name)
                                                .font(.subheadline)
                                                .fontWeight(.semibold)
                                        }
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 10)
                                        .background(
                                            Capsule()
                                                .fill(isSelected ? Color.blue : Color(.systemGray6))
                                        )
                                        .foregroundColor(isSelected ? .white : .primary)
                                        .shadow(color: isSelected ? Color.blue.opacity(0.3) : Color.clear, radius: 6, x: 0, y: 3)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                        }
                        
                        // Content Feed
                        if vm.isLoading {
                            Spacer()
                            ProgressView()
                            Spacer()
                        } else if let error = vm.errorMessage {
                            Spacer()
                            Text(error)
                                .font(.headline)
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                                .padding()
                            Spacer()
                        } else if vm.articles.isEmpty {
                            Spacer()
                            Text("No articles found!")
                                .foregroundColor(.secondary)
                            Spacer()
                        } else {
                            List(vm.articles) { article in
                                NavigationLink {
                                    ArticleDetailView(detailView: article)
                                } label: {
                                    ArticlerRowView(article: article)
                                }
                            }
                            .listStyle(.plain)
                        }
                    }
                    .navigationTitle("Categories")
                }
                .onAppear {
                    Task {
                        await vm.fetchNews(category: selectedCategory)
                    }
                }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
