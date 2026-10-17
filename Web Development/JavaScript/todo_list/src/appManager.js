import { Task } from "./task.js";
import { Project } from "./project.js"; 
import { setupModalListeners } from "./formController.js";
import { renderProjects, renderTodos } from "./domController.js";

class AppManager {
    constructor() {
        this.projects = [];
        this.currentProject = null;
        this.init();// when the app manager is created, it will call the init method to load the projects from local storage
    }
    init() {
        const saved = localStorage.getItem('project');
        if (saved) {
            this.parseAndLoad(saved);}
        else{
            const defaultProject = new Project('Default');
            this.projects.push(defaultProject);
            this.currentProject = defaultProject;
            this.saveToLocalStorage();
        }
    }
    
    addProject(name) {
        const newProject = new Project(name);
        this.projects.push(newProject);
        this.saveToLocalStorage();
        return newProject;
    }

    saveToLocalStorage() {
        localStorage.setItem('project', JSON.stringify(this.projects));
    }

    parseAndLoad(jsonString) {
        const data = JSON.parse(jsonString);
        this.projects=data.map(projectData => {
            const project = new Project(projectData.name);
            project.id = projectData.id;
            project.taskslist = projectData.taskslist.map(taskData => {
                const task = new Task(taskData.Title, taskData.DueDate, taskData.Priority);
                task.id = taskData.id;
                task.completed = taskData.completed;
                return task;
            });
            return project;
        });
        this.currentProject = this.projects[0];
    }}   
export const appManager = new AppManager();

document.addEventListener('DOMContentLoaded', () => {
  setupModalListeners();
    renderProjects();
    renderTodos();
});
