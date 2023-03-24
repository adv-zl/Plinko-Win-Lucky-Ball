'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var tslib = require('tslib');
var core = require('@awesome-cordova-plugins/core');
require('rxjs');
var core$1 = require('@angular/core');

var AppPreferences = /** @class */ (function (_super) {
    tslib.__extends(AppPreferences, _super);
    function AppPreferences() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    AppPreferences.prototype.fetch = function (dict, key) { return core.cordova(this, "fetch", { "callbackOrder": "reverse" }, arguments); };
    AppPreferences.prototype.store = function (dict, key, value) { return core.cordova(this, "store", { "callbackOrder": "reverse" }, arguments); };
    AppPreferences.prototype.remove = function (dict, key) { return core.cordova(this, "remove", { "callbackOrder": "reverse" }, arguments); };
    AppPreferences.prototype.clearAll = function () { return core.cordova(this, "clearAll", { "callbackOrder": "reverse" }, arguments); };
    AppPreferences.prototype.show = function () { return core.cordova(this, "show", { "callbackOrder": "reverse" }, arguments); };
    AppPreferences.prototype.watch = function (subscribe) { return core.cordova(this, "watch", { "observable": true }, arguments); };
    AppPreferences.prototype.suite = function (suiteName) { return core.cordova(this, "suite", { "platforms": ["Android"], "sync": true }, arguments); };
    AppPreferences.prototype.iosSuite = function (suiteName) { return core.cordova(this, "iosSuite", { "platforms": ["iOS"], "sync": true }, arguments); };
    AppPreferences.prototype.cloudSync = function () { return core.cordova(this, "cloudSync", { "platforms": ["iOS", "Windows", "Windows Phone 8"] }, arguments); };
    AppPreferences.prototype.defaults = function () { return core.cordova(this, "defaults", { "platforms": ["iOS", "Windows", "Windows Phone 8"] }, arguments); };
    AppPreferences.pluginName = "AppPreferences";
    AppPreferences.plugin = "cordova-plugin-app-preferences";
    AppPreferences.pluginRef = "plugins.appPreferences";
    AppPreferences.repo = "https://github.com/apla/me.apla.cordova.app-preferences";
    AppPreferences.platforms = ["Android", "BlackBerry 10", "Browser", "iOS", "macOS", "Windows 8", "Windows Phone"];
    AppPreferences.decorators = [
        { type: core$1.Injectable }
    ];
    return AppPreferences;
}(core.AwesomeCordovaNativePlugin));

exports.AppPreferences = AppPreferences;
