import SwiftUI

struct FeaturedAppRow: View {
    var repo: RepoMemory
    var featuredAppId: String  // Adjust type if necessary.
    @EnvironmentObject var repoManager: RepositoryManager
    
    var body: some View {
        // Fetch the apps for this repo and featured app id.
        let apps = repoManager.fetchAppsInRepo(repoInput: repo.data, bundleIdInput: featuredAppId)
        
        return ForEach(apps, id: \.self) { app in
            AppCell(app: app, showFullMode: false)
                .listRowInsets(EdgeInsets())
        }
    }
}
