# Marvel-characters

## Приложение для отображения персонажей вселенной Marvel с бесконечной прокруткой, аутентификацией через Firebase Auth и хранением информации в FirebaseFirestore.
 
### 
__Основной испльзуемый стек:__ ___UIKit, Firebase, Navigation Controller, UICollectionView, UITableView, custom views+tableViewCells.___

__Используемые библеотеки:__ ___SnapKit, Alamofire, SDWebImage.___

__Проект написан на__ ___MVP.___

___

#### Описание:
Приложение загружается на экране входа, который реализован с помощью Firebase Auth, войти можно по email + password или через google аккаунт. Также создан экран регистрации, при неправильности ввода каких-либо данных пользователь будет уведомлен об этом через всплывающий алерт.

<img src="https://github.com/Artem-Tomilo/Marvel-Comics/blob/main/Marvel-Comics/res/Gif/signUp.gif" width="300"> <img src="https://github.com/Artem-Tomilo/Marvel-Comics/blob/main/Marvel-Comics/res/Gif/google.gif" width="300">

После входа, приложение получает по API персонажей вселенной Marvel и отображает их в CollectionView. Изначально происходит загрузка первых 10 персонажей, после пролистывания вниз осуществляется повторная загрузка следующих 10, во время загрузки отображается CollectionReusableView с ActivityIndicator внутри. При нажатии на персонажа осуществляется переход на экран с его изображением, именем, описанием и комиксами. Экран деталей персонажа реализован с помощью TableView, комиксы - CollectionView внутри ячейки TableView.

<img src="https://github.com/Artem-Tomilo/Marvel-Comics/blob/main/Marvel-Comics/res/Gif/signIn.gif" width="300"> <img src="https://github.com/Artem-Tomilo/Marvel-Comics/blob/main/Marvel-Comics/res/Gif/details.gif" width="300">

Также можно добавить персонажей в избранное, просмотреть их можно на экране Аккаунт (если их нет, будет отображен всплывающий алерт). При нажатии на персонажа также можно перейти на экран с его деталями. Внизу экрана добавлена кнопка выхода из профиля, которая отправит пользователя на экран входа. 

<img src="https://github.com/Artem-Tomilo/Marvel-Comics/blob/main/Marvel-Comics/res/Gif/account.gif" width="300"> <img src="https://github.com/Artem-Tomilo/Marvel-Comics/blob/main/Marvel-Comics/res/Gif/signOut.gif" width="300">

В случае ошибки получения персонажей или комиксов пользователь будет уведомлен об этом путем получения алерта:

<img src="https://github.com/Artem-Tomilo/Marvel-Comics/blob/main/Marvel-Comics/res/Gif/Alert.gif" width="300">

