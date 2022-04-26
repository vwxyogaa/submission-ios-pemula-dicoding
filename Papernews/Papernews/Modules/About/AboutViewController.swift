//
//  AboutViewController.swift
//  Papernews
//
//  Created by yxgg on 21/04/22.
//

import UIKit

class AboutViewController: UIViewController {
  weak var imageView: UIImageView!
  weak var nameLabel: UILabel!
  weak var emailLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
  
  // MARK: - Helpers
  private func setupViews() {
    view.backgroundColor = .white
    title = "About"
    navigationItem.largeTitleDisplayMode = .never
    
    let imageView = UIImageView(frame: .zero)
    view.addSubview(imageView)
    self.imageView = imageView
    imageView.backgroundColor = .black
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 100
    imageView.layer.masksToBounds = true
    imageView.layer.borderWidth = 1
    imageView.layer.borderColor = UIColor.black.cgColor
    imageView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
      imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      imageView.heightAnchor.constraint(equalToConstant: 200),
      imageView.widthAnchor.constraint(equalToConstant: 200)
    ])
    
    let nameLabel = UILabel(frame: .zero)
    view.addSubview(nameLabel)
    self.nameLabel = nameLabel
    nameLabel.text = "yxgg"
    nameLabel.textColor = .black
    nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    nameLabel.textAlignment = .center
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16)
    ])
    
    let emailLabel = UILabel(frame: .zero)
    view.addSubview(emailLabel)
    self.emailLabel = emailLabel
    emailLabel.text = "email@mail.com"
    emailLabel.textColor = .black
    emailLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    emailLabel.textAlignment = .center
    emailLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
      emailLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -24)
    ])
  }
}
