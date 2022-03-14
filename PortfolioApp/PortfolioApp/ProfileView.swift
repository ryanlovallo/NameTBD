//
//  ContentView.swift
//  PortfolioApp
//
//  Created by Ryan Lovallo on 3/14/22.
//

import SwiftUI

struct ProfileView: View {
    @Binding var profileViewType: String
    
    var body: some View {
        Text("This will be the interface of someone's profile")
            .padding()
            .navigationTitle("SwiftUI Rylo")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    
                    ZStack {
                        Button(action: {
                            self.profileViewType = "home"
                        }) {
                            Text("Home")
                        }
                    }
                    
                    ZStack {
                        Button(action: {
                            self.profileViewType = "likedusers"
                        }) {
                            Text("Liked Users")
                        }
                    }
                    
                    ZStack {
                        Button(action: {
                            self.profileViewType = "profile"
                        }) {
                            Text("Profile")
                        }
                    }

                }
            }
    }
}
//
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
