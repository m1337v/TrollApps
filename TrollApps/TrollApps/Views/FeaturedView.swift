//
//  FeaturedView.swift
//  TrollApps
//
//  Created by Анохин Юрий on 21.11.2022.
//

import SwiftUI

struct FeaturedView: View {
    @State private var showFullVersion: Bool = false
    @State private var repos: [RepoMemory] = []
    @EnvironmentObject var repoManager: RepositoryManager

    var sortedRepos: [RepoMemory] {
        repos.sorted { ($0.data.name ?? "UNNAMED_REPO") < ($1.data.name ?? "UNNAMED_REPO") }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sortedRepos) { repo in
                    if let featuredApps = repo.data.featuredApps, !featuredApps.isEmpty {
                        Section(header: Text(repo.data.name ?? "UNNAMED_REPO")) {
                            ForEach(featuredApps, id: \.self) { featuredAppId in
                                FeaturedAppRow(repo: repo, featuredAppId: featuredAppId)
                            }
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("FEATURED")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .onAppear {
            repos = repoManager.ReposData
        }
        .onChange(of: repoManager.hasFinishedFetchingRepos) { _ in
            repos = repoManager.ReposData
        }
    }
}

