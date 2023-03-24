import { AwesomeCordovaNativePlugin } from '@awesome-cordova-plugins/core';
import { Observable } from 'rxjs';
/**
 * @name App Preferences
 * @description
 * This plugin allows you to read and write app preferences
 * @usage
 * ```typescript
 * import { AppPreferences } from '@awesome-cordova-plugins/app-preferences/ngx';
 *
 * constructor(private appPreferences: AppPreferences) { }
 *
 * ...
 *
 * this.appPreferences.fetch('key').then((res) => { console.log(res); });
 *
 * ```
 */
export declare class AppPreferencesOriginal extends AwesomeCordovaNativePlugin {
    /**
     * Get a preference value
     *
     * @param {string} dict Dictionary for key (OPTIONAL)
     * @param {string} key Key
     * @returns {Promise<any>} Returns a promise
     */
    fetch(dict: string, key?: string): Promise<any>;
    /**
     * Set a preference value
     *
     * @param {string} dict Dictionary for key (OPTIONAL)
     * @param {string} key Key
     * @param {any} value Value
     * @returns {Promise<any>} Returns a promise
     */
    store(dict: string, key: string, value?: any): Promise<any>;
    /**
     * Remove value from preferences
     *
     * @param {string} dict Dictionary for key (OPTIONAL)
     * @param {string} key Key
     * @returns {Promise<any>} Returns a promise
     */
    remove(dict: string, key?: string): Promise<any>;
    /**
     * Clear preferences
     *
     * @returns {Promise<any>} Returns a promise
     */
    clearAll(): Promise<any>;
    /**
     * Show native preferences interface
     *
     * @returns {Promise<any>} Returns a promise
     */
    show(): Promise<any>;
    /**
     * Show native preferences interface
     *
     * @param {boolean} subscribe true value to subscribe, false - unsubscribe
     * @returns {Observable<any>} Returns an observable
     */
    watch(subscribe: boolean): Observable<any>;
    /**
     * Return named configuration context
     * In iOS you'll get a suite configuration, on Android — named file
     * Supports: Android, iOS
     *
     * @param {string} suiteName suite name
     * @returns {Object} Custom object, bound to that suite
     */
    suite(suiteName: string): any;
    iosSuite(suiteName: string): any;
    /**
     * Return cloud synchronized configuration context
     * Currently supports Windows and iOS/macOS
     *
     * @returns {Object} Custom object, bound to that suite
     */
    cloudSync(): Object;
    /**
     * Return default configuration context
     * Currently supports Windows and iOS/macOS
     *
     * @returns {Object} Custom Object, bound to that suite
     */
    defaults(): Object;
}

export declare const AppPreferences: AppPreferencesOriginal;