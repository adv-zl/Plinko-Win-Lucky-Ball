"use strict";(self["webpackChunkonboarding"]=self["webpackChunkonboarding"]||[]).push([[541],{3541:(e,t,i)=>{i.r(t),i.d(t,{KEYBOARD_DID_CLOSE:()=>s,KEYBOARD_DID_OPEN:()=>o,copyVisualViewport:()=>k,keyboardDidClose:()=>l,keyboardDidOpen:()=>w,keyboardDidResize:()=>f,resetKeyboardAssist:()=>h,setKeyboardClose:()=>c,setKeyboardOpen:()=>g,startKeyboardAssist:()=>p,trackViewportChanges:()=>D});
/*!
 * (C) Ionic http://ionicframework.com - MIT License
 */
const o="ionKeyboardDidShow",s="ionKeyboardDidHide",a=150;let d={},n={},r=!1;const h=()=>{d={},n={},r=!1},p=e=>{b(e),e.visualViewport&&(n=k(e.visualViewport),e.visualViewport.onresize=()=>{D(e),w()||f(e)?g(e):l(e)&&c(e)})},b=e=>{e.addEventListener("keyboardDidShow",(t=>g(e,t))),e.addEventListener("keyboardDidHide",(()=>c(e)))},g=(e,t)=>{u(e,t),r=!0},c=e=>{y(e),r=!1},w=()=>{const e=(d.height-n.height)*n.scale;return!r&&d.width===n.width&&e>a},f=e=>r&&!l(e),l=e=>r&&n.height===e.innerHeight,u=(e,t)=>{const i=t?t.keyboardHeight:e.innerHeight-n.height,s=new CustomEvent(o,{detail:{keyboardHeight:i}});e.dispatchEvent(s)},y=e=>{const t=new CustomEvent(s);e.dispatchEvent(t)},D=e=>{d=Object.assign({},n),n=k(e.visualViewport)},k=e=>({width:Math.round(e.width),height:Math.round(e.height),offsetTop:e.offsetTop,offsetLeft:e.offsetLeft,pageTop:e.pageTop,pageLeft:e.pageLeft,scale:e.scale})}}]);
//# sourceMappingURL=541.2308dc13.js.map