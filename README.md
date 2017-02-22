
[![CocoaPods](https://img.shields.io/badge/platforms-iOS-orange.svg?maxAge=2592000)](http://rs-build/repo/log/?r=hyper/ios/hyper-sdk.git&h=pozzito_core)
[![Languages](https://img.shields.io/badge/languages-ObjC%20%20%20Swift-orange.svg?maxAge=2592000)](https://github.com/pozzito-dev/pozzitoapi-ios)

## Installation

Pozzito supports iOS 9 and up.

### CocoaPods
Add the Pozzito pod into your Podfile and run `pod install`.

    target :YourTargetName do
      pod 'Pozzito'
    end

### Manual Installation

1. Download Pozzito and extract the zip.
2. Go to your Xcode project's "General" settings. Drag `Pozzito.framework` to the "Embedded Binaries" section. Make sure "Copy items if needed" is selected and click Finish.
3. Create a new "Run Script Phase" in your app’s target’s "Build Phases" and paste the following snippet in the script text field:

        bash "${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/Pozzito.framework/strip-frameworks.sh"
This step is required to work around an [App Store submission bug](http://www.openradar.me/radar?id=6409498411401216) when archiving universal binaries.

##Setup and Configuration

### PozzitoManager

First of all, to use Pozzito you need to have api key and app id, you should get that when you register [on our site](https://pozzito.com#start).

When you have installed Pozzito, you need to import it in the file you want to use it, and instantiate PozzitoManager with apiKey and appId.

```swift
PozzitoManager(apiKey: "", appId: "", completion: { (err) in
    //error handling
})
```

After instantiating it you can use CoreService, ConversationService and ChatService.

CoreService is used to handle user related requests, ConversationService to handle conversation related requests, and ChatService is used to handle sockets, subscriptions etc. 

### CoreService

######Available methods:

```swift
/// Creates new end user object and authenticates current user
/// If there are no user parameters, an anonymous user is created
///
/// - Parameter userParameters: Optional dictionary with user parameters,
///                             current options - userName, firstName, lastName
public func createEndUser(userParameters: RequestDictionary? = nil,
completion: @escaping (UserModel?, ServiceError?) -> Void)

/// Updates end user data with input parameters
///
/// - Parameter userParameters: Dictionary with user parameters,
///                             current options - userName, firstName, lastName
public func updateUser(userParameters: RequestDictionary,
completion: @escaping (UserModel?, ServiceError?) -> Void)
```

######Examples:

When you want to create a user use CoreService createEndUser method, with or without user parameters. 

If you dont provide parameters Pozzito will create an anonymous user.

Current possible parameters are userName, firstName and lastName.

User is saved when user object is created so you don't have to do it.

```swift
CoreService.shared.createEndUser(completion: { (user, error) in
    //user || error handling, proceeding to conversations etc
})
```

### ConversationService

######Available methods:

```swift
/// Fetches all conversations from the server
///
/// - Parameters:
///   - parameters: Dictionary with parameters used for filtering response, optional
public func getAllConversations(parameters: RequestDictionary? = nil,
completion: @escaping ([ConversationModel]?, ServiceError?) -> Void)

/// Calls api service create method with conversation resource
public func createConversation(parameters: RequestDictionary? = nil,
completion: @escaping (ConversationModel?, ServiceError?) -> Void)

/// Sends chat score to the server
///
/// - Parameter scoreId: Selected score id
public func sendConversationScore(conversationId: String, scoreId: String,
completion: @escaping (ConversationModel?, ServiceError?) -> Void)

/// Fetches possible satisfaction scores from the server
public func getSatisfactionScores(completion: @escaping ([SatisfactionScoreModel]?, ServiceError?)

/// Updates conversation status on the server to seen
public func setConversationSeen(conversationId: String,
completion: @escaping (ConversationModel?, ServiceError?) -> Void)

/// Fetches conversation from the server with the given id
///
/// - Parameter id: conversation id
public func getConversation(conversationId: String,
completion: @escaping (ConversationModel?, ServiceError?) -> Void)
```

######Examples:

When you want to start a conversation you should use ConversationService createConversation method which takes dictionary with conversation description as a parameter with key "description" 

```swift
ConversationService.shared.createConversation(parameters: conversationParameters, completion: { (conversation, error) in
    //conversation || error handling, proceeding to chat
})
```

When you wish to get all conversations for the authenticated user use ConversationService getAllConversations method. 

```swift
ConversationService.shared.getAllConversations(completion: { (conversations, error) in
    //conversations || error handling, displaying conversations etc
})
```

### ChatService

######Available methods:

```swift
/// Configures chat service, used to set initial parameters
///
/// - Parameters:
///   - tenantId: Tenant organization id
///   - userId: Current user id
///   - chatId: Conversation id
///   - delegate: Chat event protocol delegate, class in which you display chat UI
public func configureChat(tenantId: String?, userId: String?, chatId: String?, delegate: ChatEventDelegate?)

/// Chat client attempts to send message
///
/// - Parameter message: Message text
public func sendMessage(message: String)

/// Attempts to connects chat client
///
/// - Parameters:
///   - firstMessage:  optional first message parameter
public func connectChat(firstMessage: String? = nil)

/// Attempts to disconnect chat client
public func disconnectChat()
```

To connect to socket and use chat functionality use ChatService and ChatEventDelegate protocol to notify your controller of recurring chat events.

First it has to be configured to use properly with configureChat method, than you can attempt to connect with connectChat method.

To send a message use sendMessage method, and to disconnect chat use disconnectChat method.

#####ChatEventDelegate

Protocol used for notifying class used for displaying chat functionality.

######Available methods:

```swift
func chatErrorReceived(errorDescription: String)
func chatMessageReceived(message: [String : AnyObject])
func chatEnded()
func connected()
func connecting()
func disconnected()
```


* If you have any other questions please contact us via email support@pozzito.com.



