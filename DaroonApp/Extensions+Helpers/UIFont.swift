//
//  UIFont.swift
//  DaroonApp
//
//  Created by Masoud on 8/15/18.
//  Copyright © 2018 Masoud Sheikh Hosseini. All rights reserved.
//
//zzmasoud: Thanks to John Bushnell for this beautifull solution -- https://stackoverflow.com/questions/30507905/xcode-using-custom-fonts-inside-dynamic-framework


import Foundation

public extension UIFont {
    
    public static func registerFontWithFilenameString(filenameString: String, bundle: Bundle) {
        
        guard let pathForResourceString = bundle.path(forResource: filenameString, ofType: nil) else {
            return
        }
        
        guard let fontData = NSData(contentsOfFile: pathForResourceString) else {
            return
        }
        
        guard let dataProvider = CGDataProvider(data: fontData) else {
            return
        }
        
        guard let fontRef = CGFont(dataProvider) else {
            return
        }
        
        var errorRef: Unmanaged<CFError>? = nil
        if (CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) == false) {
        }
    }
}
