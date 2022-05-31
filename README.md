# 🚚📦 Sistema de Entregas 🚚📦

[![Ruby](https://badgen.net/badge/icon/ruby?icon=ruby&label)](https://www.ruby-lang.org/pt/)

## <a name='tabela-de-conteudo'></a>Tabela de Conteúdo

* [Descrição](#descrição)
* [Tabela de Conteúdo](#tabela-de-conteudo)
* [Status do Projeto](#status-do-projeto)
* [Features](#features)
* [Pré-requisitos](#pre-requisitos)
* [Como Rodar](#como-rodar)
* [Tecnologias](#tecnologias)
* [Ferramentas](#ferramentas)

##  <a name='descrição'></a>Descrição
O projeto consiste em uma aplicação web de gerenciamento de fretes de um e-commerce. Nela é possível fazer a gestão de transportadoras, seus veículos, suas configurações de preço e de prazo e as ordens de serviço para o transporte de produtos.

Teremos várias transportadoras cadastradas e cada uma delas deverá configurar seus preços de entrega e seus prazos. As transportadoras podem receber ordens de serviço dentro da plataforma. Uma ordem de serviço, quando aceita, deve permitir que um visitante faça o rastreamento de sua entrega através de seu código.

Usuários das transportadoras devem configurar os preços praticados pela transportadora de acordo com a distância e dimensões da carga. Os prazos também devem ser configurados de acordo com a distância a ser percorrida.

O sistema terá usuários administradores que irão cadastrar as transportadoras e fazer consultas de orçamento envolvendo todas as transportadoras cadastradas. Os administradores também serão responsáveis por criar uma nova ordem de serviço para as transportadoras.

### Resumo de Funcionalidades

#### ➡️ Gestão de Transportadoras

Um administrador do sistema deve ser capaz de cadastrar novas transportadoras informando nome fantasia, razão social, domínio dos e-mails (exemplo: minhatransportadora.com.br), CNPJ e endereço para faturamento. Uma transportadora irá receber ordens de serviço para realizar entregas. Para isto é preciso que a transportadora possua uma tabela de preços e prazos configurados.

Uma transportadora pode ser desativada por um administrador do sistema. Neste caso, os usuários da transportadora seguem com acesso à plataforma, mas a transportadora não é mais considerada em novas consultas de preços e, consequentemente, não deve receber novas ordens de serviço.

#### ➡️ Usuários administradores e de transportadoras

O acesso ao sistema é realizado através de um e-mail e uma senha e existem dois tipos de usuários: administradores e usuários de transportadoras. Administradores devem ser usuários com e-mail do domínio @sistemadefrete.com.br.

O usuário de uma transportadora deve ser capaz de acessar somente os dados da sua empresa. Ao criar uma conta no sistema, o sistema deve vincular automaticamente um novo usuário com sua transportadora através do domínio do e-mail informado pelo usuário.

#### ➡️ Cadastro de Veículos

Um usuário da transportadora deve ser capaz de cadastrar os veículos utilizados em suas entregas. Cada cadastro deve armazenar a placa de identificação, a marca e o modelo do veículo, o ano de fabricação e a capacidade máxima de carga (peso).

#### ➡️ Configuração de preços

Cada transportadora deve fazer sua configuração de preços de acordo com as dimensões, peso e distância em km da entrega. Os preços devem considerar o volume em metros cúbicos e o peso do produto e devem ser cadastrados em intervalos. Nesse projeto, optou-se por cadastrar as as configurações de peso separadamente das configurações de volume. Exemplo:

<table style='text-align: center;'>
    <tr>
        <th>Volume (m³)</th>
        <th>Preço por km</th>
    </tr>
    <tr>
        <td>0,001 a 0,500</td>
        <td>R$ 0,20</td>
    </tr>
    <tr>
        <td>0,500 a 1,000</td>
        <td>R$ 0,45</td>
    </tr>
    <tr>
        <td>1,001 a 1,500</td>
        <td>R$ 0,70</td>
    </tr>
</table>

<table style='text-align: center;'>
    <tr>
        <th>Peso (kg)</th>
        <th>Preço por km</th>
    </tr>
    <tr>
        <td>0 a 10,00</td>
        <td>R$ 0,30</td>
    </tr>
    <tr>
        <td>10,01 a 20,00</td>
        <td>R$ 0,55</td>
    </tr>
    <tr>
        <td>20,01 a 30,00</td>
        <td>R$ 0,85</td>
    </tr>
</table>

Além da configuração de preço de acordo com a tabela acima, a transportadora pode determinar um valor mínimo de cobrança de frete baseado exclusivamente na distância percorrida. Ou seja, durante o processo de cálculo de frete deve ser validado o valor mínimo de acordo com a quilometragem, evitando prejuízos.

#### ➡️ Configuração de prazos

Cada transportadora deve fazer sua configuração de prazos de entrega de acordo com a distância entre a origem e o destino. O prazo pode ser calculado como um fator de dias úteis a partir da distância. O cadastro pode ser feito a partir de intervalos de distância, por exemplo: para entregas de 0 a 100km, o prazo é de 2 dias úteis; de 101km a 300km, o prazo é de 5 dias úteis etc.

#### ➡️ Consulta de preços

A aplicação deve permitir aos administradores a realização de consultas de preço de frete. Para isso deverão ser informados: as dimensões do item a ser transportado, o peso e a distância a ser percorrida. Com estas informações deve ser feito o cálculo do frete e retornar todos as transportadoras com suas respectivas taxas de entrega e prazos.

Todas as transportadoras ativas devem ser consideradas, desde que possuam preço configurado que atenda as dimensões e a distância do pedido.

O resultado de uma consulta de preços deve ser armazenado para consultas futuras.

#### ➡️ Criar Ordem de Serviço

Um administrador deve ser capaz de cadastrar uma nova ordem de serviço para uma transportadora. Devem ser informados os dados para retirada do produto (endereço completo, código identificador do produto a ser retirado, dimensões e peso) e as informações para entrega como endereço completo e dados do destinatário.

Uma ordem de serviço recém criada é considerada "pendente de aceite" pela transportadora. Toda ordem de serviço deve possuir um código identificador único gerado automaticamente. O código deve possuir 15 caracteres alfanuméricos e será utilizado para o rastreamento da entrega.

#### ➡️ Atualizar Ordem de Serviço

Usuários da transportadora devem ver todos os pedidos encaminhados para a sua transportadora. Uma ordem de serviço pendente de aceite deve ser aprovada ou reprovada. Ao aprovar um pedido, o usuário deve vincular um veículo da transportadora à ordem de serviço.

Ordens de serviço aprovadas devem receber atualizações de rota. Cada atualização de rota deve conter uma data e hora, além de indicar uma coordenada geográfica de posição do caminhão responsável pela entrega. Ao fim da rota, a ordem de serviço deve ser atualizada como o status "finalizado".

#### ➡️ Consulta de Entrega

Uma pessoa não autenticada deve ser capaz de consultar o status de uma entrega informando o código de rastreamento da entrega. Na página de resultado devem ser exibidos o endereço de saída, o endereço de entrega e todas as atualizações de trajeto existentes.

## Status do Projeto <a name='status-do-projeto'></a><h3 style='text-align: center;'> 🚧 Em construção... 🚧</h3>

## <a name='features'></a>Features

- [x] Cadastro de Transportadoras
- [x] Cadastro de Veículos
- [x] Cadastro de Prazos
- [x] Criar Ordem de Serviço
- [x] Aceitar Ordem de Serviço
- [ ] Rejeitar Ordem de Serviço
- [x] Atualizar detalhes da entrega
- [x] Consulta da Entrega
- [x] Consulta de Orçamento
- [ ] Configuração de Preço Mínimo

## <a name='pre-requisitos'></a>Pré-requisitos

Antes de começar, será necessário instalar o seguinte:
- [Git](https://git-scm.com/)
- [Ruby](https://www.ruby-lang.org/pt/)

Se o Sistema Operacional for Windows, deverá ser instalado e configurado o WSL (Subsistema Windows para Linux):
- [WSL (Subsistema Windows para Linux)](https://docs.microsoft.com/pt-br/windows/wsl/)

Além disso, será necessário instalar ainda algum editor de código. Algumas opções são:
- [Visual Studio Code](https://code.visualstudio.com/)
- [Sublime](https://www.sublimetext.com/)

## <a name='como-rodar'></a>Como Rodar

Para rodar a aplicação, será necessário executar os seguintes comandos:
```bash
# Clone esse repositório:
git clone git@github.com:sergiogurg/freight-app.git

# Acesse a pasta do repositório no terminal/cmd:
cd freight-app

# Adicione gems e dependências:
bin/setup

# Preencha o banco de dados:
rails db:seed

# Execute o servidor:
rails server
```

O servidor inciará na porta 3000 - acesse <http://localhost:3000> 

## <a name='tecnologias'></a>Tecnologias

As seguintes tecnologias foram usadas na construção do projeto:

- [Ruby 3.1.2](https://www.ruby-lang.org/pt/)
- [Rails 7.0.3](https://rubyonrails.org/)
- [HTML](https://developer.mozilla.org/pt-BR/docs/Web/HTML)

As gems destinadas aos testes de sistema e testes unitários foram:
- [rspec](https://rspec.info/)
- [capybara](https://github.com/teamcapybara/capybara)

## <a name='ferramentas'></a>Ferramentas
As seguintes ferramentas foram usadas na construção do projeto:
- [MindMeister](https://www.mindmeister.com/) - Ferramenta online de mapas mentais

O mapa mental desse projeto pode ser acessado por [aqui](https://www.mindmeister.com/).