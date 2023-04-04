<table>
<tr>
<td><a href= "https://www.inteli.edu.br/"><img src="https://www.inteli.edu.br/wp-content/uploads/2021/08/20172028/marca_1-2.png" alt="Inteli - Instituto de Tecnologia e Liderança" border="0" width="30%"></a>
</td>
</tr>
</table>


# Desenvolvimento da API
O objetivo deste projeto é conceber e implementar um protótipo de Simulador de Braço Robótico, integrando a um motor gráfico(GODOT) uma API.

## Banco de Dados
<p>Para esse projeto optei por usar a ORM sqlAlchemy e o banco de dados sqlite. </p>
<a href= "../../DB.png"><img  src="../../DB.png" alt="Inteli - Instituto de Tecnologia e Liderança" border="0" width="30%"></a>
<br>
<p>A tabela <i>Action</i> é a responsável por conter todas as informaçãos necessárias para movimentação do robô.</p>

## Rotas

### 127.0.0.1:5000/
<p>Essa é a rota inicial, serve para retornar a home da aplicação que contem um form para fazer post do join e das posições.</p>
<a href= "../../home.png"><img  src="../../home.png" alt="Inteli - Instituto de Tecnologia e Liderança" border="0" width="30%"></a>

### 127.0.0.1:5000/posicoes
<p>Essa rota serve para retornar todas as posições do banco de dados.</p>
<a href= "../../posicoes.png"><img  src="../../posicoes.png" alt="Inteli - Instituto de Tecnologia e Liderança" border="0" width="30%"></a>

### 127.0.0.1:5000/posicao
<p>Essa rota serve para retornar a última posição do banco de dados.</p>
<a href= "../../posicao.png"><img  src="../../posicao.png" alt="Inteli - Instituto de Tecnologia e Liderança" border="0" width="30%"></a>

