import '@vaadin/vertical-layout/src/vaadin-vertical-layout.js';
import '@vaadin/button/src/vaadin-button.js';
import '@vaadin/tooltip/src/vaadin-tooltip.js';
import 'Frontend/generated/jar-resources/disableOnClickFunctions.js';
import '@vaadin/common-frontend/ConnectionIndicator.js';
import 'Frontend/generated/jar-resources/ReactRouterOutletElement.tsx';
import 'react-router';
import 'react';

const loadOnDemand = (key) => {
  const pending = [];
  if (key === '87535b0c6b6b51995be55b6af438b4f7a513b1f820933fab217136edee05d08b') {
    pending.push(import('./chunks/chunk-9df947632b3e42b0088a694d8dc1fa88218dc1c2229c50d3ae83914da61858fd.js'));
  }
  if (key === 'f2c06f8c2aa53c8143d4a85e48704c0efd3cd5e5dd4a5fb3d605e294fc9847f7') {
    pending.push(import('./chunks/chunk-512554ce8c26af165ab8adccd44f0827bd34fe69d6bc363b6a12e7cc3b1c30ee.js'));
  }
  return Promise.all(pending);
}

window.Vaadin = window.Vaadin || {};
window.Vaadin.Flow = window.Vaadin.Flow || {};
window.Vaadin.Flow.loadOnDemand = loadOnDemand;
window.Vaadin.Flow.resetFocus = () => {
 let ae=document.activeElement;
 while(ae&&ae.shadowRoot) ae = ae.shadowRoot.activeElement;
 return !ae || ae.blur() || ae.focus() || true;
}