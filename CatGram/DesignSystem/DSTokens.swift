//
//  DSTokens.swift
//  CatGram
//

import UIKit

class DS {
    
    // MARK: - Colors
    enum Colors {
        // Основные цвета
        static let background = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark
                ? UIColor(red: 0.11, green: 0.11, blue: 0.12, alpha: 1.0)
                : UIColor.white
        }
        
        static let secondaryBackground = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark
                ? UIColor(red: 0.17, green: 0.17, blue: 0.18, alpha: 1.0)
                : UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.0)
        }
        
        // Акцентные цвета
        static let primary = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark
                ? UIColor(red: 0.04, green: 0.52, blue: 1.0, alpha: 1.0)
                : UIColor(red: 0.0, green: 0.48, blue: 1.0, alpha: 1.0)
        }
        
        static let secondary = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark
                ? UIColor(red: 0.38, green: 0.38, blue: 0.40, alpha: 1.0)
                : UIColor(red: 0.56, green: 0.56, blue: 0.58, alpha: 1.0)
        }
        
        // Текст
        static let textPrimary = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark
                ? UIColor.white
                : UIColor.black
        }
        
        static let textSecondary = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark
                ? UIColor(red: 0.56, green: 0.56, blue: 0.58, alpha: 1.0)
                : UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 0.6)
        }
        
        static let textTertiary = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark
                ? UIColor(red: 0.56, green: 0.56, blue: 0.58, alpha: 0.6)
                : UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 0.3)
        }
        
        // Состояния
        static let error = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark
                ? UIColor(red: 1.0, green: 0.27, blue: 0.23, alpha: 1.0)
                : UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1.0)
        }
        
        static let success = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark
                ? UIColor(red: 0.19, green: 0.82, blue: 0.35, alpha: 1.0)
                : UIColor(red: 0.20, green: 0.78, blue: 0.35, alpha: 1.0)
        }
        
        // Разделители и границы
        static let separator = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark
                ? UIColor(red: 0.33, green: 0.33, blue: 0.35, alpha: 0.6)
                : UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 0.29)
        }
        
        static let border = UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark
                ? UIColor(red: 0.28, green: 0.28, blue: 0.29, alpha: 1.0)
                : UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0)
        }
    }
    
    // MARK: - Typography
    enum Typography {
        static func largeTitle() -> UIFont {
            .systemFont(ofSize: 34, weight: .bold)
        }
        
        static func title1() -> UIFont {
            .systemFont(ofSize: 28, weight: .bold)
        }
        
        static func title2() -> UIFont {
            .systemFont(ofSize: 22, weight: .bold)
        }
        
        static func title3() -> UIFont {
            .systemFont(ofSize: 20, weight: .semibold)
        }
        
        static func headline() -> UIFont {
            .systemFont(ofSize: 17, weight: .semibold)
        }
        
        static func body() -> UIFont {
            .systemFont(ofSize: 17, weight: .regular)
        }
        
        static func callout() -> UIFont {
            .systemFont(ofSize: 16, weight: .regular)
        }
        
        static func subheadline() -> UIFont {
            .systemFont(ofSize: 15, weight: .regular)
        }
        
        static func footnote() -> UIFont {
            .systemFont(ofSize: 13, weight: .regular)
        }
        
        static func caption1() -> UIFont {
            .systemFont(ofSize: 12, weight: .regular)
        }
        
        static func caption2() -> UIFont {
            .systemFont(ofSize: 11, weight: .regular)
        }
    }
    
    // MARK: - Spacing
    enum Spacing {
        static let xs: CGFloat = 4
        static let s: CGFloat = 8
        static let m: CGFloat = 16
        static let l: CGFloat = 24
        static let xl: CGFloat = 32
        static let xxl: CGFloat = 40
        
        // Радиусы
        static let cornerRadiusSmall: CGFloat = 8
        static let cornerRadiusMedium: CGFloat = 12
        static let cornerRadiusLarge: CGFloat = 16
        
        // Высоты компонентов
        static let buttonHeight: CGFloat = 50
        static let textFieldHeight: CGFloat = 50
    }
    
    // MARK: - Shadows
    enum Shadows {
        static func small() -> NSShadow {
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.black.withAlphaComponent(0.1)
            shadow.shadowOffset = CGSize(width: 0, height: 2)
            shadow.shadowBlurRadius = 4
            return shadow
        }
        
        static func medium() -> NSShadow {
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.black.withAlphaComponent(0.15)
            shadow.shadowOffset = CGSize(width: 0, height: 4)
            shadow.shadowBlurRadius = 8
            return shadow
        }
        
        static func large() -> NSShadow {
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.black.withAlphaComponent(0.2)
            shadow.shadowOffset = CGSize(width: 0, height: 8)
            shadow.shadowBlurRadius = 16
            return shadow
        }
    }
}
