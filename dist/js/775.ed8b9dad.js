"use strict";(self["webpackChunkonboarding"]=self["webpackChunkonboarding"]||[]).push([[775],{8487:(e,t,n)=>{n.d(t,{a:()=>d,c:()=>m,g:()=>c,s:()=>u});var o=n(6587);
/*!
 * (C) Ionic http://ionicframework.com - MIT License
 */const r="ION-CONTENT",i="ion-content",s=".ion-content-scroll-host",a=`${i}, ${s}`,l=e=>e&&e.tagName===r,c=async e=>l(e)?(await new Promise((t=>(0,o.c)(e,t))),e.getScrollElement()):e,d=e=>e.closest(a),u=(e,t)=>{if(l(e)){const n=e;return n.scrollToTop(t)}return Promise.resolve(e.scrollTo({top:0,left:0,behavior:t>0?"smooth":"auto"}))},m=(e,t,n,o)=>{if(l(e)){const r=e;return r.scrollByPoint(t,n,o)}return Promise.resolve(e.scrollBy({top:n,left:t,behavior:o>0?"smooth":"auto"}))}},8775:(e,t,n)=>{n.r(t),n.d(t,{startInputShims:()=>N});var o=n(8487),r=n(6587);
/*!
 * (C) Ionic http://ionicframework.com - MIT License
 */
const i=new WeakMap,s=(e,t,n,o=0)=>{i.has(e)!==n&&(n?l(e,t,o):c(e,t))},a=e=>e===e.getRootNode().activeElement,l=(e,t,n)=>{const o=t.parentNode,r=t.cloneNode(!1);r.classList.add("cloned-input"),r.tabIndex=-1,o.appendChild(r),i.set(e,r);const s=e.ownerDocument,a="rtl"===s.dir?9999:-9999;e.style.pointerEvents="none",t.style.transform=`translate3d(${a}px,${n}px,0) scale(0)`},c=(e,t)=>{const n=i.get(e);n&&(i.delete(e),n.remove()),e.style.pointerEvents="",t.style.transform=""},d=(e,t,n)=>{if(!n||!t)return()=>{};const o=n=>{a(t)&&s(e,t,n)},i=()=>s(e,t,!1),l=()=>o(!0),c=()=>o(!1);return(0,r.a)(n,"ionScrollStart",l),(0,r.a)(n,"ionScrollEnd",c),t.addEventListener("blur",i),()=>{(0,r.b)(n,"ionScrollStart",l),(0,r.b)(n,"ionScrollEnd",c),t.addEventListener("ionBlur",i)}},u="input, textarea, [no-blur], [contenteditable]",m=()=>{let e=!0,t=!1;const n=document,o=()=>{t=!0},i=()=>{e=!0},s=o=>{if(t)return void(t=!1);const r=n.activeElement;if(!r)return;if(r.matches(u))return;const i=o.target;i!==r&&(i.matches(u)||i.closest(u)||(e=!1,setTimeout((()=>{e||r.blur()}),50)))};return(0,r.a)(n,"ionScrollStart",o),n.addEventListener("focusin",i,!0),n.addEventListener("touchend",s,!1),()=>{(0,r.b)(n,"ionScrollStart",o,!0),n.removeEventListener("focusin",i,!0),n.removeEventListener("touchend",s,!1)}},f=.3,v=(e,t,n)=>{const o=e.closest("ion-item,[ion-item]")||e;return p(o.getBoundingClientRect(),t.getBoundingClientRect(),n,e.ownerDocument.defaultView.innerHeight)},p=(e,t,n,o)=>{const r=e.top,i=e.bottom,s=t.top,a=Math.min(t.bottom,o-n),l=s+15,c=.75*a,d=c-i,u=l-r,m=Math.round(d<0?-d:u>0?-u:0),v=Math.min(m,r-s),p=Math.abs(v),h=p/f,w=Math.min(400,Math.max(150,h));return{scrollAmount:v,scrollDuration:w,scrollPadding:n,inputSafeY:4-(r-l)}},h=(e,t,n,o,i)=>{let s;const l=e=>{s=(0,r.q)(e)},c=l=>{if(!s)return;const c=(0,r.q)(l);E(6,s,c)||a(t)||w(e,t,n,o,i)};return e.addEventListener("touchstart",l,{capture:!0,passive:!0}),e.addEventListener("touchend",c,!0),()=>{e.removeEventListener("touchstart",l,!0),e.removeEventListener("touchend",c,!0)}},w=async(e,t,n,i,a)=>{if(!n&&!i)return;const l=v(e,n||i,a);if(n&&Math.abs(l.scrollAmount)<4)t.focus();else if(s(e,t,!0,l.inputSafeY),t.focus(),(0,r.r)((()=>e.click())),"undefined"!==typeof window){let r;const i=async()=>{void 0!==r&&clearTimeout(r),window.removeEventListener("ionKeyboardDidShow",a),window.removeEventListener("ionKeyboardDidShow",i),n&&await(0,o.c)(n,0,l.scrollAmount,l.scrollDuration),s(e,t,!1,l.inputSafeY),t.focus()},a=()=>{window.removeEventListener("ionKeyboardDidShow",a),window.addEventListener("ionKeyboardDidShow",i)};if(n){const e=await(0,o.g)(n),s=e.scrollHeight-e.clientHeight;if(l.scrollAmount>s-e.scrollTop)return"password"===t.type?(l.scrollAmount+=50,window.addEventListener("ionKeyboardDidShow",a)):window.addEventListener("ionKeyboardDidShow",i),void(r=setTimeout(i,1e3))}i()}},E=(e,t,n)=>{if(t&&n){const o=t.x-n.x,r=t.y-n.y,i=o*o+r*r;return i>e*e}return!1},g="$ionPaddingTimer",y=e=>{const t=document,n=t=>{b(t.target,e)},o=e=>{b(e.target,0)};return t.addEventListener("focusin",n),t.addEventListener("focusout",o),()=>{t.removeEventListener("focusin",n),t.removeEventListener("focusout",o)}},b=(e,t)=>{var n,r;if("INPUT"!==e.tagName)return;if(e.parentElement&&"ION-INPUT"===e.parentElement.tagName)return;if("ION-SEARCHBAR"===(null===(r=null===(n=e.parentElement)||void 0===n?void 0:n.parentElement)||void 0===r?void 0:r.tagName))return;const i=(0,o.a)(e);if(null===i)return;const s=i[g];s&&clearTimeout(s),t>0?i.style.setProperty("--keyboard-offset",`${t}px`):i[g]=setTimeout((()=>{i.style.setProperty("--keyboard-offset","0px")}),120)},S=!0,L=!0,N=e=>{const t=document,n=e.getNumber("keyboardHeight",290),i=e.getBoolean("scrollAssist",!0),s=e.getBoolean("hideCaretOnScroll",!0),a=e.getBoolean("inputBlurring",!0),l=e.getBoolean("scrollPadding",!0),c=Array.from(t.querySelectorAll("ion-input, ion-textarea")),u=new WeakMap,f=new WeakMap,v=async e=>{await new Promise((t=>(0,r.c)(e,t)));const t=e.shadowRoot||e,a=t.querySelector("input")||t.querySelector("textarea"),l=(0,o.a)(e),c=l?null:e.closest("ion-footer");if(!a)return;if(l&&s&&!u.has(e)){const t=d(e,a,l);u.set(e,t)}const m="date"===a.type||"datetime-local"===a.type;if(!m&&(l||c)&&i&&!f.has(e)){const t=h(e,a,l,c,n);f.set(e,t)}},p=e=>{if(s){const t=u.get(e);t&&t(),u.delete(e)}if(i){const t=f.get(e);t&&t(),f.delete(e)}};a&&S&&m(),l&&L&&y(n);for(const o of c)v(o);t.addEventListener("ionInputDidLoad",(e=>{v(e.detail)})),t.addEventListener("ionInputDidUnload",(e=>{p(e.detail)}))}}}]);
//# sourceMappingURL=775.ed8b9dad.js.map