//
//  ContentView.swift
//  PortfolioApp
//
//  Created by Ryan Lovallo on 3/14/22.
//

import SwiftUI

struct ProfileView: View {
    @Binding var profileViewType: String
    
    var username = "Rylo96"
    var jobtitle = "Master debater"
    var loc = "Club space, miami"
    var bio = "It Means bad kid random. This is used in video games when a person gets a random kid on their team and he is bad at the game. Look at this BK Randy on our team, he is so terrible."
    
    var number = "69-6969-69"
    var email = "ryan@gmail.com"
    
    var body: some View {
    
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(username).bold().font(.largeTitle)
                    
                    NavigationLink(destination: EditProfileView()) {
                        Text("Edit")
                    }
                    
                    Group {
                        Divider()
                        Text("**Job title:** \(jobtitle)")
                        Text("**Location:** \(loc)")
                        
                        Divider()
                        Text("Bio").bold()
                    }
                    
                    Text(bio).padding().border(Color.black)
                    Divider()
                    Group {
                        Text("Contact Information").bold().font(.title)
                        Text("**Phone number**: \(number)")
                        Text("**Email**: \(email)")
                    }

                }
            }
                .padding()
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
}
//
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
