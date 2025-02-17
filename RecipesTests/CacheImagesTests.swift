//
//  CacheImagesTests.swift
//  RecipesTests
//
//  Created by Josh Sidelsky on 2/17/25.
//

import XCTest

final class CacheImagesTests: XCTestCase {

    func testFetchRecipesSuccess() async throws{
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg")
        let cacheImages = CacheImages.shared
        
        //first call downloads the image
        let downloadedImage = try await cacheImages.image(for: url!)
        XCTAssertNotNil(downloadedImage, "Failed to download valid image")
        
        
        //second call retrieves the image from the cache
        let loadedImage = try await cacheImages.image(for: url!)
        XCTAssertNotNil(downloadedImage, "Failed to load cached image")
        
        //convert to png data to compare
        guard let downloadedData = downloadedImage.pngData(), let loadedData = loadedImage.pngData() else{
            XCTFail("Failed to get png data from images")
            return
        }
        //test whether cached image png data is the same as downloaded image
        XCTAssertEqual(downloadedData, loadedData, "cached image does not mach downloaded image")
    }

}
