# Projeto

Trabalho Mobile Engineering 91AOJ

## Descrição

Um app desenvolvido em Flutter para cadastrar lista de compras e adicionar produtos.
Deixamos o arquivo de configuração do Firebase e após a avaliação do trabalho iremos excluir,
dessa forma fica mais simples os teste do App.

## Getting Started

### Dependências

* cupertino_icons: ^1.0.2
* firebase_core: ^2.3.1
* cloud_firestore: ^4.1.0
* firebase_auth: ^4.12.0
* firebase_storage: ^11.4.0

### Instalando

* Clone o repositório
```
git clone https://github.com/adrianoaraujosilva/mobile_engineering_91aoj.git
```

### Executando app

* Instale as depêndencias
```
flutter pub get 
```

* Execute a aplicação
```
flutter run
```

## Débito técnico
- a tela de login está mocada 
usuários: adriano.araujo ou marcely.santello
senha: 1234

- Tivemos problema com o sistema de autenticação por e-mail no Firebase, provavelmente 
por um sistema de proteção(email-enumeration-protection)e não conseguimos desativar a tempo
para testar e entregar a funcionalidade;

- Na tela HOME, o totalizadores para cada compra cadastrada estão mocados não foi possível
concluir a tempo recuperar os dados no documento de produtos no firebase. 

## Autores

Contributors names and contact info

- Adriano Araujo da Silva
[@adrianoaraujosilva](https://github.com/adrianoaraujosilva)

- Marcely Santello
marcelybigsantello Marcely Santello
[@marcelybigsantello](https://github.com/marcelybigsantello)