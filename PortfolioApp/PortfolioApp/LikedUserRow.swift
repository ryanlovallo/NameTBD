//
//  LikedUserRow.swift
//  PortfolioApp
//
//  Created by Michael Wang on 3/14/22.
//

import SwiftUI
import UIKit

struct LikedUserRow: View {
    var likedUser: LikedUsers
    // @ObservedObject var audioPlayer: AudioPlayer
    @State private var isPresenting = false
    
    
    var body: some View {
        VStack(alignment: .leading) {

            
            HStack {
                if let name = likedUser.name{
                        Text(name).padding(EdgeInsets(top: 8, leading: 0, bottom: 6, trailing: 0))
                    }
                            Spacer()
// Display image from the URL value in likedUsers
           
            
        }
    }
    
}
}
