//
//  BDUIExamples.swift
//  CatGram
//

import Foundation

struct BDUIExamples {
    
    // MARK: - Example 1: Simple Screen
    
    static let simpleScreenJSON = """
    {
        "type": "contentView",
        "content": {
            "backgroundColor": "background"
        },
        "subviews": [
            {
                "type": "stackView",
                "content": {
                    "axis": "vertical",
                    "spacing": "l",
                    "alignment": "fill"
                },
                "subviews": [
                    {
                        "type": "label",
                        "content": {
                            "text": "Привет, ИТМО!",
                            "font": "title1",
                            "textColor": "textPrimary",
                            "textAlignment": "center"
                        }
                    },
                    {
                        "type": "label",
                        "content": {
                            "text": "Это экран, созданный из JSON",
                            "font": "body",
                            "textColor": "textSecondary",
                            "textAlignment": "center",
                            "numberOfLines": 0
                        }
                    },
                    {
                        "type": "button",
                        "content": {
                            "title": "Нажми меня",
                            "buttonStyle": "primary",
                            "action": {
                                "type": "print",
                                "payload": {
                                    "message": "Кнопка была нажата!"
                                }
                            }
                        }
                    }
                ]
            }
        ]
    }
    """
    
    // MARK: - Example 2: Card with Image
    
    static let cardWithImageJSON = """
    {
        "type": "scrollView",
        "content": {
            "backgroundColor": "background"
        },
        "subviews": [
            {
                "type": "stackView",
                "content": {
                    "axis": "vertical",
                    "spacing": "m"
                },
                "subviews": [
                    {
                        "type": "card",
                        "content": {
                            "backgroundColor": "secondaryBackground",
                            "cornerRadius": "medium",
                            "hasShadow": true
                        },
                        "subviews": [
                            {
                                "type": "stackView",
                                "content": {
                                    "axis": "vertical",
                                    "spacing": "m"
                                },
                                "subviews": [
                                    {
                                        "type": "imageView",
                                        "content": {
                                            "systemImage": "photo.fill",
                                            "contentMode": "scaleAspectFit",
                                            "tintColor": "primary"
                                        },
                                        "constraints": {
                                            "height": 200
                                        }
                                    },
                                    {
                                        "type": "label",
                                        "content": {
                                            "text": "Заголовок карточки",
                                            "font": "headline",
                                            "textColor": "textPrimary"
                                        }
                                    },
                                    {
                                        "type": "label",
                                        "content": {
                                            "text": "Описание карточки с подробной информацией",
                                            "font": "body",
                                            "textColor": "textSecondary",
                                            "numberOfLines": 0
                                        }
                                    },
                                    {
                                        "type": "divider",
                                        "content": {}
                                    },
                                    {
                                        "type": "stackView",
                                        "content": {
                                            "axis": "horizontal",
                                            "spacing": "s",
                                            "distribution": "fillEqually"
                                        },
                                        "subviews": [
                                            {
                                                "type": "button",
                                                "content": {
                                                    "title": "Отмена",
                                                    "buttonStyle": "secondary",
                                                    "action": {
                                                        "type": "dismiss",
                                                        "payload": {}
                                                    }
                                                }
                                            },
                                            {
                                                "type": "button",
                                                "content": {
                                                    "title": "Готово",
                                                    "buttonStyle": "primary",
                                                    "action": {
                                                        "type": "print",
                                                        "payload": {
                                                            "message": "Готово нажато"
                                                        }
                                                    }
                                                }
                                            }
                                        ]
                                    }
                                ]
                            }
                        ]
                    }
                ]
            }
        ]
    }
    """
    
    // MARK: - Example 3: Form
    
    static let formJSON = """
    {
        "type": "scrollView",
        "content": {
            "backgroundColor": "background"
        },
        "subviews": [
            {
                "type": "stackView",
                "content": {
                    "axis": "vertical",
                    "spacing": "l"
                },
                "subviews": [
                    {
                        "type": "label",
                        "content": {
                            "text": "Регистрация",
                            "font": "title1",
                            "textColor": "textPrimary"
                        }
                    },
                    {
                        "type": "textField",
                        "content": {
                            "fieldTitle": "Email",
                            "placeholder": "example@mail.com",
                            "keyboardType": "email"
                        }
                    },
                    {
                        "type": "textField",
                        "content": {
                            "fieldTitle": "Пароль",
                            "placeholder": "Введите пароль",
                            "isSecure": true
                        }
                    },
                    {
                        "type": "textField",
                        "content": {
                            "fieldTitle": "Повторите пароль",
                            "placeholder": "Повторите пароль",
                            "isSecure": true
                        }
                    },
                    {
                        "type": "spacer",
                        "content": {
                            "spacerSize": "l"
                        }
                    },
                    {
                        "type": "button",
                        "content": {
                            "title": "Зарегистрироваться",
                            "buttonStyle": "primary",
                            "action": {
                                "type": "print",
                                "payload": {
                                    "message": "Регистрация"
                                }
                            }
                        }
                    },
                    {
                        "type": "button",
                        "content": {
                            "title": "Уже есть аккаунт? Войти",
                            "buttonStyle": "text",
                            "action": {
                                "type": "navigate",
                                "payload": {
                                    "route": "login"
                                }
                            }
                        }
                    }
                ]
            }
        ]
    }
    """
    
    // MARK: - Example 4: States
    
    static let loadingStateJSON = """
    {
        "type": "loadingView",
        "content": {
            "message": "Загружаем данные..."
        }
    }
    """
    
    static let emptyStateJSON = """
    {
        "type": "emptyView",
        "content": {
            "title": "Нет данных",
            "message": "Здесь пока ничего нет",
            "icon": "tray.fill"
        }
    }
    """
    
    static let errorStateJSON = """
    {
        "type": "errorView",
        "content": {
            "message": "Не удалось загрузить данные. Проверьте подключение к интернету.",
            "showRetryButton": true,
            "action": {
                "type": "reload",
                "payload": {}
            }
        }
    }
    """
    
    // MARK: - Helper Methods
    
    static func decode(_ jsonString: String) -> BDUIComponent? {
        guard let data = jsonString.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(BDUIComponent.self, from: data)
    }
}
