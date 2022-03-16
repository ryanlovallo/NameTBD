//
//  ContentView.swift
//  PortfolioApp
//
//  Created by Ryan Lovallo on 3/14/22.
//

import SwiftUI

struct EditProfileView: View {
    @ObservedObject var store = ProfileStore.shared
    
    @State private var presentImporter = false
    
    @State var idnum : String = "10"      // TODO:  THIS IS THE ID OF THE USER THAT IS OPERATING THE APP
    
//    // @State private var resume = ""
//    @State private var jobtitle = "Consultant"
//    @State private var location = "McLean, VA"
//    @State private var bio = "teehee"
//    @State private var phone = "703-420"
    
    // TODO: CHECK HOW TO DO THIS IN OtherUserView
    @State private var jobtitle : String = "yuri engineer" ?? "error"
    @State private var age : String = "30" ?? "error"
    @State private var gender : String = "male" ?? "error"
    @State private var industry : String = "software" ?? "error"
    @State private var education : String = "flint college" ?? "error"
    @State private var interests : String = "sicing, going OC" ?? "error"
    @State private var bio : String = "just tryna find a group of friends I can vibe with on a chill level" ?? "error"
    @State private var profpic : String = "idk" ?? "error"
    @State private var loc : String = "yellow house" ?? "error"
    
//    // TODO: CHECK HOW TO DO THIS IN OtherUserView
//    @State private var jobtitle : String = store.myprof.jobtitle ?? "error"
//    @State private var age : String = store.myprof.age ?? "error"
//    @State private var gender : String = store.myprof.gender ?? "error"
//    @State private var industry : String = store.myprof.industry ?? "error"
//    @State private var education : String = store.myprof.education ?? "error"
//    @State private var interests : String = store.myprof.interests ?? "error"
//    @State private var bio : String = store.myprof.bio ?? "error"
//    @State private var profpic : String = store.myprof.profpic ?? "error"
//    @State private var loc : String = store.myprof.loc ?? "error"
//
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 5) {
                Text("Edit Profile").bold().font(.largeTitle)
                Group {
                    Divider()
                    Text("Upload Resume (PDF Only):").bold()
                    
                    Button("Upload") {
                        presentImporter = true
                    }.fileImporter(isPresented: $presentImporter, allowedContentTypes: [.pdf]) {
                        result in
                        switch result {
                        case.success(let url):
                            print(url)
                        case.failure(let error):
                            print(error)
                        }
                    }.padding()
                }
                
                Group {
                    Divider()
                    Text("Edit bio:").bold()
                    TextField("\(bio)", text: $bio).border(Color.black).padding()
                }
                Group {
                    Divider()
                    Text("Edit age:").bold()
                    TextField("\(age)", text: $age).border(Color.black).padding()
                }
                Group {
                    Divider()
                    Text("Edit gender:").bold()
                    TextField("\(gender)", text: $gender).border(Color.black).padding()
                }
                Group {
                    Divider()
                    Text("Edit location:").bold()
                    TextField("\(loc)", text: $loc).border(Color.black).padding()
                }
                Group {
                    Divider()
                    Text("Edit industry:").bold()
                    TextField("\(industry)", text: $industry).border(Color.black).padding()
                }

                Group {
                    Divider()
                    Text("Edit jobtitle:").bold()
                    TextField("\(jobtitle)", text: $jobtitle).border(Color.black).padding()
                }
                Group {
                    Divider()
                    Text("Edit education:").bold()
                    TextField("\(education)", text: $education).border(Color.black).padding()
                    Divider()
                    Text("Edit interests:").bold()
                    TextField("\(interests)", text: $interests).border(Color.black).padding()
                    Divider()
                    Spacer()
                }
                
                
                Button(action: {
                    // TODO: MAKE A POST REQUEST HERE
                    print("Make a post call to update the user's information")
                }) {
                    Text("Submit")
                    .padding(10.0).overlay(
                        RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 2.0)
                            .shadow(color: .green, radius: 10.0)
                    )
                }

            }
        }
//        .refreshable {
//            store.getProfile(id: idnum)
//        }
//        .onAppear {
//            store.getProfile(id: idnum)
//        }
    }
}
