import { html, css, LitElement } from 'lit'
import { customElement, property, query } from 'lit/decorators.js'

@customElement('simple-guy')
export class SimpleGuyElement extends LitElement {
  @property({attribute: 'first-name'})
  name: string = '';

  @property()
  age: number = 0;

  render() {
    return html`<div>My name is ${this.name} and I am ${this.age} years old.</div>`
  }

}
