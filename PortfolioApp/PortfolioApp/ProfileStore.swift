//
//  ProfileStore.swift
//  PortfolioApp
//
//  Created by Michael Wang on 3/14/22.
//



// Make a profile data type


import Foundation

final class ProfileStore: ObservableObject {
    static let shared = ProfileStore() // create one instance of the class to be shared
    private init() {}                // and make the constructor private so no other
                                     // instances can be created
   @Published private(set) var profiles = [Profile]()
    private let nFields = Mirror(reflecting: Profile()).children.count

    private let serverUrl = "https://34.71.5.104/"
    
    
    func postProfile(_ profile: Profile, password: String) {
        let jsonObj = ["userID": profile.userID,
                       "password": password,
                       "username": profile.username,
                       "number": profile.number,
                       "profpic": profile.ProfPick,
                       "email": profile.email
        ]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonObj) else {
            print("postChatt: jsonData serialization error")
            return
        }
// Change here
        guard let apiUrl = URL(string: serverUrl+"createuser/") else {
            print("postProfile: Bad URL")
            return
        }
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
                   guard let _ = data, error == nil else {
                       print("postProfile: NETWORKING ERROR")
                       return
                   }

                   if let httpStatus = response as? HTTPURLResponse {
                       if httpStatus.statusCode != 200 {
                           print("postProfile: HTTP STATUS: \(httpStatus.statusCode)")
                           return
                       } else {
                           // NEEDS UNCOMMENTED
                           // self.getProfile()
                       }
                   }
               }.resume()
        
        
        
    }
    
    
    func getLikes(id: String) {
        print(id)
        guard let apiUrl = URL(string: serverUrl+"getlikes"+"?id="+id) else {
            print("getlikes: Bad URL")
            return
        }
        
        
        var request = URLRequest(url: apiUrl)
        
        request.httpMethod = "GET"
        // request.httpHeader = jsonData
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                print("getlikes: NETWORKING ERROR")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("getlikes: HTTP STATUS: \(httpStatus.statusCode)")
                return
            }

            
            guard let jsonObj = try? JSONSerialization.jsonObject(with: data) as? [String : Any] else {
                print("getlikes: failed JSON deserialization")
                return
            }
            print("hi")
            let profsReceived = jsonObj["users"] as? [[Any]] ?? []
            
            DispatchQueue.main.async {
                self.profiles = [Profile]()
                print("XXXXX")
                for profEntry in profsReceived {
                    print(1)
                    
                    let usrid = String(describing: profEntry[0])
                    let usrname = String(describing: profEntry[1])
                    let nmbr = String(describing: profEntry[2])
                    let prfpic = String(describing: profEntry[3])
                    let eml = String(describing: profEntry[4])
                    let bioos = String(describing: profEntry[5])
                    
                    if profEntry.count == self.nFields {
                        self.profiles.append(Profile(userID: usrid, username: usrname, number: nmbr, ProfPick: prfpic, email: eml, bio: bioos))
                        print(self.profiles)

                    } else {
                        print("getlikes: Received unexpected number of fields: \(profEntry.count) instead of \(self.nFields).")
                    }
                   
                }
            }
            // print(self.profiles)
        }.resume()
    }
    
    
    // Edit profile
    
    // Get likes
    
    // Post like
    
}

