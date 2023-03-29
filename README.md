# Google Search

Este é um aplicativo de busca que utiliza uma API para realizar pesquisas no Google e exibir os resultados em uma lista. O usuário pode clicar em um resultado para abrir a página em um WebView.

## Instalação

Para executar o aplicativo, você precisa ter o Flutter instalado em sua máquina. Em seguida, clone este repositório e execute flutter run na raiz do projeto para iniciar o aplicativo no emulador ou dispositivo conectado.

```bash
    git clone https://github.com/tiagocunhadecampos/google-search.git
    cd google-search
    flutter run
```

## Api

Para instalação e rodar a api acessar a pasta api.node e seguir as intruções do README da API.

## Uso

Na tela inicial do aplicativo, o usuário pode inserir um termo de pesquisa na caixa de texto e pressionar o botão de pesquisa ou a tecla "enter" para realizar a pesquisa. Os resultados serão exibidos em uma lista, onde o usuário pode clicar em um item para abrir a página correspondente em um navegador ou WebView.

```O aplicativo realizará uma pesquisa na API como primeira opção. Caso não seja possível acessá-la, a pesquisa será direcionada para a URL do Google como alternativa.```

```Na classe google_search\lib\data\services\search_service.dart, o aplicativo tentará automaticamente pegar o IP da rede. Caso não seja possível, será necessário adicionar manualmente o IP na variável baseUrl. É importante lembrar que, caso o aplicativo esteja sendo executado em um emulador, o IP da rede pode ser diferente do que é esperado.```

## Tecnologias utilizadas

### Flutter v2.10.0
### Dart v2.16.0
