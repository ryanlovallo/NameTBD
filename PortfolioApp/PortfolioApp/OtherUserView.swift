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
                    Text("**Job title:** \(jobtitle)")
                    Text("**Location:** \(loc)")

                    Divider()
                    Text("Bio").bold()

                    Text(bio).padding().border(Color.black)
                    Divider()
                    Group {
                        Text("Contact Information").bold().font(.title)
                        Text("**Phone number**: \(number)")
                        Text("**Email**: \(email)")
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
