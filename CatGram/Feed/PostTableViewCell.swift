//
//  PostTableViewCell.swift
//  CatGram
//

import UIKit

final class PostTableViewCell: UITableViewCell {
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .label
        return label
    }()
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray6
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray
        return label
    }()
    
    private let commentsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .systemGray2
        return label
    }()
    
    private var imageLoadTask: URLSessionDataTask?
    private var currentImageUrl: URL?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Отменяем загрузку изображения при переиспользовании
        imageLoadTask?.cancel()
        postImageView.image = nil
        currentImageUrl = nil
    }
    
    private func setupUI() {
        contentView.backgroundColor = .systemBackground
        
        [authorLabel, postImageView, captionLabel, likesLabel, commentsLabel, dateLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: 300),
            
            captionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 8),
            captionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            captionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            likesLabel.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 8),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            commentsLabel.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: 8),
            commentsLabel.leadingAnchor.constraint(equalTo: likesLabel.trailingAnchor, constant: 16),
            
            dateLabel.topAnchor.constraint(equalTo: likesLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with viewModel: PostViewModel) {
        authorLabel.text = viewModel.author
        captionLabel.text = viewModel.text
        likesLabel.text = "❤️ \(viewModel.likesCount)"
        commentsLabel.text = "💬 \(viewModel.commentsCount)"
        dateLabel.text = viewModel.createdAtString
        
        // Загрузка изображения с кешированием
        if let imageUrl = viewModel.imageUrl {
            currentImageUrl = imageUrl
            loadImage(from: imageUrl)
        } else {
            postImageView.image = nil
            currentImageUrl = nil
        }
    }
    
    private func loadImage(from url: URL) {
        // Проверяем кеш
        if let cachedImage = ImageCache.shared.image(for: url) {
            postImageView.image = cachedImage
            return
        }
        
        // Загружаем изображение асинхронно
        imageLoadTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  let data = data,
                  let image = UIImage(data: data),
                  error == nil else {
                return
            }
            
            // Сохраняем в кеш
            ImageCache.shared.setImage(image, for: url)
            
            DispatchQueue.main.async {
                // Проверяем, что ячейка все еще отображает тот же URL
                if self.currentImageUrl == url {
                    self.postImageView.image = image
                }
            }
        }
        imageLoadTask?.resume()
    }
}
