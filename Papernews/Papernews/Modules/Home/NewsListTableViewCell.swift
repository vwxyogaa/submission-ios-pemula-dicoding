//
//  NewsListTableViewCell.swift
//  Papernews
//
//  Created by yxgg on 21/04/22.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {
  weak var containerView: UIView!
  weak var newsImageView: UIImageView!
  weak var titleLabel: UILabel!
  weak var dateLabel: UILabel!
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupViews()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  // MARK: - Helpers
  private func setupViews() {
    backgroundColor = .clear
    selectionStyle = .none
    
    let containerView = UIView(frame: .zero)
    contentView.addSubview(containerView)
    self.containerView = containerView
    containerView.layer.cornerRadius = 10
    containerView.layer.masksToBounds = true
    containerView.backgroundColor = UIColor(rgb: 0xF1F1F1)
    containerView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
      containerView.heightAnchor.constraint(equalToConstant: 110)
    ])
    
    let newsImageView = UIImageView(frame: .zero)
    contentView.addSubview(newsImageView)
    self.newsImageView = newsImageView
    newsImageView.layer.cornerRadius = 10
    newsImageView.layer.masksToBounds = true
    newsImageView.contentMode = .scaleAspectFill
    newsImageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      newsImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
      newsImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
      newsImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5),
      newsImageView.heightAnchor.constraint(equalToConstant: 100),
      newsImageView.widthAnchor.constraint(equalToConstant: 100)
    ])
    
    let titleLabel = UILabel(frame: .zero)
    contentView.addSubview(titleLabel)
    self.titleLabel = titleLabel
    titleLabel.textColor = .black
    titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    titleLabel.numberOfLines = 2
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: newsImageView.topAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
      titleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 15)
    ])
    
    let dateLabel = UILabel(frame: .zero)
    contentView.addSubview(dateLabel)
    self.dateLabel = dateLabel
    dateLabel.textColor = UIColor(rgb: 0x9A9A9A)
    dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    dateLabel.numberOfLines = 1
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
      dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5)
    ])
  }
}
