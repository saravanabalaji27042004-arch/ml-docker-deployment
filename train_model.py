from sklearn.datasets import load_iris
from sklearn.ensemble import RandomForestClassifier
import joblib

# Load the Iris dataset
iris = load_iris()
X = iris.data
y = iris.target

# Train the ML model
model = RandomForestClassifier(
    n_estimators=100,
    random_state=42
)
model.fit(X, y)

# Save the trained model
joblib.dump(
    {
        "model": model,
        "target_names": iris.target_names.tolist()
    },
    "model.pkl"
)

print("ML model trained and saved successfully!")
print("Classes:", iris.target_names)
