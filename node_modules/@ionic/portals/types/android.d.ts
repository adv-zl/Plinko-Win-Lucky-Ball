import { PortalMessage, PortalsPlugin, PortalSubscription, SubscribeOptions, SubscriptionCallback } from './definitions';
export declare class PortalsAndroid implements PortalsPlugin {
    publish(message: PortalMessage): Promise<void>;
    subscribe<T = unknown>(options: SubscribeOptions, callback: SubscriptionCallback<T>): Promise<PortalSubscription>;
    unsubscribe(options: PortalSubscription): Promise<void>;
}
