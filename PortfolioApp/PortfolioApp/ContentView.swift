//
//  ContentView.swift
//  PortfolioApp
//
//  Created by Ryan Lovallo on 3/14/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var viewType = "Home"
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        if viewType == "likedusers" {
            LikedUsersView(usersViewType: $viewType)
        }
        else if viewType == "profile" {
            ProfileView(profileViewType: $viewType)
        } else {
            HomeView(homeViewType: $viewType)
        }
           
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
