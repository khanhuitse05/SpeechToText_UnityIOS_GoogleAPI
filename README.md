# SpeechToText_UnityIOS_GoogleAPI
Spech To Text in Unity IOS, Use cloud speech api

Detail Google speech API: https://cloud.google.com/speech/

## Request Credentials Key From Google

* First, make sure you are a member of chromium-dev@chromium.org . If not you can just subscribe to be chromium-dev and choose not to receive mail. The APIs are only visible to people subscribed to that group.
* Create new Project in cloud.google.com/console
* In a search box: Search for “Speech API” and enable the API.  (if api is not show, recheck step 1)
* Go to the Credentials tab under the APIs & auth tab. Click the “Add credentials” button then click on the “OAuth 2.0 client ID” item in the drop-down list.
You should now have an API key and a OAuth 2.0 client ID in on the Credentials tab
more information: http://www.chromium.org/developers/how-tos/api-keys

## Build Sample project

Download project

* Step 1: Open project

* Step 2: Replace your credentials key on GOOGLE_SPEECH_TO_TEXT_KEY  and your language you want. (Need switch Unity iOS platform first)

* Step 3: build iOS, You will have Xcode project.

* Step 4: You need to add speex SDK to your project. (In folder “Package”)
 Copy SpeexSDK  to Xcode project -> Add other framwork -> Select SpeexSDK

* Step 5: Because this class is using non-arc, so make sure you mark the flag “-fno-objc-arc” in the header file of class SpeechToTextModule. (In Build Phases tap)

* Step 6: Build and run in Device iOS
