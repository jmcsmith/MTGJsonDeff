//
//  DataBooster.swift
//  MTGJsonDiff
//
//  Created by Joseph Beaudoin on 1/8/25.
//


import Foundation

struct DataBooster: Codable {
    let boosterDefault: Default?
    
    enum CodingKeys: String, CodingKey {
        case boosterDefault = "default"
    }
}
extension DataBooster {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(DataBooster.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        boosterDefault: Default?? = nil
    ) -> DataBooster {
        return DataBooster(
            boosterDefault: boosterDefault ?? self.boosterDefault
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}