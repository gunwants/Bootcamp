import { appManager } from "./appManager.js";
import { Task } from "./task.js";
import { renderTodos } from "./domController.js";

export function setupModalListeners() {
  const dialog = document.querySelector('#todo-dialog');
  const openBtn = document.querySelector('#open-todo-modal');
  const cancelBtn = document.querySelector('#cancel-btn');
  const form = document.querySelector('#todo-form');

  if (!dialog || !openBtn || !cancelBtn || !form) return;

  openBtn.addEventListener('click', () => {
    dialog.showModal();
  });

  cancelBtn.addEventListener('click', () => {
    dialog.close();
    form.reset();
  });

  form.addEventListener('submit', (e) => {
    e.preventDefault();

    const title = document.querySelector('#title').value;
    const dueDate = document.querySelector('#due-date').value;
    const priority = document.querySelector('#priority').value;

    const newTask = new Task(title, dueDate, priority);
    appManager.currentProject.addTask(newTask);
    appManager.saveToLocalStorage();
    renderTodos();

    form.reset();
    dialog.close();
  });
}
