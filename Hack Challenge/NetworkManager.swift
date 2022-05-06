//
//  NetworkManager.swift
//  Hack Challenge
//
//  Created by Tiffany Pan on 5/3/22.
//

import Foundation
import Alamofire

class NetworkManager {
    static let host: String = "http://34.124.124.62"
    
    static func sendToken(token: String, completion: @escaping (User) -> Void) {
        let endpoint = "\(host)/api/login/"
        let params = [
            "token": token
        ]
        
        AF.request(endpoint, method: .post,parameters: params,encoding: JSONEncoding.default).validate().responseData { response in
                switch (response.result) {
                case .success(let data):
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    if let eventResponse = try? jsonDecoder.decode(User.self, from: data) {
                        completion(eventResponse)
                    } else {
                        print("Failed to decode sendToken")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }

            }
    }

    
    static func getAllEvents(completion: @escaping (EventsResponse) -> Void) {
        let endpoint = "\(host)/api/events/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch (response.result) {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .iso8601
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let eventsResponse = try? jsonDecoder.decode(EventsResponse.self, from: data) {
                    completion(eventsResponse)
                } else {
                    print("Failed to decode getAllEvents")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func searchEvents(eventName: String, completion: @escaping (EventsResponse) -> Void) {
        let endpoint = "\(host)/api/event/\(eventName)/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            debugPrint(response)
            switch (response.result) {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .iso8601
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let eventsResponse = try? jsonDecoder.decode(EventsResponse.self, from: data) {
                    completion(eventsResponse)
                } else {
                    print("Failed to decode getAllBucketlistItems")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getBookmarkedEvents(completion: @escaping (savedEventsResponse) -> Void) {
        let endpoint = "http://34.124.124.62/api/users/1/events/bookmark/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch (response.result) {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .iso8601
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let eventsResponse = try? jsonDecoder.decode(savedEventsResponse.self, from: data) {
                    completion(eventsResponse)
                } else {
                    print("Failed to decode getBookmarkedEvents")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    
    static func postEvent(title: String, hostName: String, date: Int, location: String, description: String, categories: String, image: String, completion: @escaping (Event) -> Void) {
        let endpoint = "\(host)/api/users/1/events/"
        
        let params: [String:Any] = [
            "title": title,
            "host_name": hostName,
            "date": date,
            "location": location,
            "description": description,
            "categories": categories,
            "image_data": image
        ]
        
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
                debugPrint(response)
                switch (response.result) {
                case .success(let data):
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    if let eventResponse = try? jsonDecoder.decode(Event.self, from: data) {
                        completion(eventResponse)
                    } else {
                        print("Failed to decode postEvent")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }

            }
        
    }
    
    static func bookmarkEvent(id: Int, completion: @escaping (savedEventsResponse) -> Void) {
        let endpoint = "\(host)/api/users/1/events/\(id)/bookmark/"
        let params = [
            "id": id
        ]
        
        AF.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default)
            .validate().responseData { response in
                debugPrint(response)
                switch (response.result) {
                case .success(let data):
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    if let eventResponse = try? jsonDecoder.decode(savedEventsResponse.self, from: data) {
                        completion(eventResponse)
                    } else {
                        print("Failed to decode bookmarkEvent")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }

            }
        
    }
    
    

        
    static func getAllBucketlistItemsByUser(completion: @escaping (BucketsResponse) -> Void) {
        let endpoint = ""
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch (response.result) {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .iso8601
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let eventsResponse = try? jsonDecoder.decode(BucketsResponse.self, from: data) {
                    completion(eventsResponse)
                } else {
                    print("Failed to decode getAllBucketlistItems")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
}
