//
//  ProximityView.swift
//  PortfolioApp
//
//  Created by Brendan Carey on 3/15/22.
//

import SwiftUI

struct ProximityView: View {
    @Binding var proximityViewType: String
    @ObservedObject var connec = ConnectionHandler()
    
    
    var body: some View {
        Toggle("Activate Proximity", isOn: $connec.isBrowsing)
        NavigationView {
            
            List {
                ForEach(connec.availableUsers, id: \.self) { rw in
                    NearbyUserRow(nearbyUser: rw)
                }
            }
            .refreshable {
                connec.availableUsers    // 10 should be the user of the device's ID
            }
            .onAppear {
                connec.availableUsers   // 10 should be the user of the device's ID
            }

        }
        
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    
                    ZStack {
                        Button(action: {
                            self.proximityViewType = "home"
                        }) {
                            Text("Home")
                        }
                    }
                    
                    ZStack {
                        Button(action: {
                            self.proximityViewType = "likedusers"
                        }) {
                            Text("Liked Users")
                        }
                    }
                    
                    ZStack {
                        Button(action: {
                            self.proximityViewType = "profile"
                        }) {
                            Text("Profile")
                        }
                    }

                }
            }
    }
    
}
