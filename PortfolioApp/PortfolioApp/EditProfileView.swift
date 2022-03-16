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
    
    // TODO: CHECK HOW TO DO THIS IN OtherUserView
    @State private var jobtitle = ""
    @State private var age : String = ""
    @State private var gender : String = ""
    @State private var industry : String = ""
    @State private var education : String = ""
    @State private var interests : String = ""
    @State private var bio : String = ""
    @State private var profpic : String = ""
    @State private var loc : String = ""
    
    @State private var dummy : Int = 0
    
    // this is needed for
    init(usrid: String, pimporter: Bool, jt: String, ag: String, gen: String, ind: String, edu: String, intr: String,
            b: String, ppic: String, lc: String) {
        
        self._idnum = State(wrappedValue: usrid)
        self._presentImporter = State(wrappedValue: pimporter)
        self._jobtitle = State(wrappedValue: jt)
        self._age = State(wrappedValue: ag)
        self._gender = State(wrappedValue: gen)
        self._industry = State(wrappedValue: ind)
        self._education = State(wrappedValue: edu)
        self._interests = State(wrappedValue: intr)
        self._bio = State(wrappedValue: b)
        self._profpic = State(wrappedValue: ppic)
        self._loc = State(wrappedValue: lc)
        self._store = ObservedObject(wrappedValue: ProfileStore.shared)
    }

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
                
                Group {
                    Button(action: {
                        // TODO: MAKE A POST REQUEST HERE
                        self.store.editProfile(usrid: idnum, jt: jobtitle, ag: age, gen: gender, ind: industry, edu: education, intr: interests, b: bio, ppic: profpic, lc: loc)
                        self.dummy += 1
                    }) {
                        Text("Submit")
                        .padding(40.0).overlay(
                            RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 2.0)
                                .shadow(color: .green, radius: 10.0)
                        )
                    }
                    Spacer()
                    Spacer()
                }
            }
        }
        .refreshable {
            store.getProfile(id: idnum)
        }
        .onAppear {
            store.getProfile(id: idnum)
        }
        .onChange(of:dummy) { value in
            store.getProfile(id: idnum)
        }
    }
}
