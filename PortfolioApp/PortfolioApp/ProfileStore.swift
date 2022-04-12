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
    @Published private(set) var prof = UserInfo()
    
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
    
    
    func editProfile(usrid: String, jt: String, ag: String, gen: String,
                       ind: String, edu: String, intr: String, b: String,
                     ppic: String, lc: String, ispriv: String) {
        let jsonObj = ["userID": usrid,
                       "employer": jt,
                       "age": ag,
                       "gender": gen,
                       "industry": ind,
                       "education": edu,
                       "location": lc,
                       "interests": intr,
                       "bio": b,
                       "profpic": ppic,
                       "privacyOn": ispriv,
        ]
        
        print("hi")
        print(jsonObj)
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonObj) else {
            print("editProfile: jsonData serialization error")
            return
        }
        // Change here
        guard let apiUrl = URL(string: serverUrl+"editprofile/") else {
            print("editProfile: Bad URL")
            return
        }
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
           guard let _ = data, error == nil else {
               print("editProfile: NETWORKING ERROR")
               return
           }

           if let httpStatus = response as? HTTPURLResponse {
               if httpStatus.statusCode != 200 {
                   print("editProfile: HTTP STATUS: \(httpStatus.statusCode)")
                   return
               } else {
                   // NEEDS UNCOMMENTED
                   // self.getProfile()
               }
           }
       }.resume()
    }
    
    
    func getLikes(id: String, isName: Bool) {
        print(id)
        var is_name = "p"
        if (isName) {
            is_name = "name"
        }
        guard let apiUrl = URL(string: serverUrl+"getlikes"+"?id="+id+"&type="+is_name) else {
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
            
            let profsReceived = jsonObj["users"] as? [[Any]] ?? []
            
            DispatchQueue.main.async {
                self.profiles = [Profile]()
                
                for profEntry in profsReceived {
                    
                    let usrid = String(describing: profEntry[0])
                    let usrname = String(describing: profEntry[1])
                    let nmbr = String(describing: profEntry[2])
                    let prfpic = String(describing: profEntry[3])
                    let eml = String(describing: profEntry[4])
                    let bioos = String(describing: profEntry[5])
                    let indstr = String(describing: profEntry[6])
                    
                    if profEntry.count == self.nFields {
                        self.profiles.append(Profile(userID: usrid, username: usrname, number: nmbr,
                                                     ProfPick: prfpic, email: eml, bio: bioos, industry: indstr))
//                        print(self.profiles)

                    } else {
                        print("getlikes: Received unexpected number of fields: \(profEntry.count) instead of \(self.nFields).")
                    }
                   
                }
            }
            // print(self.profiles)
        }.resume()
    }
    
    func getProfile(id: String) {
        print(id)
        guard let apiUrl = URL(string: serverUrl+"getprofile"+"?id="+id+"&logname=10") else {
            print("getprofile: Bad URL")
            return
        }

        var request = URLRequest(url: apiUrl)
        
        request.httpMethod = "GET"
        // request.httpHeader = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                print("getprofile: NETWORKING ERROR")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("getprofile: HTTP STATUS: \(httpStatus.statusCode)")
                return
            }

            
            guard let jsonObj = try? JSONSerialization.jsonObject(with: data) as? [String : Any] else {
                print("getprofile: failed JSON deserialization")
                return
            }
 
            let profsReceived = jsonObj["user"] as? [Any] ?? []
            
            print("before")
            print(profsReceived)
            print("after")
            print(profsReceived[0])
            print("after")
            
            // let bioos = String(describing: profEntry[5])
            
            self.prof.username = String(describing: profsReceived[0])
            self.prof.number = String(describing: profsReceived[1])
            self.prof.email = String(describing: profsReceived[2])
            self.prof.userID = String(describing: profsReceived[3])
            self.prof.jobtitle = String(describing: profsReceived[4])
            self.prof.age = String(describing: profsReceived[5])
            self.prof.gender = String(describing: profsReceived[6])
            self.prof.industry = String(describing: profsReceived[7])
            self.prof.education = String(describing: profsReceived[8])
            self.prof.interests = String(describing: profsReceived[9])
            self.prof.bio = String(describing: profsReceived[10])
            self.prof.profpic = String(describing: profsReceived[11])
            self.prof.loc = String(describing: profsReceived[12])
            self.prof.isPrivate = String(describing: profsReceived[13])
            self.prof.liked = String(describing: profsReceived[14])
            
            print("Liked value:", self.prof.liked)
            DispatchQueue.main.async {
//                self.prof = profsReceived
                print("XXXXX")
            }
        }.resume()
    }

    func getNearbyProfile(name: String) {

        guard let apiUrl = URL(string: serverUrl+"getNearbyProfile"+"?name="+name+"&logname=Brendan") else {
            print("getprofile: Bad URL")
            return
        }

        var request = URLRequest(url: apiUrl)
        
        request.httpMethod = "GET"
        // request.httpHeader = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                print("getprofile: NETWORKING ERROR")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("getprofile: HTTP STATUS: \(httpStatus.statusCode)")
                return
            }

            
            guard let jsonObj = try? JSONSerialization.jsonObject(with: data) as? [String : Any] else {
                print("getprofile: failed JSON deserialization")
                return
            }
 
            let profsReceived = jsonObj["user"] as? [Any] ?? []
            
            print("before")
            print(profsReceived)
            print("after")
            print(profsReceived[0])
            print("after")
            
            // let bioos = String(describing: profEntry[5])
            
            self.prof.username = String(describing: profsReceived[0])
            self.prof.number = String(describing: profsReceived[1])
            self.prof.email = String(describing: profsReceived[2])
            self.prof.userID = String(describing: profsReceived[3])
            self.prof.jobtitle = String(describing: profsReceived[4])
            self.prof.age = String(describing: profsReceived[5])
            self.prof.gender = String(describing: profsReceived[6])
            self.prof.industry = String(describing: profsReceived[7])
            self.prof.education = String(describing: profsReceived[8])
            self.prof.interests = String(describing: profsReceived[9])
            self.prof.bio = String(describing: profsReceived[10])
            self.prof.profpic = String(describing: profsReceived[11])
            self.prof.loc = String(describing: profsReceived[12])
            self.prof.isPrivate = String(describing: profsReceived[13])
            self.prof.liked = String(describing: profsReceived[14])
            self.prof.score = String(describing: profsReceived[15])
            
            
            print("Liked value:", self.prof.liked)
            DispatchQueue.main.async {
//                self.prof = profsReceived
                print("XXXXX")
            }
        }.resume()
    }
    
    
    
    func postLike(_ targetID: String) {
        let jsonObj = ["user1": "10",
                       "user2": targetID,
                       
        ]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonObj) else {
            print("postLike: jsonData serialization error")
            return
        }
