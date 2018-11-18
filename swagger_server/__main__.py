#!/usr/bin/env python3

import os
import connexion
from flask import render_template, redirect, url_for
import click
from swagger_server import encoder

app = connexion.App(__name__, specification_dir="./swagger/")
app.app.json_encoder = encoder.JSONEncoder
app.add_api("swagger.yaml", arguments={"title": "The United Nations Treaties REST API"})

# Create a URL route in our application for "/"
@app.route("/")
def home():
    """
    This function just responds to the base URL
    :return:        the rendered template 'home.html'
    """
    return render_template("home.html")


@click.command()
@click.option(
    "--port", default=os.environ.get("PORT"), help="Port of the app to expose"
)
def main(port):
    app.run(host="0.0.0.0", port=port, debug=True)


if __name__ == "__main__":
    main()
