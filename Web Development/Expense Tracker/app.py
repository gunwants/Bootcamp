from datetime import datetime
from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS

app = Flask(__name__)
CORS(app)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://root:232323@localhost/expense_tracker'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

class Expense(db.Model):
    __tablename__ = 'expenses'

    id = db.Column(db.String(40), primary_key=True)
    title = db.Column(db.String(255), nullable=False)
    amount = db.Column(db.Numeric(10, 2), nullable=False)
    category = db.Column(db.String(100), nullable=False)
    date = db.Column(db.Date, nullable=False)
    note = db.Column(db.Text, nullable=True)
    created_at = db.Column(db.DateTime, server_default=db.func.current_timestamp())

    def to_dict(self):
        return {
            'id': self.id,
            'title': self.title,
            'amount': float(self.amount),
            'category': self.category,
            'date': self.date.isoformat() if self.date else None,
            'note': self.note,
            'created_at': self.created_at.isoformat() if self.created_at else None
        }

# Automatically create tables inside app context
with app.app_context():
    db.create_all()


# --- ROUTES ---

# 1. READ ALL EXPENSES
@app.route('/api/expenses', methods=['GET'])
def get_expenses():
    category = request.args.get('category')
    if category:
        expenses = Expense.query.filter_by(category=category).order_by(Expense.date.desc()).all()
    else:
        expenses = Expense.query.order_by(Expense.date.desc()).all()
    return jsonify([expense.to_dict() for expense in expenses]), 200
@app.route('/api/expenses/<expense_id>', methods=['GET'])
def get_expense(expense_id):
    expense = Expense.query.get_or_404(expense_id)
    return jsonify(expense.to_dict()), 200

@app.route('/api/expenses', methods=['POST'])
def add_expense():
    data = request.get_json() or {}
    
    # Simple validation
    if not data.get('title') or not data.get('amount') or not data.get('date') or not data.get('category'):
        return jsonify({'error': 'Title, amount, category, and date are required fields.'}), 400

    try:
        # Convert incoming 'YYYY-MM-DD' string to Python date object
        parsed_date = datetime.strptime(data.get('date'), '%Y-%m-%d').date()

        expense = Expense(
            id=data.get('id'),
            title=data.get('title'),
            amount=data.get('amount'),
            category=data.get('category'),
            date=parsed_date,
            note=data.get('note')
        )
        
        db.session.add(expense)
        db.session.commit()

        return jsonify({
            'message': 'Expense added successfully',
            'expense': expense.to_dict()
        }), 201

    except ValueError as e:
        return jsonify({'error': f'Invalid date or amount format: {str(e)}'}), 400
@app.route('/api/expenses/<expense_id>', methods=['PUT'])
def update_expense(expense_id):
    expense = Expense.query.get_or_404(expense_id)
    data = request.get_json() or {}

    try:
        if 'title' in data:
            expense.title = data['title']
        if 'amount' in data:
            expense.amount = float(data['amount'])
        if 'date' in data:
            expense.date = datetime.strptime(data['date'], '%Y-%m-%d').date()
        if 'category' in data:
            expense.category = data['category']
        if 'note' in data:
            expense.note = data['note']

        db.session.commit()

        return jsonify({
            'message': 'Expense updated successfully',
            'expense': expense.to_dict()
        }), 200

    except ValueError as e:
        return jsonify({'error': f'Invalid input format: {str(e)}'}), 400

@app.route('/api/expenses', methods=['DELETE'])
def delete_all_expenses():
    Expense.query.delete()
    db.session.commit()
    return jsonify({'message': 'All expenses deleted successfully'}), 200

@app.route('/api/expenses/<expense_id>', methods=['DELETE'])
def delete_expense(expense_id):
    expense = Expense.query.get_or_404(expense_id)
    db.session.delete(expense)
    db.session.commit()
    return jsonify({'message': 'Expense deleted successfully'}), 200


if __name__ == '__main__':
    app.run(debug=True, port=3002)

