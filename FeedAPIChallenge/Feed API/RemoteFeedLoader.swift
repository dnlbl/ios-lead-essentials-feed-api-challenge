//
//  Copyright © 2018 Essential Developer. All rights reserved.
//

import Foundation

public final class RemoteFeedLoader: FeedLoader {
	private let url: URL
	private let client: HTTPClient
	
	public enum Error: Swift.Error {
		case connectivity
		case invalidData
	}
		
	public init(url: URL, client: HTTPClient) {
		self.url = url
		self.client = client
	}
	
	public func load(completion: @escaping (FeedLoader.Result) -> Void) {
        client.get(from: url) { result in
            switch result {
            case .failure:
                completion(.failure(Error.connectivity))
            case let .success(result):
                let (data, resp) = result
                guard resp.statusCode == 200 else { return completion(.failure(Error.invalidData)) }
                guard let _ = try? JSONDecoder().decode(FeedImageResponse.self, from: data) else { return completion(.failure(Error.invalidData)) }
            }
        }
    }
}

public struct FeedImageRemote: Decodable {
    public let id: UUID
    public let description: String?
    public let location: String?
    public let url: URL
    
    init(from model: FeedImage) {
        self.id = model.id
        self.description = model.description
        self.location = model.location
        self.url = model.url
    }
    
    var toFeedImage: FeedImage {
        .init(id: id, description: description, location: location, url: url)
    }
}

public struct FeedImageResponse: Decodable {
    let items: [FeedImageRemote]
}
