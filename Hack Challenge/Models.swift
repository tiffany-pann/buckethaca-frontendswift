//
//  Models.swift
//  Hack Challenge
//
//  Created by Tiffany Pan on 4/29/22.
//

import UIKit

struct User: Codable {
    let id: Int
    let name: String
    let email: String
}

struct EventsResponse: Codable {
    let events: [Event]
}

struct savedEventsResponse: Codable {
    let savedEvents: [Event]
}
//struct EventResponse: Codable {
//    let event: Event
//}

struct Event: Codable {
    let id: Int
    let title: String
    let hostName: String
    let date: Int
    let location: String
    var description: String
    let categories: String // TODO: What if I just hard code this part and make allCategories a list of strings of categories?
    // Image URL
    let type: String
    let image: String
}

let allCategories: [String] = ["Academic", "Indoors", "Libaries", "Outdoors", "Clubs", "Sports"]

struct Image: Codable {
    let url: String?
    let createdAt: String
}
//struct Category: Codable, Equatable {
//    let id: Int
//    let description: String
//}

//let allCategories: [Category] = [
//    Category(id: 1, description: "Outdoors"),
//    Category(id: 2, description: "Academic"),
//    Category(id: 3, description: "Indoors"),
//    Category(id: 4, description: "Festive")
//]

struct Bucket: Codable {
    let id: Int
    let description: String
}

struct BucketwithStatus {
    let bucketItem: Bucket
    let status: Bool
}

struct BucketsResponse: Codable {
    let buckets: [Bucket]
}

enum bookmarkType: CaseIterable, Equatable {
    case bucketlist
    case event
    
    var description: String {
        switch self {
        case .event: return "Events"
        case .bucketlist: return "Bucketlist"
        }
    }
}



// convert UNIX time into a presentable string
func convertUnixToString(date: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(date))
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "EST") //Set timezone that you want
    dateFormatter.locale = NSLocale.current
    dateFormatter.dateFormat = "EEEE, MMM d h:mm a" //Specify your format that you want
    let strDate = dateFormatter.string(from: date)
    
    return strDate
}

func convertStringtoUnix(dateInput: String) -> Int {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM dd yyyy                h:mm a"
    let dateString = dateFormatter.date(from: dateInput)
    let dateTimeStamp  = dateString!.timeIntervalSince1970
    let dateSt:Int = Int(dateTimeStamp)
    
    return dateSt
}

var allBucketswithStatus: [BucketwithStatus] = [
    BucketwithStatus(bucketItem:  Bucket(id: 1, description: "Attend Slope Day!"), status: true),
    BucketwithStatus(bucketItem: Bucket(id: 2, description: "Go to the Cornell-Harvard men’s hockey game and throw fish on the ice"), status: false),
    BucketwithStatus(bucketItem: Bucket(id: 3, description: "Take off to NYC for Fall Break, being sure to post on Instagram about it at least twice"), status: true),
    BucketwithStatus(bucketItem:  Bucket(id: 4, description: "Sled down Libe Slope during a snowstorm"), status: true),
    BucketwithStatus(bucketItem:  Bucket(id: 5, description: "Take Hotel Administration 4300: Introduction to Wines"), status: false),
    BucketwithStatus(bucketItem: Bucket(id: 6, description: "Enroll in BIOEE 1540: Introductory Oceanography as a joke, then fall in love with Bruce Monger and attend every class"), status: false),
    BucketwithStatus(bucketItem: Bucket(id: 7, description: "Order ice cream at the Dairy Bar"), status: true),
    BucketwithStatus(bucketItem: Bucket(id: 8, description: "Climb the rock wall in Bartels Hall"), status: false),
    BucketwithStatus(bucketItem: Bucket(id: 9, description: "Listen to a full chimes concert from the clock tower and guess the songs played"), status: false),
    BucketwithStatus(bucketItem: Bucket(id: 10, description: "Register for classes during Freshman Pre-Enroll, then switch out of every single one by the time Add/Drop ends"), status: false),
    BucketwithStatus(bucketItem: Bucket(id: 11, description: "Wear flip-flops to class in January"), status: false),
    BucketwithStatus(bucketItem: Bucket(id: 12, description: "Skip class to play frisbee on the Arts Quad"), status: true)
    
]

