//
//  HomeViewController.swift
//  CarrotMarket
//
//  Created by Seungjin Baek on 2021/07/16.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var itemListTableView: UITableView!
    
    private var itemList = [ListedItem]()
    private let networkService = NetworkService(networkManager: NetworkManager(session: MockURLSession(makeRequestFail: false)), dataManager: DataManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemListTableView.dataSource = self
        
        networkService.fetchItemList { result in
            switch result {
            case .success(let model):
                let fetchedData = ItemList(page: model.page, itemList: model.itemList)
                let listedItem = fetchedData.itemList
                self.itemList.append(contentsOf: listedItem)
                DispatchQueue.main.async {
                    self.itemListTableView.reloadData()
                }
            case .failure(_):
                let alert = UIAlertController(title: NetworkAlertMessage.errorTitle.description, message: NetworkAlertMessage.errorMessage.description, preferredStyle: UIAlertController.Style.alert)
                let cancelAction = UIAlertAction(title: NetworkAlertMessage.cancelTitle.description, style: UIAlertAction.Style.cancel)
                alert.addAction(cancelAction)
                self.present(alert, animated: false)
            }
        }
    }
    
}

enum NetworkAlertMessage {
    case errorTitle, errorMessage, cancelTitle
    
    var description: String {
        switch self {
        case .errorTitle:
            return "Error"
        case .errorMessage:
            return "네트워크 에러가 발생했습니다."
        case .cancelTitle:
            return "확인"
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let itemCell = itemListTableView.dequeueReusableCell(withIdentifier: CellIdentifier.itemListCell.identifier, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        
        if let thumbnail = UIImage(named: DefaultImage.itemListThumbnail.fileName) {
            itemCell.itemImage.image = thumbnail
        }
        
        itemCell.customizeCell(with: self.itemList[indexPath.row])
        return itemCell
    }
    
}

enum DefaultImage {
    case itemListThumbnail
    
    var fileName: String {
        switch self {
        case .itemListThumbnail:
            return "당근마켓 아이콘"
        }
    }
}
