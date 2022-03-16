//
//  ContentView.swift
//  PortfolioApp
//
//  Created by Ryan Lovallo on 3/14/22.
//

import SwiftUI

struct HomeView: View {
    @Binding var homeViewType: String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Button(action: {
            self.homeViewType = "proximity"
        }) {
            Text("ACTIVATE CONNECTION")
        }
            .padding()
            .navigationTitle("SwiftUI Rylo")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    ZStack {
                        Button(action: {
                            self.homeViewType = "home"
                        }) {
                            Text("Home")
                        }
                    }
                    
                    ZStack {
                        Button(action: {
                            self.homeViewType = "likedusers"
                        }) {
                            Text("Liked Users")
                        }
                    }
                    ZStack {
                        Button(action: {
                            self.homeViewType = "profile"
                        }) {
                            Text("Profile")
                        }
                    }

                }
            }
        
    }
}
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
