from flask import Flask, request, jsonify
import joblib
import os

app = Flask(__name__)

MODEL_PATH = os.path.join(os.path.dirname(__file__), "model.pkl")

# Load the trained ML model
model_data = joblib.load(MODEL_PATH)
model = model_data["model"]
target_names = model_data["target_names"]


@app.route("/", methods=["GET"])
def home():
    return jsonify({
        "message": "Iris ML Prediction API is running!",
        "usage": "Send POST request to /predict"
    })


@app.route("/predict", methods=["POST"])
def predict():
    data = request.get_json(silent=True)

    if not isinstance(data, dict) or "features" not in data:
        return jsonify({
            "error": "Provide 4 flower measurements in 'features'"
        }), 400

    features = data["features"]

    if not isinstance(features, list) or len(features) != 4:
        return jsonify({
            "error": "Exactly 4 numeric measurements are required"
        }), 400

    try:
        values = [float(value) for value in features]
    except (TypeError, ValueError):
        return jsonify({
            "error": "All measurements must be numeric"
        }), 400

    prediction = model.predict([values])[0]

    return jsonify({
        "prediction": str(target_names[prediction])
    })


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
