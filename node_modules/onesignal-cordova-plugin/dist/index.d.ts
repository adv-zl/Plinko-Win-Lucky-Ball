/**
 * Modified MIT License
 *
 * Copyright 2019 OneSignal
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * 1. The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * 2. All copies of substantial portions of the Software may only be used in connection
 * with services provided by OneSignal.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
import { InAppMessageAction, InAppMessageLifecycleHandlerObject } from "./models/InAppMessage";
import { OpenedEvent } from "./models/NotificationOpened";
import { OutcomeEvent } from "./models/Outcomes";
import NotificationReceivedEvent from "./NotificationReceivedEvent";
import { ChangeEvent, DeviceState, EmailSubscriptionChange, PermissionChange, SMSSubscriptionChange, SubscriptionChange } from "./Subscription";
export declare type LogLevel = 0 | 1 | 2 | 3 | 4 | 5 | 6;
export declare class OneSignalPlugin {
    private _appID;
    private _notificationWillShowInForegroundDelegate;
    private _notificationOpenedDelegate;
    private _inAppMessageClickDelegate;
    private _onWillDisplayInAppMessageDelegate;
    private _onDidDisplayInAppMessageDelegate;
    private _onWillDismissInAppMessageDelegate;
    private _onDidDismissInAppMessageDelegate;
    private _permissionObserverList;
    private _subscriptionObserverList;
    private _emailSubscriptionObserverList;
    private _smsSubscriptionObserverList;
    private _processFunctionList;
    /**
     * Completes OneSignal initialization by setting the OneSignal Application ID.
     * @param  {string} appId
     * @returns void
     */
    setAppId(appId: string): void;
    /**
     * Set the callback to run just before displaying a notification while the app is in focus.
     * @param  {(event:NotificationReceivedEvent)=>void} handler
     * @returns void
     */
    setNotificationWillShowInForegroundHandler(handler: (event: NotificationReceivedEvent) => void): void;
    /**
     * Set the callback to run on notification open.
     * @param  {(openedEvent:OpenedEvent) => void} handler
     * @returns void
     */
    setNotificationOpenedHandler(handler: (openedEvent: OpenedEvent) => void): void;
    /**
     * Sets an In-App Message click event handler.
     * @param  {(action:InAppMessageAction)=>void} handler
     * @returns void
     */
    setInAppMessageClickHandler(handler: (action: InAppMessageAction) => void): void;
    /**
     * Sets the In-App Message lifecycle handler object to run on displaying and/or dismissing an In-App Message.
     * @param  {InAppMessageLifecycleHandlerObject} handlerObject
     * @returns void
     */
    setInAppMessageLifecycleHandler(handlerObject: InAppMessageLifecycleHandlerObject): void;
    /**
     * This method returns a "snapshot" of the device state for when it was called.
     * @param  {(response: DeviceState) => void} handler
     * @returns void
     */
    getDeviceState(handler: (response: DeviceState) => void): void;
    /**
     * Allows you to set the app defined language with the OneSignal SDK.
     * @param  {string} language
     * @param  {(success:object)=>void} onSuccess
     * @param  {(failure:object)=>void} onFailure
     * @returns void
     */
    setLanguage(language: string, onSuccess?: (success: object) => void, onFailure?: (failure: object) => void): void;
    /**
     * Add a callback that fires when the OneSignal subscription state changes.
     * @param  {(event:ChangeEvent<SubscriptionChange>)=>void} observer
     * @returns void
     */
    addSubscriptionObserver(observer: (event: ChangeEvent<SubscriptionChange>) => void): void;
    /**
     * Add a callback that fires when the OneSignal email subscription changes.
     * @param  {(event:ChangeEvent<EmailSubscriptionChange>)=>void} observer
     * @returns void
     */
    addEmailSubscriptionObserver(observer: (event: ChangeEvent<EmailSubscriptionChange>) => void): void;
    /**
     * Add a callback that fires when the OneSignal sms subscription changes.
     * @param  {(event:ChangeEvent<SMSSubscriptionChange>)=>void} observer
     * @returns void
     */
    addSMSSubscriptionObserver(observer: (event: ChangeEvent<SMSSubscriptionChange>) => void): void;
    /**
     * Add a callback that fires when the native push permission changes.
     * @param  {(event:ChangeEvent<PermissionChange>)=>void} observer
     * @returns void
     */
    addPermissionObserver(observer: (event: ChangeEvent<PermissionChange>) => void): void;
    /**
     * Retrieve a list of tags that have been set on the user from the OneSignal server.
     * @param  {(tags:object)=>void} handler
     * @returns void
     */
    getTags(handler: (tags: object) => void): void;
    /**
     * Tag a user based on an app event of your choosing so they can be targeted later via segments.
     * @param  {string} key
     * @param  {string} value
     * @returns void
     */
    sendTag(key: string, value: string): void;
    /**
     * Tag a user wiht multiple tags based on an app event of your choosing so they can be targeted later via segments.
     * @param  {object} tags
     * @returns void
     */
    sendTags(tags: object): void;
    /**
     * Deletes a single tag that was previously set on a user.
     * @param  {string} key
     * @returns void
     */
    deleteTag(key: string): void;
    /**
     * Deletes multiple tags that were previously set on a user.
     * @param  {string[]} keys
     * @returns void
     */
    deleteTags(keys: string[]): void;
    /**
     * Only applies to iOS (does nothing on Android as it always silently registers)
     * Call only if you passed false to autoRegister
     * Request for Direct-To-History push notification authorization
     *
     * For more information: https://documentation.onesignal.com/docs/ios-customizations#provisional-push-notifications
     *
     * @param  {(response:{accepted:boolean})=>void} handler
     * @returns void
     */
    registerForProvisionalAuthorization(handler?: (response: {
        accepted: boolean;
    }) => void): void;
    /**
     * Prompts the user for push notifications permission in iOS and Android 13+.
     * Use the fallbackToSettings parameter to prompt to open the settings app if a user has already declined push permissions.
     *
     * Call with promptForPushNotificationsWithUserResponse(fallbackToSettings?, handler?)
     *
     * @param  {boolean} fallbackToSettings
     * @param  {(response:boolean)=>void} handler
     * @returns void
     */
    promptForPushNotificationsWithUserResponse(fallbackToSettingsOrHandler?: boolean | ((response: boolean) => void), handler?: (response: boolean) => void): void;
    /**
     * Android Only. iOS provides a standard way to clear notifications by clearing badge count.
     * @returns void
     */
    clearOneSignalNotifications(): void;
    /**
     * Android Only. If notifications are disabled for your application, unsubscribe the user from OneSignal.
     * @param  {boolean} unsubscribe
     * @returns void
     */
    unsubscribeWhenNotificationsAreDisabled(unsubscribe: boolean): void;
    /**
     * Removes a single OneSignal notification based on its Android notification integer id.
     * @param  {number} id - notification id to cancel
     * @returns void
     */
    removeNotification(id: number): void;
    /**
     * Removes all OneSignal notifications based on its Android notification group Id.
     * @param  {string} id - notification group id to cancel
     * @returns void
     */
    removeGroupedNotifications(id: string): void;
    /**
     * Disable the push notification subscription to OneSignal.
     * @param  {boolean} disable
     * @returns void
     */
    disablePush(disable: boolean): void;
    /**
     * Send a notification
     * @param  {object} notificationObject - JSON payload (see REST API reference)
     * @param  {(success:object)=>void} onSuccess
     * @param  {(failure:object)=>void} onFailure
     * @returns void
     */
    postNotification(notificationObject: object, onSuccess?: (success: object) => void, onFailure?: (failure: object) => void): void;
    /**
     * iOS only.
     * This method can be used to set if launch URLs should be opened within the application or in Safari.
     * @param  {boolean} isEnabled - false will open the link in Safari or user's default browser
     * @returns void
     */
    setLaunchURLsInApp(isEnabled: boolean): void;
    /**
     * Enable logging to help debug if you run into an issue setting up OneSignal.
     * @param  {LogLevel} nsLogLevel - Sets the logging level to print to the Android LogCat log or Xcode log.
     * @param  {LogLevel} visualLogLevel - Sets the logging level to show as alert dialogs.
     * @returns void
     */
    setLogLevel(nsLogLevel: LogLevel, visualLogLevel: LogLevel): void;
    /**
     * Did the user provide privacy consent for GDPR purposes.
     * @param  {(response: boolean) => void} handler
     * @returns void
     */
    userProvidedPrivacyConsent(handler: (response: boolean) => void): void;
    /**
     * True if the application requires user privacy consent, false otherwise
     * Passes a boolean on Android and passes an object on iOS to the handler.
     *
     * @param  {(response: boolean | {value: boolean}) => void} handler
     * @returns void
     */
    requiresUserPrivacyConsent(handler: (response: boolean | {
        value: boolean;
    }) => void): void;
    /**
     * For GDPR users, your application should call this method before setting the App ID.
     * @param  {boolean} required
     * @returns void
     */
    setRequiresUserPrivacyConsent(required: boolean): void;
    /**
     * If your application is set to require the user's privacy consent, you can provide this consent using this method.
     * @param  {boolean} granted
     * @returns void
     */
    provideUserConsent(granted: boolean): void;
    /**
     * Email
     */
    /**
     * Allows you to set the user's email address with the OneSignal SDK.
     * @param  {string} email
     * @param  {string} authCode
     * @param  {Function} onSuccess
     * @param  {Function} onFailure
     * @returns void
     */
    setEmail(email: string, authCode?: string, onSuccess?: Function, onFailure?: Function): void;
    /**
     * If your app implements logout functionality, you can call logoutEmail to dissociate the email from the device.
     * @param  {Function} onSuccess
     * @param  {Function} onFailure
     * @returns void
     */
    logoutEmail(onSuccess?: Function, onFailure?: Function): void;
    /**
     * SMS
     */
    /**
     * Allows you to set the user's SMS number with the OneSignal SDK.
     * @param  {string} smsNumber
     * @param  {string} authCode
     * @param  {Function} onSuccess
     * @param  {Function} onFailure
     * @returns void
     */
    setSMSNumber(smsNumber: string, authCode?: string, onSuccess?: Function, onFailure?: Function): void;
    /**
     * If your app implements logout functionality, you can call logoutSMSNumber to dissociate the SMS number from the device.
     * @param  {Function} onSuccess
     * @param  {Function} onFailure
     * @returns void
     */
    logoutSMSNumber(onSuccess?: Function, onFailure?: Function): void;
    /**
     * Allows you to use your own system's user ID's to send push notifications to your users.
     *
     * Possible function usages:
     * setExternalUserId(externalId: string?): void
     * setExternalUserId(externalId: string?, handler: function?): void
     * setExternalUserId(externalId: string?, externalIdAuthCode: string?, handler: function?): void
     *
     * @param  {string} externalId
     * @param  {string} externalIdAuthCode
     * @param  {(results:object) => void} handler
     * @returns void
     */
    setExternalUserId(externalId: string | null, handlerOrAuth?: ((results: object) => void) | string, handler?: (results: object) => void): void;
    /**
     * Removes whatever was set as the current user's external user ID.
     * @param  {(results:object)=>void} handler
     * @returns void
     */
    removeExternalUserId(handler?: (results: object) => void): void;
    /**
     * In app messaging
     */
    /**
     * Adds Multiple In-App Message Triggers.
     * @param  {[key: string]: string | number | boolean} triggers
     * @returns void
     */
    addTriggers(triggers: {
        [key: string]: string | number | boolean;
    }): void;
    /**
     * Add an In-App Message Trigger.
     * @param  {string} key
     * @param  {string | number | boolean} value
     * @returns void
     */
    addTrigger(key: string, value: string | number | boolean): void;
    /**
     * Removes a list of triggers based on a key.
     * @param  {string} key
     * @returns void
     */
    removeTriggerForKey(key: string): void;
    /**
     * Removes a list of triggers based on a collection of keys.
     * @param  {string[]} keys
     * @returns void
     */
    removeTriggersForKeys(keys: string[]): void;
    /**
     * Gets a trigger value for a provided trigger key.
     * @param  {string} key
     * @param  {(value: string) => void} handler
     * @returns void
     */
    getTriggerValueForKey(key: string, handler: (value: string) => void): void;
    /**
     * Pause & unpause In-App Messages
     * @param  {boolean} pause
     * @returns void
     */
    pauseInAppMessages(pause: boolean): void;
    /**
     * Outcomes
     */
    /**
     * Increases the "Count" of this Outcome by 1 and will be counted each time sent.
     * @param  {string} name
     * @param  {(event:OutcomeEvent)=>void} handler
     * @returns void
     */
    sendOutcome(name: string, handler?: (event: OutcomeEvent) => void): void;
    /**
     * Increases "Count" by 1 only once. This can only be attributed to a single notification.
     * @param  {string} name
     * @param  {(event:OutcomeEvent)=>void} handler
     * @returns void
     */
    sendUniqueOutcome(name: string, handler?: (event: OutcomeEvent) => void): void;
    /**
     * Increases the "Count" of this Outcome by 1 and the "Sum" by the value. Will be counted each time sent.
     * If the method is called outside of an attribution window, it will be unattributed until a new session occurs.
     * @param  {string} name
     * @param  {string|number} value
     * @param  {(event:OutcomeEvent)=>void} handler
     * @returns void
     */
    sendOutcomeWithValue(name: string, value: string | number, handler?: (event: OutcomeEvent) => void): void;
    /**
     * Location
     */
    /**
     * Prompts the user for location permissions to allow geotagging from the OneSignal dashboard.
     * @returns void
     */
    promptLocation(): void;
    /**
     * Disable or enable location collection (defaults to enabled if your app has location permission).
     * @param  {boolean} shared
     * @returns void
     */
    setLocationShared(shared: boolean): void;
    /**
     * True if the application has location share activated, false otherwise
     * Passes a boolean on Android and passes an object on iOS to the handler.
     *
     * @param  {(response: boolean | {value: boolean}) => void} handler
     * @returns void
     */
    isLocationShared(handler: (response: boolean | {
        value: boolean;
    }) => void): void;
    /**
     * Live Activities
     */
    /**
     * Enter a live activity
     * @param  {string} activityId
     * @param  {string} token
     * @param  {Function} onSuccess
     * @param  {Function} onFailure
     * @returns void
     */
    enterLiveActivity(activityId: string, token: string, onSuccess?: Function, onFailure?: Function): void;
    /**
     * Exit a live activity
     * @param  {string} activityId
     * @param  {Function} onSuccess
     * @param  {Function} onFailure
     * @returns void
     */
    exitLiveActivity(activityId: string, onSuccess?: Function, onFailure?: Function): void;
}
declare const OneSignal: OneSignalPlugin;
export default OneSignal;
