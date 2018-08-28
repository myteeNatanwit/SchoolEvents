

import Foundation
import UIKit
protocol SearchChildDelegate{
    func returnData(_ data: cityInfo)
}

var rawData : [fcwtItem] = [];
var filteredData : [fcwtItem] = [];

struct ResponseData: Decodable {
    let list: [fcwtItem]
    private enum CodingKeys: String, CodingKey {
        case list = "list"
    }
}
/*
 "coord": {
 "lon": 84.633331,
 "lat": 28
 }
 */
struct Latlon: Decodable {
    let lon: Float
    let lat: Float
}

struct fcwtItem : Decodable {
    let id: Int
    let name: String
    let country: String
    let latlon: Latlon
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case country = "country"
        case latlon = "coord"
    }
}

func loadJson(filename fileName: String) -> [fcwtItem]? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(ResponseData.self, from: data);
            filteredData = jsonData.list.filter({rawData -> Bool in
                rawData.country == "AU"
            })
            //return jsonData.list
            return filteredData;
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}

