//
//  ConnectionHandler.swift
//  PortfolioApp
//
//  Created by Christian DeVivo on 3/14/22.
//

import Foundation
import MultipeerConnectivity

class ConnectionHandler: NSObject, ObservableObject {
    private var myPeerId: MCPeerID
    private var session: MCSession
    private var nearbyServiceBrowser: MCNearbyServiceBrowser
    private var nearbyServiceAdvertiser: MCNearbyServiceAdvertiser
    
    @Published var availableUsers: [MCPeerID] = []
    override init(){
        self.myPeerId = MCPeerID(displayName: "Christian")
        session = MCSession(
          peer: myPeerId,
          securityIdentity: nil,
          encryptionPreference:  MCEncryptionPreference.none)
        
        nearbyServiceBrowser = MCNearbyServiceBrowser(
            peer: myPeerId,
          serviceType: "Portfolio")
        nearbyServiceAdvertiser = MCNearbyServiceAdvertiser(
            peer: myPeerId,
          discoveryInfo: nil,
          serviceType: "Portfolio")
        
        super.init()
        nearbyServiceAdvertiser.delegate = self
        nearbyServiceBrowser.delegate = self
        
        //Current functionality is that users are always advertising their profile
        startAdvertising()
    }
    
    func startBrowsing() {
      nearbyServiceBrowser.startBrowsingForPeers()
    }

    func stopBrowsing() {
      nearbyServiceBrowser.stopBrowsingForPeers()
    }
    
    func startAdvertising()
    {
        nearbyServiceAdvertiser.startAdvertisingPeer()
    }
    
    func stopAdvertising()
    {
        nearbyServiceAdvertiser.stopAdvertisingPeer()
    }
    
    //Toggle button will set this to true or false, triggering the browser to start or stop
    var isBrowsing: Bool = false {
      didSet {
        if isBrowsing {
          nearbyServiceBrowser.startBrowsingForPeers()
        } else {
          nearbyServiceBrowser.stopBrowsingForPeers()
        }
      }
    }
}

extension ConnectionHandler: MCNearbyServiceAdvertiserDelegate
{
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
    }
}

extension ConnectionHandler: MCNearbyServiceBrowserDelegate {
    //This function is called when a nearby user is found, so we add them to our list of MCPeerIDs.
  func browser(
    _ browser: MCNearbyServiceBrowser,
    foundPeer peerID: MCPeerID,
    withDiscoveryInfo info: [String: String]?
  ) {
      if(peerID.displayName == self.myPeerId.displayName)
      {
          return
      }
    if !availableUsers.contains(peerID) {
      availableUsers.append(peerID)
    }
    print(myPeerId)
  }
    //This function is called when a user is no longer available
  func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
    guard let index = availableUsers.firstIndex(of: peerID) else { return }
    availableUsers.remove(at: index)
  }
    
    func browser(_ browser: MCNearbyServiceBrowser,
    didNotStartBrowsingForPeers error: Error)
    {
        print("Failed to actually browse")
    }
}

