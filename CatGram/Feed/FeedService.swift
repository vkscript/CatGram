//
//  FeedService.swift
//  CatGram
//

import Foundation

protocol FeedService {
    func getFeed() async throws -> [Post]
}

final class FeedServiceImpl: FeedService {
    private let endpoint = URL(string: "https://alfaitmo.ru/server/echo/371385/feed")!
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func getFeed() async throws -> [Post] {
        let apiPosts: [APIPost] = try await networkClient.get(endpoint)
        return apiPosts.map(mapToDomain)
    }

    private func mapToDomain(_ apiPost: APIPost) -> Post {
        Post(
            id: apiPost.id,
            author: apiPost.authorName,
            imageUrl: apiPost.imageUrl,
            text: apiPost.text,
            likesCount: apiPost.likesCount,
            commentsCount: apiPost.commentsCount,
            createdAt: apiPost.createdAt
        )
    }
}