// Change here
        guard let apiUrl = URL(string: serverUrl+"likeprofile/") else {
            print("postLike: Bad URL")
            return
        }
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
                   guard let _ = data, error == nil else {
                       print("postLike: NETWORKING ERROR")
                       return
                   }

                   if let httpStatus = response as? HTTPURLResponse {
                       if httpStatus.statusCode != 200 {
                           print("postLike: HTTP STATUS: \(httpStatus.statusCode)")
                           return
                       } else {
                           // NEEDS UNCOMMENTED
                           // self.getProfile()
                       }
                   }
               }.resume()
        
        
        
    }
    
    
    func postUnlike(_ targetID: String) {
        let jsonObj = ["user1": "10",
                       "user2": targetID,
                       
        ]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonObj) else {
            print("postUnLike: jsonData serialization error")
            return
        }
// Change here
        guard let apiUrl = URL(string: serverUrl+"unlikeprofile/") else {
            print("postUnLike: Bad URL")
            return
        }
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { data, response, error in
                   guard let _ = data, error == nil else {
                       print("postUnLike: NETWORKING ERROR")
                       return
                   }

                   if let httpStatus = response as? HTTPURLResponse {
                       if httpStatus.statusCode != 200 {
                           print("postUnlike: HTTP STATUS: \(httpStatus.statusCode)")
                           return
                       } else {
                           // NEEDS UNCOMMENTED
                           // self.getProfile()
                       }
                   }
               }.resume()
        
        
        
    }
    
    
    // Edit profile
    
    // Get likes
    
    // Post like
    
}

