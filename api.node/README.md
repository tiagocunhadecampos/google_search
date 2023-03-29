# API de Busca no Google

Esta é uma API que utiliza o Puppeteer para fazer uma busca no Google e retorna os resultados em formato JSON.

## Como usar

Para utilizar a API, é necessário ter o Node.js e o NPM instalados. Clone ou baixe este repositório, abra um terminal na pasta do projeto e execute o seguinte comando para instalar as dependências:

```bash
    npm install
```
- Em seguida, execute o seguinte comando para iniciar o servidor:
```bash
    npm start
```
O servidor estará disponível em ```http://localhost:3000``` Para fazer uma busca, basta acessar a URL ```http://localhost:3000/search?q=TERMOS_DE_BUSCA```, substituindo `TERMOS_DE_BUSCA pelos` termos que você deseja buscar.

## Endpoints

```
/search?q={query}
```
Realiza uma busca no Google com base na query informada e retorna um array com os resultados da pesquisa, cada resultado contendo título e link.

Método: GET
Parâmetros de consulta:
q: string com a query de busca
Resposta:
Status: 200 OK
Exemplo de corpo da resposta:

```json
{  
    "title": "Título do resultado da pesquisa",    
    "link": "https://link-do-resultado.com" 
},  ...

```

## Possíveis códigos de erro:

500 Internal Server Error: ocorre se ocorrer um erro interno no servidor ao processar a requisição.

400 Bad Request: ocorre se a query de busca não for informada ou for inválida.

## Tecnologias utilizadas
### Node.js v18.10.0
### Express
### Puppeteer
