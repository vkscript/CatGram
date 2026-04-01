
# Четвёртая лаба

## API
`https://alfaitmo.ru/server/echo/371385/feed`  
Endpoint возвращает JSON-массив объектов постов

## Дополнительные задание
Сделана нормальная модель ошибок (первое дополнительное задание)
Для третьего дополнительного задания используется локальный файл `feed.json`.  
Переключение: `Configuration.useLocalNetworkClient = true/false`.

## Пример ответа

```json
[
  {
    "id": "1",
    "author_name": "Барсик",
    "image_url": "TODO",
    "text": "Мяууу",
    "likes_count": 42,
    "comments_count": 42,
    "created_at": "2077-07-07T08:00:00Z"
  }
]
```
