//
//  MainViewController.swift
//  CarrotMarket
//
//  Created by Seungjin Baek on 2021/07/16.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var itemListTableView: UITableView!
    
    private var itemList = [ListedItem]()
    private var currentPage: UInt = 1
    private let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemListTableView.dataSource = self
        self.itemList += taskArrayFromAsset()
        
        // Network 작업시
        //                networkManager.fetchItemList(page: self.currentPage) { result in
        //                    switch result {
        //                    case .success(let model):
        //                        let fetchedItemList = ItemList(page: self.currentPage, itemList: model.itemList)
        //                        let listedItem = fetchedItemList.itemList
        //                        self.itemList.append(contentsOf: listedItem)
        //                        DispatchQueue.main.async {
        //                            self.itemListTableView.reloadData()
        //                        }
        //                        return
        //                    case .failure(_):
        //                        let alert = UIAlertController(title: "Error", message: "네트워크 에러가 발생했습니다.", preferredStyle: UIAlertController.Style.alert)
        //                        self.present(alert, animated: false)
        //                    }
        //                }
    }
    
    
    private func fetchDataFromLocalFile() -> Data? {
        guard let dataAsset = NSDataAsset.init(name: "carrotJSON") else { return nil }
        return dataAsset.data
    }
    
    private func taskArrayFromAsset() -> [ListedItem] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        // decoding에 문제가 생겼다는 것은 서버에서 온 데이터 구조가 fit 하지 않다는 것이고 사용자 관점에서는 error로 앱이 꺼지는 것보다 빈 화면이 나오는 것이 낫다고 판단
        guard let data = fetchDataFromLocalFile(),
              let model = try? decoder.decode(ItemList.self, from: data) else { return [] }
        
        return model.itemList
    }
    
    // Network 작업시
    //    override func viewDidLayoutSubviews() {
    //        super.viewDidLayoutSubviews()
    //        itemListTableView.frame = view.bounds
    //        networkManager.fetchItemList(page: currentPage) { [weak self] result in
    //            switch result {
    //            case .success(let data):
    //                self?.itemList += data.itemList
    //                DispatchQueue.main.async {
    //                    self?.itemListTableView.reloadData()
    //                }
    //            case .failure(_):
    //                break
    //            }
    //        }
    //    }
    
    // Network 작업시
    //    private func createSpinnerFooter() -> UIView {
    //        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
    //
    //        let spinner = UIActivityIndicatorView()
    //        spinner.center = footerView.center
    //        footerView.addSubview(spinner)
    //        spinner.startAnimating()
    //
    //        return footerView
    //    }
    
    // Network 작업시
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        let position = scrollView.contentOffset.y
    //
    //        if position > (itemListTableView.contentSize.height - 100 - scrollView.frame.size.height) {
    //
    //            self.itemListTableView.tableFooterView = createSpinnerFooter()
    //            self.currentPage += 1
    //            networkManager.fetchItemList(page: currentPage) { result in
    //                DispatchQueue.main.async {
    //                    self.itemListTableView.tableFooterView = nil
    //                }
    //                switch result {
    //                case .success(let data):
    //                    self.itemList += data.itemList
    //                case .failure:
    //                    break
    //                }
    //            }
    //        }
    //    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let itemCell = itemListTableView.dequeueReusableCell(withIdentifier: "homeTableViewCell", for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        
        if let thumbnail = UIImage(named: "당근마켓 아이콘") {
            itemCell.itemImage.image = thumbnail
        }
        
        itemCell.customizeCell(with: self.itemList[indexPath.row])
        return itemCell
    }
    
}
