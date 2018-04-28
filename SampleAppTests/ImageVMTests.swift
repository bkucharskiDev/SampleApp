//
//  ImageVMTests.swift
//  SampleAppTests
//
//  Created by Bartosz Kucharski on 26.04.2018.
//  Copyright © 2018 Bartosz Kucharski. All rights reserved.
//

import XCTest
@testable import SampleApp

class ImageVMTests: XCTestCase {
    
    let imageViewModel = ImageVM(dependencies: MockedImageVMDependencies(), url: URL(string: "about:blank")!)
    
    func testGetImage() {
        let expectation = XCTestExpectation()
        
        imageViewModel.getImage { _ in
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.1)
    }
    
}

final class MockedImageVMDependencies: ImageVM.Dependencies {
    var imageProvider: ImageProviderProtocol = MockedImageProvider()
}

final class MockedImageProvider: ImageProviderProtocol {
    
    func getImage(url: URL, completion: ((Result<UIImage>) -> Void)) {
        completion(.success(UIImage()))
    }
}
