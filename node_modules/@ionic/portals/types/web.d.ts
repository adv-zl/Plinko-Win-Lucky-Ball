import { WebPlugin } from '@capacitor/core';
import { PortalMessage, PortalsPlugin, PortalSubscription, SubscribeOptions, SubscriptionCallback } from './definitions';
export declare class PortalsWeb extends WebPlugin implements PortalsPlugin {
    publish(_message: PortalMessage): Promise<void>;
    subscribe<T = unknown>(_options: SubscribeOptions, _callback: SubscriptionCallback<T>): Promise<PortalSubscription>;
    unsubscribe(_options: PortalSubscription): Promise<void>;
}
