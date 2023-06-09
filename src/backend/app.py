from flask import Flask, request, render_template
from sqlalchemy import create_engine, Column, Integer, String
from sqlalchemy.orm import declarative_base
from sqlalchemy.orm import sessionmaker

engine = create_engine('sqlite:///db.db', echo=True)
Session = sessionmaker(bind=engine)
session = Session()


Base = declarative_base()


class Action(Base):
    __tablename__ = "action"

    id = Column(Integer, primary_key=True)
    join = Column(String)
    x = Column(Integer)
    y = Column(Integer)
    z = Column(Integer)

    def __repr__(self):
        return f'join:{self.join}, x:{self.x}, y:{self.y},z:{self.z}'


app = Flask(__name__)
Base.metadata.create_all(engine)

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == "POST":
        x = request.form["x"]
        y = request.form["y"]
        z = request.form["z"]
        join = request.form["join"]
        test = Action(
            join=join,
            x=int(x),
            y=int(y),
            z=int(z)
        )
        print(test)
        tests.append(test)
        session.add(test)
        session.commit()
    return render_template("home.html")


# Sample data
tests = [
    {
        "join": "A",
        "posicoes": [5, 0, 0]
    },
    {
        "join": "B",
        "posicoes": [20, 10, -5]
    },
    {
        "join": "C",
        "posicoes": [-15, -39, 10]
    }
]


@app.route('/posicao', methods=['GET'])
def get_posicao():
    obj = session.query(Action).order_by(Action.id.desc()).first()
    respota = {
        "join": obj.__dict__["join"],
        "posicoes": [obj.__dict__["x"], obj.__dict__["y"], obj.__dict__["z"]]
    }
    return respota, 200


@app.route('/posicoes', methods=['GET'])
def get_posicoes():
    resposta = []
    for u in session.query(Action).all():
        resposta.append({
            "join": u.__dict__["join"],
            "x": u.__dict__["x"],
            "y": u.__dict__["y"],
            "z": u.__dict__["z"]
        })
    return resposta


if __name__ == '__main__':
    app.run(debug=True)
