from flask import Flask, jsonify, request
import os

app = Flask(__name__)


@app.route("/hello", methods=["GET"])
def helloworld():
    if request.method == "GET":
        # Get greeting message from environment variable (ConfigMap)
        greeting = os.environ.get("GREETING_MESSAGE", "Hello World")
        app_name = os.environ.get("APP_NAME", "bonkey-app")
        data = {"data": greeting, "app": app_name, "version": "v1"}
        return jsonify(data)


@app.route("/health", methods=["GET"])
def health():
    return jsonify({"status": "healthy"})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=False)
