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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemListTableView.dataSource = self
        self.itemListTableView.delegate = self
        self.itemList = taskArrayFromAsset()
        
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
        // TODO: - 3자리 마다 comma 추가
        itemCell.itemPrice.text = String(self.itemList[indexPath.row].price)
        // TODO: - 채팅 이미지 추가
        if let chat = self.itemList[indexPath.row].chat {
            itemCell.itemChat.text = String(chat)
        }
        // TODO: - 하트 이미지 추가
        if let heart = self.itemList[indexPath.row].heart {
            itemCell.itemHeart.text = String(heart)
        }
        // TODO: - 현재시간 기준 지난 시간 추가
        // TODO: - 이미지 추가
        
        
        return itemCell
    }
    
    
}

extension HomeViewController: UITableViewDelegate {
    
}

