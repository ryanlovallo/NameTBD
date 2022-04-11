//
//  LikedUserRow.swift
//  PortfolioApp
//
//  Created by Michael Wang on 3/14/22.
//

import SwiftUI
import UIKit

struct LikedUserRow: View {
    var likedUser: Profile
    // @ObservedObject var audioPlayer: AudioPlayer
    @State private var isPresenting = false
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            NavigationLink(destination: OtherUserView(idnum: likedUser.userID!)) {
                HStack {
                    let industry = likedUser.industry
                    if let name = likedUser.username {
                        Text(name).padding(EdgeInsets(top: 8, leading: 0, bottom: 6, trailing: 0))
                        Text(industry!).font(.system(size: 14.0)).fontWeight(.light).padding(EdgeInsets(top: 8, leading: 2, bottom: 6, trailing: 0))
                    }
                    Spacer()
    
                }
            }
            
//            }
        }
        
    }
}
