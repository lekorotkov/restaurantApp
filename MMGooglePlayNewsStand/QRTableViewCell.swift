//
//  QRTableViewCell.swift
//  MMGooglePlayNewsStand
//
//  Created by Alexey Korotkov on 10/30/16.
//  Copyright © 2016 madapps. All rights reserved.
//

class QRTableViewCell: UITableViewCell {
    
    @IBOutlet weak var qrImageView: UIImageView!
    @IBOutlet weak var middleView: UIView!
    var qrcodeImage: CIImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        middleView.layer.shadowColor=UIColor.blackColor().CGColor
        middleView.layer.shadowRadius = 8.0
        middleView.layer.shadowOpacity  = 1.0
        middleView.layer.masksToBounds=true
        
        let data = "1223123123512358992".dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
        
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        filter!.setValue(data, forKey: "inputMessage")
        filter!.setValue("Q", forKey: "inputCorrectionLevel")
        
        qrcodeImage = filter!.outputImage
        
        displayQRCodeImage()
        
    }
    
    func displayQRCodeImage() {
        let scaleX = qrImageView.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = qrImageView.frame.size.height / qrcodeImage.extent.size.height
        
        let transformedImage = qrcodeImage.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
        
        qrImageView.image = UIImage(CIImage: transformedImage)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}