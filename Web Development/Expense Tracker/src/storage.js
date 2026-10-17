const API_URL = "/api/expenses";

async function request(url, options = {}) {
  const res = await fetch(url, options);
  if (!res.ok) {
    const body = await res.json().catch(() => ({}));
    throw new Error(body.error || "Request failed");
  }
  return res.json();
}

export async function getExpenses() {
  return request(API_URL);
}

export async function saveExpenses() {
  await request(API_URL, { method: "DELETE" });
}

export async function addExpense(expense) {
  expense.id =
    Date.now().toString(36) +
    Math.random().toString(36).slice(2, 7);

  await request(API_URL, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(expense),
  });

  return expense;
}

export async function deleteExpense(id) {
  await request(`${API_URL}/${id}`, { method: "DELETE" });
  return getExpenses();
}

export async function getExpensesByCategory(category) {
  const url =
    !category || category === "all"
      ? API_URL
      : `${API_URL}?category=${encodeURIComponent(category)}`;
  return request(url);
}

export async function getSummary() {
  const expenses = await getExpenses();

  const total = expenses.reduce(
    (sum, e) => sum + parseFloat(e.amount),
    0
  );

  const count = expenses.length;

  const uniqueDates = new Set(
    expenses.map((e) => e.date)
  );

  return {
    total,
    count,
    days: uniqueDates.size
  };
}

export async function getCategorySummary() {
  const expenses = await getExpenses();
  const summary = {};

  expenses.forEach((e) => {
    if (!summary[e.category]) {
      summary[e.category] = {
        total: 0,
        count: 0
      };
    }

    summary[e.category].total += parseFloat(e.amount);
    summary[e.category].count += 1;
  });

  return summary;
}
