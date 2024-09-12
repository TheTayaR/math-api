from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/")
def helloworld():
    return "Hello World!"

@app.post("/avg")
def average():
    data = request.get_json()
    numbers = data.get("numbers", [])
    if not numbers:
        return jsonify({"error": "No numbers provided"}), 400
    avg = sum(numbers) / len(numbers)
    return jsonify({"average": avg})

@app.post("/min")
def minimum():
    data = request.get_json()
    numbers = data.get("numbers", [])
    if not numbers:
        return jsonify({"error": "No numbers provided"}), 400
    min_num = min(numbers)
    return jsonify({"min": min_num})

@app.post("/max")
def maximum():
    data = request.get_json()
    numbers = data.get("numbers", [])
    if not numbers:
        return jsonify({"error": "No numbers provided"}), 400
    max_num = max(numbers)
    return jsonify({"max": max_num})


if __name__ == "__main__":
    app.run(host='0.0.0.0')
