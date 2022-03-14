//
//  ContentView.swift
//  PortfolioApp
//
//  Created by Ryan Lovallo on 3/14/22.
//

import SwiftUI

struct EditProfileView: View {

    
    // @State private var resume = ""
    @State private var jobtitle = "Consultant"
    @State private var location = "McLean, VA"
    @State private var bio = "teehee"
    @State private var phone = "703-420"
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 5) {
                Group {
                    Text("Edit Profile").bold().font(.largeTitle)
                    Group {
                        Divider()
                        Text("Upload resume: [need to figure out]")
                    }
                    
                    

                    Group {
                        Divider()
                        Text("Edit Jobtitle:").bold()
                        TextField("\(jobtitle)", text: $jobtitle).border(Color.black).padding()
                    }
                    
                    Group {
                        Divider()
                        Text("Edit location:").bold()
                        TextField("\(location)", text: $location).border(Color.black).padding()
                    }
                    Group {
                        Divider()
                        Text("Edit bio:").bold()
                        TextField("\(bio)", text: $bio).border(Color.black).padding()
                    }
                    Group {
                        Divider()
                        Text("Edit phone number:").bold()
                        TextField("\(phone)", text: $phone).border(Color.black).padding()
                    }
                    
//                    Text("Edit Profile").bold().font(.title)
//                    Text("**Phone number**: 571-4390-390")
//                    Text("**Email**: hi@gmail")
//                    Text("**Phone number**: \(number)")
//                    Text("**Email**: \(email)")
                }

            }
        }
    }
}
