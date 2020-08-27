# README

### Executando o projeto:

Construa a imagem dos containers
```
$ docker-compose build
```

Execute os containers
```
$ docker-compose up -d
```

Instalação de gemas no container da api
```
$ docker-compose run api bundle install
```

Criação do banco de dados
```
$ docker-compose run api rake db:create
```

Excução de migrações do banco
```
$ docker-compose run api rake db:migrate
```

Migração do banco para ambiente de teste
```
$ docker-compose run api rake db:migrate RAILS_ENV=test
```

Executando testes do rspec
```
$ docker-compose run api rspec
```

### Lógica da aplicação

O usuário recebe um token quando cria uma conta de banco e esse token nunca expirar, ele cria uma conta com login e senha, acessa essa conta de login e pode criar várias contas de banco.

Novo fluxo:
1. Usúario cria conta de acesso
2. Usuário faz login com a conta de acesso e recebe um token
3. Usuário utiliza o token para criar uma conta de banco
4. Usuário utiliza o token para fazer tranferências
5. Usuário utiliza o token para visualizar transações em sua conta

Obs: O token de acesso expira a cada 30 minutos.

### Saldo de uma conta

O saldo de uma conta é calculado pela soma dos valores das account_transactions.
Ao criar uma conta uma account_transaction com amount positivo é criado a partir do valor de amount fornecido na hora de criar a conta.


### Valores em reais da aplicação

Os valores em reais da aplicação são representados em inteiro.

Exemplo: R$ 4530,55 -> 453055

### Arquivo do postman com exemplo de rotas:
No projeto está o arquivo accounting_challenge_collection.json com uma coleção de requests que pode ser importada no Postman para testar a api.

### Rota de criação de conta de usuário:
#### Rota: /users
Método: POST

Parâmetros: `<name>, <email>, <password>, <password_confirmation>`

Exemplo de retorno de sucesso: 
```
{
    "id": 6,
    "name": "teste",
    "email": "zaffalonvictor2@gmail.com",
}
```

Exemplo de retorno de falha:
```
{
    "error": "email already exists"
}
```

### Rota de login e recebimento de token:
#### Rota: /login_sessions

Método: POST

Parâmetros: `<email>, <password>`

Exemplo de retorno de sucesso:
```
{
    "token": "8320afbdf7a8be9676924929f73f32be"
}
```

Exemplo de retorno de falha:
```
{
    "message": "invalid_login",
    "code": "invalid_login"
}
```

Exemplo de retorno nos métodos da aplicação quando o token expira:
```
{
    "message": "This token has expired.",
    "code": "invalid_token"
}
```

### Rota de criação de conta do banco:
#### Rota: /accounts

Método: POST

Parâmetros: `<number>, <name>, <amount>`

Headers:

`key: Authorization`, `value: Bearer + token`

Exemplo de retono de sucesso:
```
{
    "id": 7,
    "name": "teste",
    "amount": 80000,
    "available_amount": 80000,
    "number": "45134541",
    "user": {
        "id": 5,
        "name": "teste",
        "email": "zaffalonvictor@gmail.com",
    },
    "account_transactions": [
        {
            "id": 39,
            "amount": 80000,
            "account_id": 7,
            "deleted_at": null,
            "created_at": "2020-05-13T14:17:33.000Z",
            "updated_at": "2020-05-13T14:17:33.000Z"
        }
    ]
}
```

Exemplo de retorno de erro:
```
{
    "amount": [
        "can't be blank"
    ],
    "number": [
        "can't be blank"
    ]
}
```

### Rota de transferência entre contas:
#### Rota: /account_transfers
Método: POST

Parâmetros: `<amount>, <source_account_id>, <destination_account_id>`

Headers:
`key: Authorization`, `value: Bearer + token`

Exemplo de retorno de sucesso:
```
{
    "id": 28,
    "amount": 40000,
    "source_account": {
        "id": 5,
        "name": "teste",
        "amount": 80000,
        "available_amount": 680000,
        "number": null
    },
    "destination_account": {
        "id": 6,
        "name": "teste",
        "amount": 80000,
        "available_amount": -40000,
        "number": "123456"
    }
}
```

Exemplo de retorno de erro:
```
{
    "error": "source account has not enought amount"
}
```

### Rota para obter saldo disponível:
#### Rota: /accounts/:number
Método: Get

Headers:
`key: Authorization`, `value: Bearer + token`

Valor disponível: `available_amount`

Exemplo de retorno de sucesso:
```
{
    "id": 12,
    "name": "teste",
    "amount": 80000,
    "available_amount": 80000,
    "number": "1234720",
    "user": {
        "id": 7,
        "name": "teste usuario",
        "email": "zaffalonvictor7@gmail.com"
    },
    "account_transactions": [
        {
            "id": 78,
            "amount": 80000,
            "account_id": 12,
            "deleted_at": null,
            "created_at": "2020-05-13T16:49:37.000Z",
            "updated_at": "2020-05-13T16:49:37.000Z"
        }
    ]
}
```

Exemplo de retorno de erro:
```
{
    "error": "invalid account number"
}
```


### Rota obter transações da conta:
#### Rota: /account_transactions
Método: Get

Parâmetros: `<account_id>`

Headers:
`key: Authorization`, `value: Bearer + token`

Exemplo de retorno de sucesso:
```
[
    {
        "id": 6,
        "amount": 80000,
        "account_id": 6,
        "deleted_at": null,
        "created_at": "2020-05-11T00:55:15.000Z",
        "updated_at": "2020-05-11T00:55:15.000Z"
    },
    {
        "id": 31,
        "amount": -40000,
        "account_id": 6,
        "deleted_at": null,
        "created_at": "2020-05-11T01:34:23.000Z",
        "updated_at": "2020-05-11T01:34:23.000Z"
    },
    {
        "id": 33,
        "amount": -40000,
        "account_id": 6,
        "deleted_at": null,
        "created_at": "2020-05-11T01:34:25.000Z",
        "updated_at": "2020-05-11T01:34:25.000Z"
    }
]
```




### Gemas utilizadas:
**active_model_serializers**: Criação de serializers de retorno de respostas da api.

**bcrypt**: Autenticação segura com bcrypt usando metodo has_secure_password.

**rspec-rails**: Usado para implementação de teste unitários e de integração.

**factory_bot_rails**: Criação de factories para instanciação de models para implementação dos testes do rspec.

**database_cleaner-active_record**: Limpa o banco de dados antes de cada teste.

**faker**: Generate fake data.
