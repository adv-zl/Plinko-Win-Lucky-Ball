import { WebPlugin } from '@capacitor/core';
export class InAppBrowserWeb extends WebPlugin {
    async open(options) {
        console.log('open', options);
        return options;
    }
    async openWebView(options) {
        console.log('openWebView', options);
        return options;
    }
    async close() {
        console.log('close');
        return;
    }
    async setUrl(options) {
        console.log('setUrl', options.url);
        return;
    }
}
//# sourceMappingURL=web.js.map