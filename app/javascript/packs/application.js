/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import { h, render } from 'preact'
window.render = render;
window.h = h;

import Applet from './applet'
import RatingApplet from './rating'
import PhotosApplet from './photos'
import ColorApplet from './color'

window.RatingApplet = RatingApplet;
window.PhotosApplet = PhotosApplet;
window.ColorApplet = ColorApplet;

window.renderApplet = function(id, options) {
  render(
    h(Applet, options),
    document.getElementById(id)
  );
};
