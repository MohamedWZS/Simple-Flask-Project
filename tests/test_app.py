# tests/test_app.py
# This test ensures that the homepage responds with status code 200 and contains the text "Welcome to the Flask Homepage!".
from app import app

def test_homepage():
    tester = app.test_client()
    response = tester.get('/')
    assert response.status_code == 200
    assert b"Welcome to the Flask Homepage!" in response.data

