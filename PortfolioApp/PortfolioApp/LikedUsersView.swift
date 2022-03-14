//
//  LikedUsersView.swift
//  PortfolioApp
//
//  Created by Ryan Lovallo on 3/14/22.
//

import SwiftUI

struct LikedUsersView: View {
    
    @Binding var usersViewType: String
    
    var body: some View {
        Text("LIST OF USERS")
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
