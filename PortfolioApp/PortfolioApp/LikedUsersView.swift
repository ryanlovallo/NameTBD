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

        NavigationView {
            
            List {
                ForEach(store.profiles, id: \.userID) { rw in
                    let _ = print("fuck")
                    let _ = print(rw)
                    LikedUserRow(likedUser: rw)
//                    Text(rw.username!)
                }
            }
            .refreshable {
                store.getLikes(id: "10")
            }
            .onAppear {
                store.getLikes(id: "10")
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
