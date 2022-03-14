//
//  ContentView.swift
//  PortfolioApp
//
//  Created by Ryan Lovallo on 3/14/22.
//

import SwiftUI

struct OtherUserView: View {
    
    
    var username = "OtherUser69"
    var jobtitle = "pianist"
    var loc = "Still club space, miami"
    var bio = "A guy with no shoulders/ muscle mass. Squids often think they are much larger than they are. They over compensate with tough talk and swinging arms. Their appearance is like that of a squid, due to their small frame and comparatively long limbs."
    
    var number = "69-6969-69"
    var email = "otheruser69@gmail.com"
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
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
        }
    }
}
