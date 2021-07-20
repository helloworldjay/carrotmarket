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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemListTableView.dataSource = self
        self.itemListTableView.delegate = self
        self.itemList = taskArrayFromAsset()
        
        // Network 작업이 있을 때
        //        let networkManager = NetworkManager()
        //        networkManager.fetchItemList(page: self.currentPage) { result in
        //            switch result {
        //            case .success(let model):
        //                let fetchedItemList = ItemList(page: self.currentPage, itemList: model.itemList)
        //                let listedItem = fetchedItemList.itemList
        //                self.itemList.append(contentsOf: listedItem)
        //                DispatchQueue.main.async {
        //                    self.itemListTableView.reloadData()
        //                }
        //                return
        //            case .failure(let error):
        //                let alert = UIAlertController(title: "Error", message: "네트워크 에러가 발생했습니다.", preferredStyle: UIAlertController.Style.alert)
        //                self.present(alert, animated: false)
        //            }
        
    }
    
    
    private func fetchDataFromLocalFile() -> Data? {
        guard let dataAsset = NSDataAsset.init(name: "carrotJSON") else { return nil }
        return dataAsset.data
    }
    
    private func taskArrayFromAsset() -> [ListedItem] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        
        guard let data = fetchDataFromLocalFile(),
              let model = try? decoder.decode(ItemList.self, from: data) else { return [] }
        
        return model.itemList
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCell = itemListTableView.dequeueReusableCell(withIdentifier: "homeTableViewCell", for: indexPath) as! HomeTableViewCell
        itemCell.itemTitle.text = self.itemList[indexPath.row].title
        itemCell.itemLocation.text = self.itemList[indexPath.row].location
        itemCell.itemPrice.text = decimalWon(value: self.itemList[indexPath.row].price)
        if let chat = self.itemList[indexPath.row].chat {
            itemCell.itemChat.text = "💬" + String(chat)
        } else {
            itemCell.itemChat.text = ""
        }
        if let heart = self.itemList[indexPath.row].heart {
            itemCell.itemHeart.text = "🤍" + String(heart)
        } else {
            itemCell.itemHeart.text = ""
        }
        // TODO: - 현재시간 기준 지난 시간 추가
        DispatchQueue.main.async(execute: {
            itemCell.itemImage.image = self.getThumbnailImage(indexPath.row)
        })
        
        return itemCell
    }
    
    func decimalWon(value: UInt) -> String {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(from: NSNumber(value: value))! + "원"
            
            return result
        }
    
    private func getThumbnailImage(_ index: Int) -> UIImage {
        let listedItem = self.itemList[index]
        let url: URL! = URL(string: listedItem.thumbnails[0])
        let imageData = try! Data(contentsOf: url)
        return UIImage(data:imageData)!
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
}

