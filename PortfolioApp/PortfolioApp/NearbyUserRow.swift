//
//  NearbyUserRow.swift
//  PortfolioApp
//
//  Created by Brendan Carey on 3/15/22.

import SwiftUI
import UIKit
import MultipeerConnectivity

struct NearbyUserRow: View {
    var nearbyUser: MCPeerID
    // @ObservedObject var audioPlayer: AudioPlayer
    @State private var isPresenting = false
    
    
    var body: some View {
        
        NavigationLink(destination: NearbyProfileView(name: nearbyUser.displayName)) {
            VStack(alignment: .leading) {
                HStack {
                    if let name = nearbyUser.displayName {
                        Text(name).padding(EdgeInsets(top: 8, leading: 0, bottom: 6, trailing: 0))
                    }
                    Spacer()
                }
            }
        }
    }
}

