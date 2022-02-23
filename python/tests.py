from app import app


def test_today():
    with app.test_client() as cli:
        resp = cli.get('/spendings')
        assert resp.status_code == 200
        assert len(resp.json) == 1
