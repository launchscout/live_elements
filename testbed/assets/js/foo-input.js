class FooInput extends HTMLElement {
  static formAssociated = true;

  constructor() {
    super();
    this.elementInternals = this.attachInternals();
    this.attachShadow({mode: 'open'});
    this.shadowRoot.innerHTML = `set ${this.getAttribute('name')} to foo`;
    this.addEventListener('click', () => {
      this.elementInternals.setFormValue('foo');
      new FormData(this.elementInternals.form).forEach(console.log);
    })
  }
}

customElements.define('foo-input', FooInput);