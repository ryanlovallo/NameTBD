//
//  ProximityView.swift
//  PortfolioApp
//
//  Created by Brendan Carey on 3/15/22.
//

import SwiftUI
import MultipeerConnectivity

struct ProximityView: View {
    @Binding var proximityViewType: String
    @ObservedObject var connec = ConnectionHandler()
    
    @State private var searchText = ""
    
    var body: some View {
        Toggle("Activate Proximity", isOn: $connec.isBrowsing)
        NavigationView {
            
            List {
                ForEach(searchResults, id: \.self) { rw in
                    NearbyUserRow(nearbyUser: rw)
                }
            }
            .navigationTitle("Nearby Portfolios")
            .searchable(text: $searchText)
            .refreshable {
                connec.availableUsers    // 10 should be the user of the device's ID
            }
            .onAppear {
                connec.availableUsers   // 10 should be the user of the device's ID
            }

        }
        .navigationTitle("Nearby Portfolios")
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
    
    var searchResults: [MCPeerID] {
        if searchText.isEmpty {
            return connec.availableUsers
        } else {
            return connec.availableUsers.filter { ($0.displayName).contains(searchText) }
        }
    }
    
}
