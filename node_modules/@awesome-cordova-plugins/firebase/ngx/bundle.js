'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var tslib = require('tslib');
var core$1 = require('@angular/core');
var core = require('@awesome-cordova-plugins/core');
require('rxjs');

var Firebase = /** @class */ (function (_super) {
    tslib.__extends(Firebase, _super);
    function Firebase() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    Firebase.prototype.getToken = function () { return core.cordova(this, "getToken", {}, arguments); };
    Firebase.prototype.onTokenRefresh = function () { return core.cordova(this, "onTokenRefresh", { "observable": true }, arguments); };
    Firebase.prototype.onNotificationOpen = function () { return core.cordova(this, "onNotificationOpen", { "observable": true }, arguments); };
    Firebase.prototype.grantPermission = function () { return core.cordova(this, "grantPermission", { "platforms": ["iOS"] }, arguments); };
    Firebase.prototype.hasPermission = function () { return core.cordova(this, "hasPermission", {}, arguments); };
    Firebase.prototype.setBadgeNumber = function (badgeNumber) { return core.cordova(this, "setBadgeNumber", {}, arguments); };
    Firebase.prototype.getBadgeNumber = function () { return core.cordova(this, "getBadgeNumber", {}, arguments); };
    Firebase.prototype.subscribe = function (topic) { return core.cordova(this, "subscribe", {}, arguments); };
    Firebase.prototype.unsubscribe = function (topic) { return core.cordova(this, "unsubscribe", {}, arguments); };
    Firebase.prototype.unregister = function () { return core.cordova(this, "unregister", {}, arguments); };
    Firebase.prototype.logEvent = function (type, data) { return core.cordova(this, "logEvent", {}, arguments); };
    Firebase.prototype.logError = function (message) { return core.cordova(this, "logError", {}, arguments); };
    Firebase.prototype.setScreenName = function (name) { return core.cordova(this, "setScreenName", {}, arguments); };
    Firebase.prototype.setUserId = function (userId) { return core.cordova(this, "setUserId", {}, arguments); };
    Firebase.prototype.setUserProperty = function (name, value) { return core.cordova(this, "setUserProperty", {}, arguments); };
    Firebase.prototype.fetch = function (cacheExpirationSeconds) { return core.cordova(this, "fetch", { "successIndex": 1, "errorIndex": 2 }, arguments); };
    Firebase.prototype.activateFetched = function () { return core.cordova(this, "activateFetched", {}, arguments); };
    Firebase.prototype.getValue = function (key, namespace) { return core.cordova(this, "getValue", { "successIndex": 2, "errorIndex": 3 }, arguments); };
    Firebase.prototype.getByteArray = function (key, namespace) { return core.cordova(this, "getByteArray", { "platforms": ["Android"] }, arguments); };
    Firebase.prototype.getInfo = function () { return core.cordova(this, "getInfo", { "platforms": ["Android"] }, arguments); };
    Firebase.prototype.setConfigSettings = function (settings) { return core.cordova(this, "setConfigSettings", { "platforms": ["Android"] }, arguments); };
    Firebase.prototype.setDefaults = function (defaults, namespace) { return core.cordova(this, "setDefaults", { "platforms": ["Android"] }, arguments); };
    Firebase.prototype.startTrace = function (trace) { return core.cordova(this, "startTrace", {}, arguments); };
    Firebase.prototype.incrementCounter = function (trace, counter) { return core.cordova(this, "incrementCounter", {}, arguments); };
    Firebase.prototype.stopTrace = function (trace) { return core.cordova(this, "stopTrace", {}, arguments); };
    Firebase.prototype.setAnalyticsCollectionEnabled = function (enabled) { return core.cordova(this, "setAnalyticsCollectionEnabled", {}, arguments); };
    Firebase.prototype.setCrashlyticsUserId = function (userId) { return core.cordova(this, "setCrashlyticsUserId", {}, arguments); };
    Firebase.prototype.verifyPhoneNumber = function (phoneNumber, timeoutDuration) {
        if (timeoutDuration === void 0) { timeoutDuration = 0; }
        return core.cordova(this, "verifyPhoneNumber", { "platforms": ["Android", "iOS"], "successIndex": 2, "errorIndex": 3 }, arguments);
    };
    Firebase.prototype.clearAllNotifications = function () { return core.cordova(this, "clearAllNotifications", { "platforms": ["Android"] }, arguments); };
    Firebase.pluginName = "Firebase";
    Firebase.plugin = "cordova-plugin-firebase";
    Firebase.pluginRef = "FirebasePlugin";
    Firebase.repo = "https://github.com/arnesson/cordova-plugin-firebase";
    Firebase.platforms = ["Android", "iOS"];
    Firebase.decorators = [
        { type: core$1.Injectable }
    ];
    return Firebase;
}(core.AwesomeCordovaNativePlugin));

exports.Firebase = Firebase;
