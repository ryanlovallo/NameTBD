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
    // hardcoded
    // var likedUserhardcode: LikedUsers = LikedUsers(name: "Rylo")
    
    var body: some View {
        
        // likedUserhardcode: LikedUsers
        NavigationView {
            List(store.profiles.indices, id: \.self) {
                // NavigationLink(destination: OtherUserView()) {
                LikedUserRow(likedUser: store.profiles[$0])
                 // }
            }
            .refreshable {
                store.getLikes()
            }
            .onAppear {
                store.getLikes()
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
}

//struct LikedUsersView_Previews: PreviewProvider {
//    static var previews: some View {
//        LikedUsersView()
//    }
//}
