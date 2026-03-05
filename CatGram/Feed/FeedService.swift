//
//  FeedService.swift
//  CatGram
//

protocol FeedService {
    func getFeed() async throws -> [Post]
}
