//
//  ContentView.swift
//  PortfolioApp
//
//  Created by Ryan Lovallo on 3/14/22.
//

import SwiftUI

struct OtherUserView: View {
    @ObservedObject var store = ProfileStore.shared
    
    
    @State var idnum : String
    @State private var isLiked: String = ""
    var body: some View {
        
        
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                
                let _ = print("uh")
//                let _ = print(store.prof)
                
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
                
                Group {
                    Text(username).bold().font(.largeTitle)
                    // REPLACE rylo96 with "profile.username" when the time comes

                    Divider()
                    Text("**Location:** \(loc)")
                    Text("**Industry:** \(industry)")
                    Text("**Job title:** \(jobtitle)")
                    
                    if(isLiked == "0") {
                        Button(action: {
                            store.postLike(store.prof.userID ?? "")
                            isLiked = "1"
                        }) { Text("Like")
                            
                        }.padding().border(Color.black)
                    }
                    else if(isLiked == "1") {
                        Button(action: {
                            store.postUnlike(store.prof.userID ?? "")
                            isLiked = "0"
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
        }.refreshable {
            store.getProfile(id: idnum)
            self.isLiked = store.prof.liked ?? "error"
        }
        .onAppear {
            store.getProfile(id: idnum)
            self.isLiked = store.prof.liked ?? "error"
        }
    }
}
