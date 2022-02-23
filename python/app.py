from flask import Flask, jsonify
from flask_cors import CORS
from datetime import datetime


app = Flask(__name__)
CORS(app)


@app.route("/spendings", methods=["GET"])
def get_spendings():
    return jsonify([
        {
            "description": "Mango",
            "amount": 1200,
            "spent_at": datetime.now().isoformat(),
            "currency": "USD"
        }
    ])
