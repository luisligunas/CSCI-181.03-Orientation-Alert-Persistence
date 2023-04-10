# CSCI 181.03 - Orientation, Alert, and Persistence

## Orientation

There are different ways to specify the allowed orientations for the app (both for the overall app and for individual screens).

The first way is through the implementation of this method in `AppDelegate.swift`:
``` Swift
class AppDelegate: UIResponder, UIApplicationDelegate {
  // ...
  func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
    return [.portrait, .landscapeLeft]
  }
  // ...
}
```

The above method specifies which orientations are allowed for the **entirety of the app**. For example, if one of your screens uses `.portrait` and another screen uses `.landscapeLeft` and `.landscapeRight`, all three must be specified here.

**If the method is not implemented**, then Xcode will look to the orientations that are ticked in the Target's General tab as can be seen in the picture below:

<img width="909" alt="Target" src="https://user-images.githubusercontent.com/24354524/230973714-3911c008-75c9-4015-b7d0-b44b3ea3c3dd.png">

---
In order to specify what orientations are allowed for specific `UIViewController`s, the `supportedInterfaceOrientations` property must be overridden to return the appropriate values.
Do note that if an orientation is specified in this property but is not allowed for the entirety of the app, then that orientation will not be allowed for the current `UIViewController`.

``` Swift
class ViewController: UIViewController {
  // ...
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return [.landscapeLeft, .portrait]
  }
  // ...
}
```

## Alert
When displaying native alerts, the first thing that needs to be done is to create a `UIAlertController`. A title, message, and "style" for the alert need to be specified to do this. The two styles that are supported by iOS are the `.alert` style and the `.actionSheet` style.

| `.alert` | `.actionSheet` |
| ----- | ----- |
| <img width="406" alt="Action Sheet" src="https://user-images.githubusercontent.com/24354524/230979960-2d5dd1ae-b711-4d8b-999f-cedf77f13ff9.png"> | <img width="406" alt="Alert" src="https://user-images.githubusercontent.com/24354524/230980010-de621408-9b44-480f-b2f2-20213d6b69bd.png"> |

After that, `UIAlertAction`s are to be added to the `UIAlertController` (if needed) to allow the user to pick one of a certain set of options. There are also different styles that are allowed for each action: `.cancel`, `.default`, and `.destructive`. You can look through their documentations [here](https://developer.apple.com/documentation/uikit/uialertaction/style).


| `.alert` | `.actionSheet` |
| ----- | ----- |
| <img width="406" alt="Screenshot 2023-04-11 at 3 30 52 AM" src="https://user-images.githubusercontent.com/24354524/230981642-2ed98e6d-4211-4e3c-8dcc-c9a22ae1d82b.png"> | <img width="406" alt="Screenshot 2023-04-11 at 3 31 30 AM" src="https://user-images.githubusercontent.com/24354524/230981777-85262aa3-10bc-4063-b29e-bbc5b4594207.png"> |

You may view the source code to see how to do this programmatically and how to respond to taps for each `UIAlertAction`.

## Persistence

There are two types of persistence that are implemented in the app: one using [Keychain](https://developer.apple.com/documentation/security/certificate_key_and_trust_services/keys/storing_keys_in_the_keychain) (implemented using [KeychainSwift](https://github.com/evgenyneu/keychain-swift) package) and another using [`UserDefaults`](https://developer.apple.com/documentation/foundation/userdefaults). 

The former is used for storing sensitive data that need to be stored securely, e.g. API tokens that are obtained from login APIs. The latter is used for non-sensitive data that you don't need to be stored securely.

