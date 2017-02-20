//
//  ProductTableViewModelCell.swift
//  challengeLodjinha
//
//  Created by Renato Souza Bueno on 19/02/17.
//  Copyright © 2017 Renato S. Bueno. All rights reserved.
//

import UIKit

protocol ProductTableViewCellRepresentation: class {
    func shouldReturnURLAtImageView() -> URL?
    func shouldReturnDiscountValue() -> String
    func shouldReturnValue() -> String
    func shouldReturnProductDescription() -> String
    func setViewModelWith(productDetail: ProductDetailModel)
}

class ProductTableViewModelCell {
    
    var product = ProductDetailModel()
    
    init(with productDetail: ProductDetailModel) {
        self.product = productDetail
    }
    
    func shouldReturnValue() -> String {
        return self.formatToCurrency(valueToConvert: self.product.originalPrice)
    }
    
    func shouldReturnDiscountValue() -> String {
        return self.formatToCurrency(valueToConvert: self.product.finalPrice)
    }
    
    func shouldReturnURLAtImageView() -> URL? {
        return URL(string: self.product.imageUrl)
    }
    
    func shouldReturnProductDescription() -> String {
        return self.product.description
    }
    
    
    //MARK: - Currency Formatter
    
    private func formatToCurrency(valueToConvert: Int) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = NumberFormatter.Style.currency
        currencyFormatter.locale = NSLocale.current
        let value = NSNumber(value: valueToConvert)
        let priceString = currencyFormatter.string(from: value) ?? ""
        return "R$ \(priceString)"
    }
    
    
}
