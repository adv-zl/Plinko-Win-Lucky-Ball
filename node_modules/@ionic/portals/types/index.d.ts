import type { InitialContext, PortalsPlugin } from './definitions';
declare const Portals: PortalsPlugin;
/**
 * Provides access to any initial state provided by the native application.
 * If the web application is running in a Portal, this will always be defined
 * with the name property.
 * */
export declare function getInitialContext<T = unknown>(): InitialContext<T> | undefined;
export * from './definitions';
export default Portals;
