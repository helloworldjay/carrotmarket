//
//  MainTableViewCell.swift
//  CarrotMarket
//
//  Created by Seungjin Baek on 2021/07/17.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemLocation: UILabel!
    @IBOutlet weak var itemWrittenTime: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemChat: UILabel!
    @IBOutlet weak var itemHeart: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let thumbnail = UIImage(named: "당근마켓 아이콘") {
            self.itemImage.image = thumbnail
        }
    }
    
    func customizeCell(with item: ListedItem) {
        self.itemTitle.text = item.title
        self.itemLocation.text = item.location
        self.itemPrice.text = decimalWon(value: item.price)
        if let chat = item.chat {
            self.itemChat.text = "💬" + String(chat)
        } else {
            self.itemChat.text = ""
        }
        
        if let heart = item.heart {
            self.itemHeart.text = "🤍" + String(heart)
        } else {
            self.itemHeart.text = ""
        }
        if let thumbnail = self.getThumbnailImage(with: item) {
            DispatchQueue.main.async(execute: {
                self.itemImage.image = thumbnail
            })
        }
    }
    
    private func decimalWon(value: UInt) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: value))! + "원"
        
        return result
    }
    
    private func getThumbnailImage(with item: ListedItem) -> UIImage? {
        guard let url = URL(string: item.thumbnails[0]), let imageData = try? Data(contentsOf: url), let uiImage = UIImage(data: imageData) else { return nil }
        return uiImage
    }
}
