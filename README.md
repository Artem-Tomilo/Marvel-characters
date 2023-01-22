# Marvel-characters

## Приложение для отображения персонажей вселенной Marvel с бесконечной прокруткой.
 
### 
__Основной испльзуемый стек:__ ___UIKit, Navigation Controller, UICollectionView, UITableView, custom views+tableViewCells.___

__Используемые библеотеки:__ ___SnapKit, Alamofire, SDWebImage.___

__Проект написан на__ ___MVP.___

___

#### Описание:
Приложение получает по API персонажей вселенной Marvel и отображает их в CollectionView. Изначально происходит загрузка первых 10 персонажей, после пролистывания вниз осуществляется повторная загрузка следующих 10, во время загрузки отображается CollectionReusableView с ActivityIndicator внутри. При нажатии на персонажа осуществляется переход на экран с его изображением, именем, описанием и комиксами. Экран деталей персонажа реализован с помощью TableView, комиксы - CollectionView внутри ячейки TableView. 

<img src="https://github.com/Artem-Tomilo/Marvel-Comics/blob/main/Marvel-Comics/res/Gif/Records.gif" width="300">

В случае ошибки получения персонажей или комиксов пользователь будет уведомлен об этом путем получения алерта:

<img src="https://github.com/Artem-Tomilo/Marvel-Comics/blob/main/Marvel-Comics/res/Gif/Alert.gif" width="300">

