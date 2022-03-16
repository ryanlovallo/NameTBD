//
//  ConnectionHandler.swift
//  PortfolioApp
//
//  Created by Christian DeVivo on 3/14/22.
//

//Note to self. Need to change where the ConnectionHandler is initiated, because leaving the page kills it
//going back and forth from the home page in Home View
import Foundation
import MultipeerConnectivity

class ConnectionHandler: NSObject, ObservableObject {
    private var myPeerId: MCPeerID
    private var session: MCSession
    private var nearbyServiceBrowser: MCNearbyServiceBrowser
    private var nearbyServiceAdvertiser: MCNearbyServiceAdvertiser
    
    @Published var availableUsers: [MCPeerID] = []
    override init(){
        self.myPeerId = MCPeerID(displayName: "trash man")
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
        print("Now advertising your profile")
    }
    
    func stopAdvertising()
    {
        nearbyServiceAdvertiser.stopAdvertisingPeer()
        print("Stopped advertising your profile")
    }
    
    var isBrowsing: Bool = false {
      didSet {
        if isBrowsing {
          nearbyServiceBrowser.startBrowsingForPeers()
          print("Started browsing for users")
        } else {
          nearbyServiceBrowser.stopBrowsingForPeers()
          print("Stopped browsing for users")
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
      if(peerID.displayName == self.myPeerId.displayName)
      {
          return
      }
    if !availableUsers.contains(peerID) {
      availableUsers.append(peerID)
    }
    print("New. User. DETECTED! in ur vicin")
    print(myPeerId)
  }
    //This function is called when a user is no longer available I think? not totally important yet
  func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
    guard let index = availableUsers.firstIndex(of: peerID) else { return }
    // 2
    availableUsers.remove(at: index)
  }
    
    func browser(_ browser: MCNearbyServiceBrowser,
    didNotStartBrowsingForPeers error: Error)
    {
        print("Failed to actually browse")
    }
}

