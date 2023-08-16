<p align="center">
  <img src="./docs/img/icon_app.png" width="200" alt="Portfolio - Logo" />
</p>
  <p align="center">Projeto de portfólio para o envio de mensagens</p>

## Descrição
Bem-vindo ao meu aplicativo de mensagens! Aqui você poderá enviar e receber mensagens de forma rápida e fácil. Desfrute de uma experiência de comunicação simples e eficiente em um único aplicativo. Fique conectado(a) e compartilhe suas mensagens de maneira conveniente com este app intuitivo e amigável.
0
## Dependência entre módulos
<p align="center">
  <img src="./docs/img/modules.png" width="600" alt="Portfolio - Flutter - Modules" />
</p>

## Estrutura do projeto
Aqui vamos ver a estrutura das requisições para api.

### Registro e geração da chave e seed
Para realizar a comunicação com a api é necessario envio da chave e seed

<p align="center">
  <img src="./img/register_saved_key_seed.png" width="600" alt="Registro e geração da chave e seed" />
</p>

### Inteceptor body
Após realizar o registro da chave, todas as requisições devem encryptar o body antes do envio para a api e seed enviado no header.

<p align="center">
  <img src="./docs/img/inteceptor_body.png" width="600" alt="Inteceptor body" />
</p>

## Tecnologias utilizadas
O app foi desenvolvido usando as seguintes tecnologias:
- Retrofit
- SharedPreference
- Equatable
- Bloc
- Modular
- Flutter_test
- Mockito
- Bloc_test
- HttpMockAdapter

## Autor
- Author - [Raphael Maracaipe](https://www.linkedin.com/in/raphaelmaracaipe)
