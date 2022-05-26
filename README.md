# TestTaskPryaniky 
В качестве тестового задания предлагается создать небольшое приложение, позволяющее:
получать с сервера json-файл cо списком данных нескольких типов (ex: картинка, блок текста, селектор одного варианта из N) и списком кого, какие блоки данных и в каком порядке надо отобразить.
отображать список указанных элементов, и, при клике на них (или выборе одного из вариантов ответа), выводить информацию, что за объект инициировал событие (например: id, имя)
Ссылка на JSON-файл: <a href="https://pryaniky.com/static/json/sample.json">pryaniky</a> (data - данные, view - что и в каком порядке выводить)
Используемый язык: Swift
Предпочтительный паттерн при реализации приложения: MVVM
Навык использования Pods (Moya, Alamofire, Kingfisher и т.п.) будет плюсом.
Знакомство с RxSwift будет плюсом

# Экраны
![hippo](https://media.giphy.com/media/QKH2Go4zhk648SLN0f/giphy.gif)

## Установка
У вас должны быть установлены Pods:
* <a href="https://github.com/ReactiveX/RxSwift">RxSwift</a>
* <a href="https://github.com/onevcat/Kingfisher">Kingfisher</a>
* <a href="https://github.com/RxSwiftCommunity/Action">Action</a>
# Детали реализации
## Deployment Target
iOS 13
## Архитектура приложения
**MVVM + RxSwift**<br>
## UI
**UIKit without Storyboard and Xibs, only layout with code**<br>
