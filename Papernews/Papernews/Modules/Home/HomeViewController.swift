//
//  HomeViewController.swift
//  Papernews
//
//  Created by yxgg on 21/04/22.
//

import UIKit

class HomeViewController: UIViewController {
  weak var tableView: UITableView!
  weak var activityIndicator: UIActivityIndicatorView!
  
  var topNews: [ArticlesNews] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    loadTopNews()
  }
  
  // MARK: - Helpers
  private func setupViews() {
    view.backgroundColor = .white
    title = "Papernews"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    let aboutButton = UIBarButtonItem(
      image: UIImage(named: "profileButton")?.withRenderingMode(.alwaysOriginal),
      style: .plain,
      target: self,
      action: #selector(self.aboutButtonTapped(_:))
    )
    navigationItem.rightBarButtonItem = aboutButton
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.separatorStyle = .none
    view.addSubview(tableView)
    self.tableView = tableView
    tableView.backgroundColor = .clear
    tableView.showsVerticalScrollIndicator = false
    tableView.showsHorizontalScrollIndicator = false
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
    tableView.register(NewsListTableViewCell.self, forCellReuseIdentifier: "newsListCellId")
    tableView.dataSource = self
    tableView.delegate = self
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    view.addSubview(activityIndicator)
    self.activityIndicator = activityIndicator
    activityIndicator.hidesWhenStopped = true
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
  
  private func loadTopNews() {
    activityIndicator.startAnimating()
    NewsProvider.shared.loadTopNews { result in
      switch result {
      case .success(let news):
        self.topNews = news
        self.activityIndicator.stopAnimating()
        self.tableView.reloadData()
      case .failure(let error):
        print("Error load top news \(error.localizedDescription)")
      }
    }
  }
  
  // MARK: - Actions
  @objc private func aboutButtonTapped(_ sender: Any) {
    let viewController = AboutViewController()
    navigationController?.pushViewController(viewController, animated: true)
  }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return topNews.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsListCellId", for: indexPath) as? NewsListTableViewCell else { return UITableViewCell() }
    let news = topNews[indexPath.row]
    let urlString = news.urlToImage
    cell.newsImageView.kf.setImage(with: URL(string: urlString))
    cell.titleLabel.text = news.title
    cell.dateLabel.text = news.publishedAt.string(format: "MMMM dd, yyyy h:mm a")
    return cell
  }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let viewController = DetailViewController()
    viewController.newsDetail = topNews[indexPath.row]
    self.navigationController?.pushViewController(viewController, animated: true)
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = UIView(frame: .zero)
    view.backgroundColor = .clear
    
    let label = UILabel(frame: .zero)
    label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    label.textColor = .black
    label.text = "Top \(topNews.count) News Today"
    view.addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
      label.topAnchor.constraint(equalTo: view.topAnchor),
      label.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    return view
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.0001
  }
}
