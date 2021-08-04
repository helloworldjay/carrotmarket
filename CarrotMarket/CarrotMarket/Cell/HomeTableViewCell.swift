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
        if let calculatedPastTime = calculatePastTime(from: item.date) {
            self.itemWrittenTime.text = calculatedPastTime
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
    
    private func calculatePastTime(from writtenTime: Date) -> String? {
        guard let distanceDay = Calendar.current.dateComponents([.day], from: writtenTime, to: Date()).day else { return nil }
        if distanceDay != 0 { return "\(distanceDay)일 전" }
        guard let distanceHour = Calendar.current.dateComponents([.hour], from: writtenTime, to: Date()).hour else { return nil }
        if distanceHour != 0 { return "\(distanceHour)시간 전" }
        guard let distanceMinute = Calendar.current.dateComponents([.minute], from: writtenTime, to: Date()).minute else { return nil }
        if distanceMinute != 0 { return "\(distanceMinute)분 전" }
        guard let distanceSecond = Calendar.current.dateComponents([.second], from: writtenTime, to: Date()).second else { return nil }
        return "\(distanceSecond)초 전"
    }
}
