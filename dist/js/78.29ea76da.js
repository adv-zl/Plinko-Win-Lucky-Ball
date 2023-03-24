"use strict";(self["webpackChunkonboarding"]=self["webpackChunkonboarding"]||[]).push([[78],{8487:(o,t,e)=>{e.d(t,{a:()=>u,c:()=>m,g:()=>l,s:()=>h});var n=e(6587);
/*!
 * (C) Ionic http://ionicframework.com - MIT License
 */const r="ION-CONTENT",s="ion-content",a=".ion-content-scroll-host",c=`${s}, ${a}`,i=o=>o.tagName===r,l=async o=>i(o)?(await new Promise((t=>(0,n.c)(o,t))),o.getScrollElement()):o,u=o=>o.closest(c),h=(o,t)=>{if(i(o)){const e=o;return e.scrollToTop(t)}return Promise.resolve(o.scrollTo({top:0,left:0,behavior:t>0?"smooth":"auto"}))},m=(o,t,e,n)=>{if(i(o)){const r=o;return r.scrollByPoint(t,e,n)}return Promise.resolve(o.scrollBy({top:e,left:t,behavior:n>0?"smooth":"auto"}))}},6078:(o,t,e)=>{e.r(t),e.d(t,{startStatusTap:()=>a});var n=e(65),r=e(8487),s=e(6587);
/*!
 * (C) Ionic http://ionicframework.com - MIT License
 */
const a=()=>{const o=window;o.addEventListener("statusTap",(()=>{(0,n.wj)((()=>{const t=o.innerWidth,e=o.innerHeight,a=document.elementFromPoint(t/2,e/2);if(!a)return;const c=(0,r.a)(a);c&&new Promise((o=>(0,s.c)(c,o))).then((()=>{(0,n.Iu)((async()=>{c.style.setProperty("--overflow","hidden"),await(0,r.s)(c,300),c.style.removeProperty("--overflow")}))}))}))}))}}}]);
//# sourceMappingURL=78.29ea76da.js.map