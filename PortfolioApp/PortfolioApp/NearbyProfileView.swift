//
//  NearbyProfileView.swift
//  PortfolioApp
//
//  Created by Brendan Carey on 3/16/22.
//

import SwiftUI

struct NearbyProfileView: View {
    @ObservedObject var store = ProfileStore.shared
    
    
    @State var name : String
    @State private var isLiked: String = ""

    
    // @State private var isLiked: Int = 0
    var body: some View {
        
        
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                
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
                let isPriv : String = store.prof.isPrivate ?? "error"
                var Liked : String = store.prof.liked ?? "error"
                let score : String = store.prof.score ?? "error"
                
                
                if (score == "0") {
                    Text("Weak Match")
                        .foregroundColor(.red)
                }
                else if (score == "1") {
                    Text("Fair Match")
                        .foregroundColor(.orange)
                }
                else if (score == "2") {
                    Text("Good Match")
                        .foregroundColor(.yellow)
                }
                else {
                    Text("Strong Match")
                        .foregroundColor(.green)
                }
                if (isPriv == "1") {
                    Text(username).bold().font(.largeTitle)
                    Text("private").italic()
                    
                    Divider()
                    Text("Bio:").bold()

                    Text(bio).padding().border(Color.black)
                    
                } else {
                    
                    Group {
                        Text(username).bold().font(.largeTitle)

                        Divider()
                        Text("**Location:** \(loc)")
                        Text("**Industry:** \(industry)")
                        Text("**Job title:** \(jobtitle)")
                        
                        if(Liked == "0") {
                            Button(action: {
                                store.postLike(store.prof.userID ?? "")
                                Liked = "1"
                                isLiked = "2"
                            }) { Text("Like")
                                
                            }.padding().border(Color.black)
                        }
                        else if(Liked == "1") {
                            Button(action: {
                                store.postUnlike(store.prof.userID ?? "")
                                Liked = "0"
                                isLiked = "5"
                            }) { Text("Unlike")
                                
                            }.padding().border(Color.black)
                        }
                        

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
        }.refreshable {
            store.getNearbyProfile(name: name)
            self.isLiked = store.prof.liked ?? "error"
            
        }
        .onAppear {
            store.getNearbyProfile(name: name)
            self.isLiked = store.prof.liked ?? "error"
        }
        .onChange(of: isLiked) { value in
            store.getNearbyProfile(name: name)
            self.isLiked = store.prof.liked ?? "error"
        }
        
    }
}
