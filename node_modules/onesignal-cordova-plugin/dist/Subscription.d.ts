export declare type PermissionStatus = 0 | 1 | 2 | 3 | 4;
export declare class DeviceState {
    userId: string;
    pushToken: string;
    emailUserId: string;
    emailAddress: string;
    smsUserId: string;
    smsNumber: string;
    subscribed: boolean;
    pushDisabled: boolean;
    emailSubscribed: boolean;
    smsSubscribed: boolean;
    hasNotificationPermission: boolean;
    notificationPermissionStatus?: PermissionStatus;
    constructor(deviceState: any);
}
export interface ChangeEvent<ObserverChangeEvent> {
    from: ObserverChangeEvent;
    to: ObserverChangeEvent;
}
export declare type ObserverChangeEvent = PermissionChange | SubscriptionChange | EmailSubscriptionChange | SMSSubscriptionChange;
export interface PermissionChange {
    status: PermissionStatus;
    hasPrompted?: boolean;
    provisional?: boolean;
}
export interface SubscriptionChange {
    userId?: string;
    pushToken?: string;
    isSubscribed: boolean;
}
export interface EmailSubscriptionChange {
    emailAddress?: string;
    emailUserId?: string;
    isEmailSubscribed: boolean;
}
export interface SMSSubscriptionChange {
    smsNumber?: string;
    smsUserId?: string;
    isSMSSubscribed: boolean;
}
