//
//  LikedUsersView.swift
//  PortfolioApp
//
//  Created by Ryan Lovallo on 3/14/22.
//

import SwiftUI

struct LikedUsersView: View {
    
    @Binding var usersViewType: String
    @ObservedObject var store = ProfileStore.shared
    
    @State private var searchText = ""
    
    // var likedUserhardcode: LikedUsers = LikedUsers(name: "Rylo")
    
    var body: some View {

        NavigationView {
            List {
                ForEach(searchResults, id: \.userID) { rw in
                    LikedUserRow(likedUser: rw)
//                    Text(rw.username!)
                }
            }
            .navigationBarTitle("Filter by industry")
            .searchable(text: $searchText)
            .refreshable {
                store.getLikes(id: "10")    // 10 should be the user of the device's ID
                print(store.profiles)
            }
            .onAppear {
                store.getLikes(id: "10")    // 10 should be the user of the device's ID
            }

        }
        .padding()
        .navigationTitle("SwiftUI Rylo")
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                ZStack {
                    Button(action: {
                        self.usersViewType = "home"
                    }) {
                        Text("Home")
                    }
                }
                
                ZStack {
                    Button(action: {
                        self.usersViewType = "likedusers"
                    }) {
                        Text("Liked Users")
                    }
                }
                
                ZStack {
                    Button(action: {
                        self.usersViewType = "profile"
                    }) {
                        Text("Profile")
                    }
                }

            }
        }
    }
    
    var searchResults: [Profile] {
        if searchText.isEmpty {
            return store.profiles
        } else {
            return store.profiles.filter { ($0.industry!).contains(searchText) }
        }
    }
}

//struct LikedUsersView_Previews: PreviewProvider {
//    static var previews: some View {
//        LikedUsersView()
//    }
//}
