import { html, css, LitElement } from 'lit'
import { customElement, property, query } from 'lit/decorators.js'

@customElement('todo-list')
export class TodoListElement extends LitElement {

  @property({type: Array})
  todos: Array<string> = [];
  
  @query("input[name='todo']")
  todoInput: HTMLInputElement | undefined;

  render() {
    return html`
      <div>
        This is my todo list
        <ul>
          ${this.todos?.map(todo => html`<li>${todo}</li>`)}
        </ul>
      </div>
      <div>
        <input name="todo" />
        <button @click=${this.addTodo}>Add Todo</button>
      </div>
    `
  }

  addTodo(_event : Event) {
    this.dispatchEvent(new CustomEvent('add_todo', {detail: {todo: this.todoInput!.value}}));
    this.todoInput!.value = '';
  }
}