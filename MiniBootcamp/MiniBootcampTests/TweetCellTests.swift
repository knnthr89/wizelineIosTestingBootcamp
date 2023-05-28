//
//  TweetCellTests.swift
//  MiniBootcampTests
//
//  Created by Fernando de la Rosa on 17/05/23.
//

import XCTest
@testable import MiniBootcamp

final class TweetCellTests: XCTestCase {
    func test_createTweetCell() {
        let sut = TweetCell()
        
        XCTAssertEqual(sut.backgroundColor, .systemBackground)
    }
    
    func test_configureCellInformation() {
        let sut = TweetCell()
        let expectedViewModel = TweetCellViewModel(
            text: "This is an example",
            favoriteCount: 100,
            retweetCount: 10,
            user : TweetUser(name : "Wizeboot", screenName: "@wizeboot")
    )
        
        sut.viewModel = expectedViewModel
        
        XCTAssertEqual(sut.nameLabel.text, expectedViewModel.user.name)
        XCTAssertEqual(sut.usernameLabel.text, expectedViewModel.user.screenName)
        XCTAssertEqual(sut.contentLabel.text, expectedViewModel.text)
        XCTAssertEqual(sut.userImageView.image, UIImage(named: "cat"))
    }
}

