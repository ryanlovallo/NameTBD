//
//  ContentView.swift
//  PortfolioApp
//
//  Created by Ryan Lovallo on 3/14/22.
//

import SwiftUI

struct ProfileView: View {
    @Binding var profileViewType: String
    
    @ObservedObject var store = ProfileStore.shared
    @State var idnum : String = "10"      // TODO:  THIS IS THE ID OF THE USER THAT IS OPERATING THE APP
    
    var body: some View {
    
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    
                    // ONCE WE HAVE A CALL TO THE BACKEND, REPLACE THESE VALUES
                    let username : String = store.prof.username ?? "error"
                    let number : String = store.prof.number ?? "error"
                    let email : String = store.prof.email ?? "error"
                    let jobtitle : String = store.prof.jobtitle ?? "error"
                    let age : String = store.prof.age ?? "error"
                    let gender : String = store.prof.gender ?? "error"
                    let industry : String = store.prof.industry ?? "error"
                    let education : String = store.prof.education ?? "error"
                    let interests : String = store.prof.interests ?? "error"
                    let bio : String = store.prof.bio ?? "error"
                    let profpic : String = store.prof.profpic ?? "error"
                    let loc : String = store.prof.loc ?? "error"

                    Text(username).bold().font(.largeTitle)
                    
                    NavigationLink(destination: EditProfileView(usrid: idnum, pimporter: false, jt: jobtitle, ag: age, gen: gender,
                                                                ind: industry, edu: education, intr: interests, b: bio,
                                                                ppic: profpic, lc: loc)) {
                        Text("Edit")
                    }
                    
                    Group {
                        Divider()
                        Text("**Location:** \(loc)")
                        Text("**Industry:** \(industry)")
                        Text("**Job title:** \(jobtitle)")
                        

                        Divider()
                        Text("Bio:").bold()

                        Text(bio).padding().border(Color.black)
                        Group {
                        
                            Text("**Interests**: \(interests)")
                            Divider()
                            
                            Text("**Age**: \(age)")
                            Text("**Gender**: \(gender)")
                            Text("**Education**: \(education)")
                    
                            Divider()
                        
                            Text("Contact Information").bold().font(.title)
                            Text("**Email**: \(email)")
                            Text("**Phone number**: \(number)")
                        }
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
            }.refreshable {
                store.getProfile(id: idnum)
            }
            .onAppear {
                store.getProfile(id: idnum)
            }
    }
}
//
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
