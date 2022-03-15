//
//  ConnectionHandler.swift
//  PortfolioApp
//
//  Created by Christian DeVivo on 3/14/22.
//

import Foundation
import MultipeerConnectivity

class ConnectionHandler: NSObject, ObservableObject {
    private let myPeerId = MCPeerID(displayName: "Dewey")
    private let session: MCSession
    @Published var availableUsers: [MCPeerID] = []
    
    override init(){
        session = MCSession(
          peer: myPeerId,
          securityIdentity: nil,
          encryptionPreference:  MCEncryptionPreference.none)
        super.init()
        nearbyServiceAdvertiser.delegate = self
    }
    
    private var nearbyServiceBrowser = MCNearbyServiceBrowser(
      peer: MCPeerID(displayName: "Dewey"),
      serviceType: "Portfolio")
    
    private var nearbyServiceAdvertiser = MCNearbyServiceAdvertiser(
        peer: MCPeerID(displayName: "Dewey"),
      discoveryInfo: nil,
      serviceType: "Porfolio")
    
    func startBrowsing() {
      nearbyServiceBrowser.startBrowsingForPeers()
    }

    func stopBrowsing() {
      nearbyServiceBrowser.stopBrowsingForPeers()
    }
    
    var isAdvertising: Bool = false {
      didSet {
        if isAdvertising {
          nearbyServiceAdvertiser.startAdvertisingPeer()
          print("Started advertising")
        } else {
          nearbyServiceAdvertiser.stopAdvertisingPeer()
          print("Stopped advertising")
        }
      }
    }
}

extension ConnectionHandler: MCNearbyServiceAdvertiserDelegate
{
    //This function will be called when an invitation is received, which should never happen for our app
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {

    }
}

extension ConnectionHandler: MCNearbyServiceBrowserDelegate {
    //This function is called when a nearby user is found, so we add them to our list.
    //This is the important one that will have to send shit to the backend I think.
    //I think we should just have a View object that has access to this list, and the view can get profile info from the backend before displaying it. Could also have a separate handler that references this list and does that instead
  func browser(
    _ browser: MCNearbyServiceBrowser,
    foundPeer peerID: MCPeerID,
    withDiscoveryInfo info: [String: String]?
  ) {
    // 1
    if !availableUsers.contains(peerID) {
      availableUsers.append(peerID)
    }
    print("New. User. DETECTED! in ur vicin")
  }
    //This function is called when a user is no longer available I think? not totally important yet
  func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
    guard let index = availableUsers.firstIndex(of: peerID) else { return }
    // 2
    availableUsers.remove(at: index)
  }
}

