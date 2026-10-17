import {
  addExpense,
  deleteExpense,
  getExpenses,
  getSummary,
  getCategorySummary,
  getExpensesByCategory,
  saveExpenses,
} from "./storage";

export function initApp() {
  setupThemeToggle();
  updateSummary();
  setupTabs();
  setupExpenseForm();
  setupCategoryFilter();
  setupSortAndRender();
  setupResetButton();
}
function setupThemeToggle() {
  const saved = localStorage.getItem("theme");
  if (saved) {
    document.documentElement.setAttribute("data-theme", saved);
  }
  updateThemeIcon();

  document.getElementById("themeToggle").addEventListener("click", () => {
    const current = document.documentElement.getAttribute("data-theme");
    const next = current === "dark" ? "light" : "dark";
    document.documentElement.setAttribute("data-theme", next);
    localStorage.setItem("theme", next);
    updateThemeIcon();
  });
}

function updateThemeIcon() {
  const icon = document.querySelector(".theme-toggle-icon");
  const current = document.documentElement.getAttribute("data-theme");
  icon.textContent = current === "dark" ? "☀️" : "🌙";
}

async function updateSummary() {
  const { total, count, days } = await getSummary();
  document.getElementById("totalExpense").textContent = "₹" + total.toFixed(2);
  document.getElementById("totalTransactions").textContent = count;
  document.getElementById("totalDays").textContent = days;
}

function setupTabs() {
  const tabBtns = document.querySelectorAll(".tab-btn");
  tabBtns.forEach((btn) => {
    btn.addEventListener("click", () => {
      tabBtns.forEach((b) => b.classList.remove("active"));
      btn.classList.add("active");
      document.querySelectorAll(".tab-panel").forEach((p) => p.classList.remove("active"));
      document.getElementById(btn.dataset.tab).classList.add("active");
    });
  });
}

function setupExpenseForm() {
  const form = document.getElementById("expenseForm");
  const dateInput = document.getElementById("expDate");
  dateInput.valueAsDate = new Date();

  form.addEventListener("submit", async (e) => {
    e.preventDefault();
    const fd = new FormData(form);
    const title = fd.get("title").trim();
    const amount = parseFloat(fd.get("amount"));
    const category = fd.get("category");
    const date = fd.get("date");
    const note = fd.get("note").trim();

    if (!title || isNaN(amount) || amount <= 0 || !category || !date) {
      alert("Please fill in all required fields correctly.");
      return;
    }

    await addExpense({ title, amount: amount.toFixed(2), category, date, note });
    form.reset();
    dateInput.valueAsDate = new Date();
    await updateSummary();
    await renderCategoryList();
    await renderHistory();
    alert("Expense added successfully!");
  });
}

function setupCategoryFilter() {
  const form = document.getElementById("categoryFilterForm");
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    renderCategoryList();
  });
  document.getElementById("filterCategory").addEventListener("change", () => {
    renderCategoryList();
  });
  renderCategoryList();
}

function setupSortAndRender() {
  document.getElementById("sortOrder").addEventListener("change", () => {
    renderHistory();
  });
  renderHistory();
}

async function renderCategoryList() {
  const category = document.getElementById("filterCategory").value;
  const [expenses, catSummary] = await Promise.all([
    getExpensesByCategory(category),
    getCategorySummary(),
  ]);

  const summaryEl = document.getElementById("categorySummary");
  const keys = category === "all" ? Object.keys(catSummary) : [category];

  if (keys.length === 0 || (keys.length === 1 && !catSummary[keys[0]])) {
    summaryEl.innerHTML = '<div class="empty-state">No expenses recorded yet.</div>';
    document.getElementById("categoryList").innerHTML = "";
    return;
  }

  summaryEl.innerHTML = keys
    .map((k) => {
      const data = catSummary[k] || { total: 0, count: 0 };
      return `
        <div class="category-card">
          <span class="cat-name">${k}</span>
          <span class="cat-total">₹${data.total.toFixed(2)}</span>
          <span class="cat-count">${data.count} transaction${data.count !== 1 ? "s" : ""}</span>
        </div>`;
    })
    .join("");

  const listEl = document.getElementById("categoryList");
  if (expenses.length === 0) {
    listEl.innerHTML = '<div class="empty-state">No expenses in this category.</div>';
    return;
  }

  listEl.innerHTML = expenses.map((e) => expenseItemHTML(e)).join("");
  attachDeleteListeners(listEl);
}

async function renderHistory() {
  const sort = document.getElementById("sortOrder").value;
  let expenses = await getExpenses();
  expenses.sort((a, b) => {
    const dateA = new Date(a.date);
    const dateB = new Date(b.date);
    return sort === "oldest" ? dateA - dateB : dateB - dateA;
  });
  const listEl = document.getElementById("historyList");

  await renderMonthlyCards();

  if (expenses.length === 0) {
    listEl.innerHTML = '<div class="empty-state">No expenses found.</div>';
    return;
  }

  listEl.innerHTML = expenses.map((e) => expenseItemHTML(e)).join("");
  attachDeleteListeners(listEl);
}

function expenseItemHTML(e) {
  return `
    <div class="expense-item">
      <div class="expense-info">
        <span class="expense-title">${escapeHTML(e.title)}</span>
        <div class="expense-meta">
          <span class="expense-category-badge">${e.category}</span>
          <span>${e.date}</span>
          ${e.note ? `<span>${escapeHTML(e.note)}</span>` : ""}
        </div>
      </div>
      <div class="expense-right">
        <span class="expense-amount">₹${parseFloat(e.amount).toFixed(2)}</span>
        <button class="btn btn-danger btn-sm" data-id="${e.id}">Delete</button>
      </div>
    </div>`;
}

function attachDeleteListeners(container) {
  container.querySelectorAll(".btn-delete, .btn-danger.btn-sm").forEach((btn) => {
    btn.addEventListener("click", async () => {
      const id = btn.dataset.id;
      await deleteExpense(id);
      await updateSummary();
      await renderCategoryList();
      await renderHistory();
    });
  });
}

function escapeHTML(str) {
  const div = document.createElement("div");
  div.textContent = str;
  return div.innerHTML;
}

function setupResetButton() {
  document.getElementById("resetAllExpenses").addEventListener("click", async () => {
    if (confirm("Are you sure you want to delete all expenses? This cannot be undone.")) {
      await saveExpenses();
      await updateSummary();
      await renderCategoryList();
      await renderHistory();
    }
  });
}

function groupByMonth(expenses) {
  const months = {};
  expenses.forEach((e) => {
    const d = new Date(e.date);
    const key = `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}`;
    const label = d.toLocaleString("default", { year: "numeric", month: "long" });
    if (!months[key]) {
      months[key] = { label, total: 0, count: 0, expenses: [] };
    }
    months[key].total += parseFloat(e.amount);
    months[key].count++;
    months[key].expenses.push(e);
  });
  return Object.entries(months).sort((a, b) => b[0].localeCompare(a[0]));
}

async function renderMonthlyCards() {
  const expenses = await getExpenses();
  const container = document.getElementById("monthlyCards");

  if (expenses.length === 0) {
    container.innerHTML = "";
    return;
  }

  const grouped = groupByMonth(expenses);
  container.innerHTML = grouped
    .map(([key, data]) => {
      return `
        <div class="monthly-card">
          <div class="monthly-header">
            <span class="monthly-title">${data.label}</span>
            <span class="monthly-count">${data.count} transaction${data.count !== 1 ? "s" : ""}</span>
          </div>
          <span class="monthly-total">₹${data.total.toFixed(2)}</span>
        </div>`;
    })
    .join("");
}
