//
//  PostTableViewCell.swift
//  CatGram
//

import UIKit

final class PostTableViewCell: UITableViewCell {
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = DS.Colors.background
        view.layer.cornerRadius = DS.Spacing.cornerRadiusMedium
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = DS.Typography.headline()
        label.textColor = DS.Colors.textPrimary
        return label
    }()
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = DS.Colors.secondaryBackground
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = DS.Spacing.cornerRadiusSmall
        return imageView
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = DS.Typography.body()
        label.textColor = DS.Colors.textPrimary
        label.numberOfLines = 0
        return label
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.font = DS.Typography.footnote()
        label.textColor = DS.Colors.textSecondary
        return label
    }()
    
    private let commentsLabel: UILabel = {
        let label = UILabel()
        label.font = DS.Typography.footnote()
        label.textColor = DS.Colors.textSecondary
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = DS.Typography.caption1()
        label.textColor = DS.Colors.textTertiary
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
        imageLoadTask?.cancel()
        postImageView.image = nil
        currentImageUrl = nil
    }
    
    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        [authorLabel, postImageView, captionLabel, likesLabel, commentsLabel, dateLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            cardView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: DS.Spacing.s),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: DS.Spacing.m),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -DS.Spacing.m),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -DS.Spacing.s),
            
            authorLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: DS.Spacing.m),
            authorLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: DS.Spacing.m),
            authorLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -DS.Spacing.m),
            
            postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: DS.Spacing.s),
            postImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: DS.Spacing.m),
            postImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -DS.Spacing.m),
            postImageView.heightAnchor.constraint(equalToConstant: 300),
            
            captionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: DS.Spacing.s),
            captionLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: DS.Spacing.m),
            captionLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -DS.Spacing.m),
            
            likesLabel.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: DS.Spacing.s),
            likesLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: DS.Spacing.m),
            
            commentsLabel.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: DS.Spacing.s),
            commentsLabel.leadingAnchor.constraint(equalTo: likesLabel.trailingAnchor, constant: DS.Spacing.m),
            
            dateLabel.topAnchor.constraint(equalTo: likesLabel.bottomAnchor, constant: DS.Spacing.xs),
            dateLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: DS.Spacing.m),
            dateLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -DS.Spacing.m),
            dateLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -DS.Spacing.m)
        ])
    }
    
    func configure(with viewModel: PostViewModel) {
        authorLabel.text = viewModel.author
        captionLabel.text = viewModel.text
        likesLabel.text = "❤️ \(viewModel.likesCount)"
        commentsLabel.text = "💬 \(viewModel.commentsCount)"
        dateLabel.text = viewModel.createdAtString
        
        if let imageUrl = viewModel.imageUrl {
            currentImageUrl = imageUrl
            loadImage(from: imageUrl)
        } else {
            postImageView.image = nil
            currentImageUrl = nil
        }
    }
    
    private func loadImage(from url: URL) {
        if let cachedImage = ImageCache.shared.image(for: url) {
            postImageView.image = cachedImage
            return
        }
        
        imageLoadTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  let data = data,
                  let image = UIImage(data: data),
                  error == nil else {
                return
            }
            
            ImageCache.shared.setImage(image, for: url)
            
            DispatchQueue.main.async {
                if self.currentImageUrl == url {
                    self.postImageView.image = image
                }
            }
        }
        imageLoadTask?.resume()
    }
}
