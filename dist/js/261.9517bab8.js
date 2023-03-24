"use strict";(self["webpackChunkonboarding"]=self["webpackChunkonboarding"]||[]).push([[261],{4261:(t,n,e)=>{e.r(n),e.d(n,{MENU_BACK_BUTTON_PRIORITY:()=>a,OVERLAY_BACK_BUTTON_PRIORITY:()=>i,blockHardwareBackButton:()=>r,startHardwareBackButton:()=>o});
/*!
 * (C) Ionic http://ionicframework.com - MIT License
 */
const r=()=>{document.addEventListener("backbutton",(()=>{}))},o=()=>{const t=document;let n=!1;t.addEventListener("backbutton",(()=>{if(n)return;let e=0,r=[];const o=new CustomEvent("ionBackButton",{bubbles:!1,detail:{register(t,n){r.push({priority:t,handler:n,id:e++})}}});t.dispatchEvent(o);const i=async t=>{try{if(null===t||void 0===t?void 0:t.handler){const n=t.handler(a);null!=n&&await n}}catch(n){console.error(n)}},a=()=>{if(r.length>0){let t={priority:Number.MIN_SAFE_INTEGER,handler:()=>{},id:-1};r.forEach((n=>{n.priority>=t.priority&&(t=n)})),n=!0,r=r.filter((n=>n.id!==t.id)),i(t).then((()=>n=!1))}};a()}))},i=100,a=99}}]);
//# sourceMappingURL=261.9517bab8.js.map