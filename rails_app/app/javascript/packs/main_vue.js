import Vue from 'vue'
import App from '../App.vue'

// document.addEventListener('DOMContentLoaded', () => {
//   const app = new Vue({
//     el: '#list',
//     data: {
//       :
//     },
//     components: { Modal }
//   })
// })

new Vue({
  el: '#app',
  render: h => h(App)
})

// /* eslint no-console: 0 */
// import type {VNode, VueConstructor} from "vue";
// import Vue from "vue";

// // eslint-disable-next-line @typescript-eslint/no-explicit-any
// function mountView(el: Element, component: VueConstructor, properties: any, components: any): void {
//   // eslint-disable-next-line no-new
//   new Vue({
//     components,
//     el,
//     render: (createElement): VNode => {
//       return createElement(component, {props: properties});
//     },
//   });
// }

// interface ComponentMap {
//   [key: string]: VueConstructor | undefined;
// }

// const components: ComponentMap = {};
// const VueMounter = {
//   mount(): void {
//     const els = document.querySelectorAll("[data-vue-component]");
//     for (let i = els.length - 1; i >= 0; i -= 1) {
//       const el = els[i];
//       const componentName = el.getAttribute("data-vue-component")!.replace(/\//gu, "-");
//       const component = components[componentName];
//       const propJson = el.getAttribute("data-vue-properties");
//       const properties = propJson === null ? {} : JSON.parse(propJson);

//       if (component === undefined) {
//         throw `Vue component '${componentName} did not registered.`;
//       }

//       mountView(el, component, properties, {[componentName]: component});
//     }
//   },
//   register(cmps: ComponentMap): void {
//     for (const [name, component] of Object.entries(cmps)) {
//       components[name] = component;
//     }
//   },
// };

// // components 以下の .vue を自動でロードして VueMounter に登録
// // ./components/foo/bar.vue なら data-vue-component="foo/bar" でマウントできる
// // https://vuejs.org/v2/guide/components-registration.html#Automatic-Global-Registration-of-Base-Components
// interface RequireComponent {
//   (fileName: string): VueConstructor | {default: VueConstructor};
//   keys: () => string[];
// }
// interface NodeRequireWithContext extends NodeRequire {
//   context: (a: string, b: boolean, c: regexp) => RequireComponent;
// }
// const requireComponent = (require as NodeRequireWithContext).context(
//   "./components", // The relative path of the components folder
//   true, // Whether or not to look in subfolders
//   /[a-z0-9_]+\.vue$/u, // The regular expression used to match base component filenames
// );

// requireComponent.keys().forEach((fileName: string) => {
//   const componentConfig = requireComponent(fileName);
//   const name = fileName.replace(/^\.\//u, "").replace(/\//gu, "-").replace(/\.vue$/u, "");
//   // eslint-disable-next-line no-prototype-builtins
//   const component = componentConfig.hasOwnProperty("default") ? (componentConfig as {default: VueConstructor}).default : componentConfig as VueConstructor;
//   VueMounter.register({[name]: component});
// });

// export {VueMounter};