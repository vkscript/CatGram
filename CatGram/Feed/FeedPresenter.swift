//
//  FeedPresenter.swift
//  CatGram
//

import Foundation

protocol FeedPresenter {
    func didLoad()
    func didSelectPost(id: String)
    func didPullToRefresh()
}

class FeedPresenterImpl: FeedPresenter {

    private weak var view: FeedView?
    private let service: FeedService
    private let router: FeedRouter

    init(
        view: FeedView,
        service: FeedService,
        router: FeedRouter
    ) {
        self.view = view
        self.service = service
        self.router = router
    }

    func didLoad() {
        loadPosts()
    }

    func didPullToRefresh() {
        loadPosts()
    }

    func didSelectPost(id: String) {
        router.openPostDetails(id: id)
    }

    private func loadPosts() {
        view?.render(.loading)

        Task {
            do {
                let posts = try await service.getFeed()
                let state: FeedViewState = posts.isEmpty ? .empty : .content(posts.map(mapPostToViewModel))
                await MainActor.run {
                    view?.render(state)
                }
            } catch let error as NetworkError {
                await MainActor.run {
                    view?.render(.error(message: error.userMessage))
                }
            } catch {
                await MainActor.run {
                    view?.render(.error(message: NetworkError.unknown.userMessage))
                }
            }
        }
    }
    
    private func mapPostToViewModel(post: Post) -> PostViewModel {
        .init(
            id: post.id,
            author: post.author,
            text: post.text,
            likesCount: post.likesCount,
            commentsCount: post.commentsCount,
            createdAtString: post.createdAt.formatted(),
        )
    }
}
