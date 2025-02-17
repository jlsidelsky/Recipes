//
//  Untitled.swift
//  Recipes
//
//  Created by Josh Sidelsky on 2/17/25.
//
import Foundation
import UIKit

class CacheImages{
    //initiate static universal CacheImages class
    static let shared = CacheImages()
    private init() {}
    
    func image(for url: URL) async throws -> UIImage {
        //generate path for image
        let filePath = try filePathForImage(url: url)
        
        //check if image is already cached
        if FileManager.default.fileExists(atPath: filePath.path) {
            let data = try Data(contentsOf: filePath)
            // throw error if fail to reconstruct image from cached data
            guard let image = UIImage(data: data) else{
                throw NSError(domain: "ImageCache", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to create image from stored data"])
            }
            return image
        }
        
        //download the image asyncronously if it is not cached
        let(data, _) = try await URLSession.shared.data(from: url)
        //save the data to cache at filePath previously made
        try data.write(to: filePath)
        //create and return image - throw error if fail to construct image from data downloaded from url
        guard let image = UIImage(data: data) else{
            throw NSError(domain: "ImageCache", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to create image from downloaded data"])
        }
        return image
    }
    
    //generates path for image by hashing url
    private func filePathForImage(url: URL) throws -> URL {
        //get the directory of the cache
        let cacheDirectory = try FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create:true)
        
        //create a hash string from the url
        let fileHash = "\(url.absoluteString.hashValue)"
        
        //return cache path + hash string
        return cacheDirectory.appendingPathComponent(fileHash)
    }
}
