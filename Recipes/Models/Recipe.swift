//
//  Recipe.swift
//  Recipes
//
//  Created by Josh Sidelsky on 2/17/25.
//

import Foundation

struct Recipe: Decodable, Identifiable{
    let id: UUID
    
    let cuisine: String
    let name: String
    let photoUrlLarge: URL?
    let photoUrlSmall: URL?
    let sourceUrl: URL?
    let youtubeUrl: URL?

    //use CodingKey since struct keys do not perfectly match JSON
    enum Keys: String, CodingKey{
        case cuisine, name, photo_url_large, photo_url_small, uuid, source_url, youtube_url
    }
    
    
    init(from decoder: Decoder) throws {
        // create container
        let container = try decoder.container(keyedBy: Keys.self)
            name = try container.decode(String.self, forKey: .name)
            cuisine = try container.decode(String.self, forKey: .cuisine)
            
            let uuidString = try container.decode(String.self, forKey: .uuid)
        //convert uuidString to a UUID object - throw an error if it fails
            guard let uuid = UUID(uuidString: uuidString) else {
                throw DecodingError.dataCorruptedError(
                    forKey: .uuid,
                    in: container,
                    debugDescription: "Invalid UUID"
                )
            }
        //assign the converted UUID to our id property
            self.id = uuid
        //attempt to decode the following links otherwise assign a value of nil since these are not required
            photoUrlLarge = try? container.decode(URL.self, forKey: .photo_url_large)
            photoUrlSmall = try? container.decode(URL.self, forKey: .photo_url_small)
            sourceUrl = try? container.decode(URL.self, forKey: .source_url)
            youtubeUrl = try? container.decode(URL.self, forKey: .youtube_url)
        }
}
