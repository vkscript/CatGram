//
//  Comment.swift
//  CatGram
//

import Foundation

struct Comment: Equatable {
    let id: String
    let author: User
    let text: String
    let createdAt: Date
}
