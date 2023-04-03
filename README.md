<table>
<tr>
<td><a href= "https://www.inteli.edu.br/"><img src="https://www.inteli.edu.br/wp-content/uploads/2021/08/20172028/marca_1-2.png" alt="Inteli - Instituto de Tecnologia e Liderança" border="0" width="30%"></a>
</td>
</tr>
</table>


# Simulador de Braço Robótico 
O objetivo deste projeto é conceber e implementar um protótipo de Simulador de Braço Robótico, integrando a um motor gráfico(GODOT) uma API.

## Estrutura do projeto

Abaixo encontra-se a árvore de pastas do repositório:

``` bash
.
├── LICENSE
├── README.md
└── src
    ├── backend
    │   └── README.md
        └── templates
    ├── braco_http
        └── README.md
        └── robo_assets
```

Os principais diretórios do repositório são: 
- A pasta [backend](./backend), onde encontram-se o app principal, responsável pela API.
- A pasta [templates](./backend/templates), onde encontram-se um template de frontend. 
- A pasta [braco_http](./braco_http), armaze todas as depedências responsaveis pela simulação, que inclui: modelo 3D, assets, objetos e o aquivo principal .godot.
- A pasta [src](./src) abriga todos os arquivos de desenvolvimento do projeto.
