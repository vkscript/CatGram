//
//  PostDetailsService.swift
//  CatGram
//

protocol PostDetailsService {
    func getPostDetails(id: String) async throws -> PostDetails
    func toggleLike(id: String) async throws -> Post
    func addComment(postId: String, text: String) async throws -> Comment
}
