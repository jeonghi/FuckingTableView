//
//  ViewController.swift
//  UITableViewSwipe
//
//  Created by 쩡화니 on 2/17/24.
//

import UIKit
import Then

class ViewController: UIViewController {
  
  let tableView = UITableView().then {
    $0.register(
      UITableViewCell.self,
      forCellReuseIdentifier: UITableViewCell.identifier
    )
  }
  
  var users: [User] = [
    "카카오", "네이버", "구글", "라인", "쿠팡", "배민", "당근", "토스"
  ].compactMap({
    User(
      name: $0,
      isFavorite: false,
      isMuted: false
    )
  })

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.do {
      $0.dataSource = self
      $0.delegate = self
    }
    view.addSubview(tableView)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
  }

}

extension ViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    users.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
    let user = users[indexPath.row]
    cell.textLabel?.text = user.name
    return cell
  }
  
  /// 행 수정 허용
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    true
  }
}

extension ViewController: UITableViewDelegate {
  
  @available(iOS, introduced: 11.0)
  func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    nil
  }
  
  @available(iOS, introduced: 11.0)
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    // 지우기
    let trashAction = UIContextualAction(style: .normal, title: "Delete") { action, view, completion in
      
      // 삭제 기능 구현
      print(#function)
      self.users.remove(at: indexPath.row)
      self.tableView.deleteRows(at: [indexPath], with: .fade)
      completion(true)
    }
    trashAction.image = UIImage(systemName: "trash.fill")
    trashAction.backgroundColor = .red
    let configuration = UISwipeActionsConfiguration(actions: [trashAction])
    return configuration
  }
  
  @available(iOS, deprecated: 13.0)
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    nil
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    "빅테크 IT서비스 기업 리스트"
  }
}

@available(iOS 17.0, *)
#Preview {
  ViewController()
}
