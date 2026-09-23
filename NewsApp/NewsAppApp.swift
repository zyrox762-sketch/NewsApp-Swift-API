//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by !---------? on 20/09/2026.
//

import SwiftUI

@main
struct NewsAppApp: App {
    var body: some Scene {
        WindowGroup {
            TabView{
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                            .font(.title2)
                            .bold()
                        
                    }
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                            .font(.title2)
                            .bold()
                    }
            }
            .environmentObject(NewsViewModel())
        }
    }
}
