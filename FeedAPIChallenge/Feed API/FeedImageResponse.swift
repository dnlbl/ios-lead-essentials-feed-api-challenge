//
//  FeedImageResponse.swift
//  FeedAPIChallenge
//
//  Created by Danil on 9/20/20.
//  Copyright © 2020 Essential Developer Ltd. All rights reserved.
//

import Foundation

public struct FeedImageResponse: Decodable {
    let items: [FeedImageRemote]
}
