from flask import Flask, json, jsonify, request, Response, Blueprint
from views.product import product
from werkzeug.datastructures import Headers
import jwt
from functools import wraps
import os

app = Flask(__name__)

app.register_blueprint(product, url_prefix='/product')


@app.before_request
def before_request_func():
    print("\n***********************************************")
    print("REQUEST METHOD: ", request.method)
    print("REQUEST HEADERS: ", request.headers)
    if request.method == "GET":
        print("REQUEST PARAMS: ", request.args)
    elif request.method == "POST":
        print("REQUEST PARAMS: ", request.data)
        print("REQUESTED FILES: ", request.files)


@app.after_request
def after_request(response):

    header = response.headers
    header['Access-Control-Allow-Origin'] = os.getenv(
        'ALLOWED_ORIGIN_HOST_PROD')
    header['Access-Control-Allow-Headers'] = '*'
    header['Access-Control-Allow-Methods'] = '*'
    header['Access-Control-Allow-Credentials'] = "true"

    print("RESPONSE STATUS: ", response.status)
    print("RESPONSE HEADERS: ", response.headers)
    print("RESPONSE BODY: ")
    print(response.data, "\n")
    return response
