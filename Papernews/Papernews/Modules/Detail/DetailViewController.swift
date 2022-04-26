//
//  DetailViewController.swift
//  Papernews
//
//  Created by yxgg on 21/04/22.
//

import UIKit
import Kingfisher
import SafariServices

class DetailViewController: UIViewController {
  weak var scrollView: UIScrollView!
  weak var imageView: UIImageView!
  weak var titleLabel: UILabel!
  weak var subtitleLabel: UILabel!
  weak var descriptionLabel: UILabel!
  weak var loadMoreButton: UIButton!
  weak var activityIndicator: UIActivityIndicatorView!
  
  var news: [ArticlesNews]?
  var newsDetail: ArticlesNews?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    loadNewsDetail()
  }
  
  // MARK: - Helpers
  private func setupViews() {
    view.backgroundColor = .white
    title = "Detail"
    navigationItem.largeTitleDisplayMode = .never
    
    let scrollView = UIScrollView(frame: .zero)
    view.addSubview(scrollView)
    self.scrollView = scrollView
    scrollView.showsVerticalScrollIndicator = false
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    let contentView = UIView(frame: .zero)
    scrollView.addSubview(contentView)
    contentView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
    ])
    
    let imageView = UIImageView(frame: .zero)
    contentView.addSubview(imageView)
    self.imageView = imageView
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 20
    imageView.layer.masksToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1)
    ])
    
    let titleLabel = UILabel(frame: .zero)
    contentView.addSubview(titleLabel)
    self.titleLabel = titleLabel
    titleLabel.textColor = .black
    titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    titleLabel.numberOfLines = 0
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16)
    ])
    
    let subtitleLabel = UILabel(frame: .zero)
    contentView.addSubview(subtitleLabel)
    self.subtitleLabel = subtitleLabel
    subtitleLabel.textColor = UIColor(rgb: 0x9A9A9A)
    subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
    ])
    
    let descriptionLabel = UILabel(frame: .zero)
    contentView.addSubview(descriptionLabel)
    self.descriptionLabel = descriptionLabel
    descriptionLabel.textColor = .black
    descriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    descriptionLabel.numberOfLines = 0
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      descriptionLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16)
    ])
    
    let loadMoreButton = UIButton(type: .system)
    contentView.addSubview(loadMoreButton)
    self.loadMoreButton = loadMoreButton
    loadMoreButton.setTitle("Load More", for: .normal)
    loadMoreButton.setTitleColor(.white, for: .normal)
    loadMoreButton.layer.cornerRadius = 10
    loadMoreButton.layer.masksToBounds = true
    loadMoreButton.backgroundColor = UIColor(rgb: 0x84A6FF)
    loadMoreButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      loadMoreButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      loadMoreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      loadMoreButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
      loadMoreButton.heightAnchor.constraint(equalToConstant: 52),
      loadMoreButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
    ])
    loadMoreButton.addTarget(self, action: #selector(self.loadMoreButtonTapped(_:)), for: .touchUpInside)
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    view.addSubview(activityIndicator)
    self.activityIndicator = activityIndicator
    activityIndicator.hidesWhenStopped = true
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
  
  private func loadNewsDetail() {
    activityIndicator.startAnimating()
    loadMoreButton.isHidden = true
    NewsProvider.shared.loadTopNews { result in
      switch result {
      case .success(let detail):
        self.news = detail
        self.activityIndicator.stopAnimating()
        self.loadMoreButton.isHidden = false
        if let result = self.newsDetail {
          let urlString = result.urlToImage
          self.imageView.kf.setImage(with: URL(string: urlString))
          self.titleLabel.text = result.title
          self.subtitleLabel.text = [result.publishedAt.string(format: "MMMM dd, yyyy h:mm a"), result.source?.name ?? ""].joined(separator: " • ")
          self.descriptionLabel.text = result.description
        }
      case .failure(let error):
        print("error \(error.localizedDescription)")
      }
    }
  }
  
  // MARK: - Actions
  @objc private func loadMoreButtonTapped(_ sender: Any) {
    if let url = URL(string: newsDetail?.url ?? "") {
      let viewController = SFSafariViewController(url: url)
      present(viewController, animated: true, completion: nil)
    }
  }
}
