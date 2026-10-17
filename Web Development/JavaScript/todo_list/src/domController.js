import { appManager } from "./appManager.js";
import { format, parseISO } from "date-fns";

export function formatDueDate(dateString) {
  if (!dateString) return 'No due date';
  return format(parseISO(dateString), 'yyyy-MM-dd');
}

export function renderProjects() {
    const projectListContainer = document.getElementById('project-list');
    projectListContainer.innerHTML = '';
    appManager.projects.forEach(project => {
    const li = document.createElement('li');
    li.textContent = project.name;
    if (project === appManager.currentProject) {
      li.classList.add('active');
    }
    li.addEventListener('click', () => {
      appManager.currentProject = project;
      renderProjects();
      renderTodos();
    });
    projectListContainer.appendChild(li);
  });
}
export function renderTodos() {
  const todoContainer = document.querySelector('#todo-container');
  todoContainer.innerHTML = '';

  if (!appManager.currentProject) return;
 
  appManager.currentProject.taskslist.forEach(todo => {
    const card = document.createElement('div');
    card.className = `todo-card priority-${todo.Priority}`;
    card.innerHTML = `
      <h3>${todo.Title}</h3>
      <p>Due: ${formatDueDate(todo.DueDate)}</p>
      <button class="delete-btn">Delete</button>
    `;

    card.querySelector('.delete-btn').addEventListener('click', (e) => {
      e.stopPropagation();
      appManager.currentProject.removeTask(todo.id);
      appManager.saveToLocalStorage();
      renderTodos();
    });

    todoContainer.appendChild(card);
  });
}
