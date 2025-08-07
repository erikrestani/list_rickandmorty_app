# Rick and Morty Character List App

Uma aplicação Flutter moderna para listar personagens da série Rick and Morty, construída com Clean Architecture e seguindo as melhores práticas e a estrutura mais atual recomendada pela equipe do Flutter.

## 🚀 Funcionalidades

- **Welcome Screen**: Tela de boas-vindas com carregamento manual de personagens
- **Character List**: Lista de personagens com scroll infinito
- **Character Details**: Detalhes completos de cada personagem
- **Filter System**: Sistema de filtros por nome e status
- **Modern UI**: Interface moderna com tema escuro e efeitos neon
- **Error Handling**: Tratamento robusto de erros
- **Loading States**: Estados de carregamento bem definidos

## 🏗️ Arquitetura

O projeto segue os princípios da **Clean Architecture** e adota a estrutura recomendada pelo Flutter para projetos escaláveis, com separação clara entre camadas de apresentação, domínio e dados.

### 📁 Estrutura do Projeto

```
lib/
├── core/
│   ├── config/
│   ├── di/
│   │   └── injection_container.dart
│   ├── theme/
│   │   └── app_theme.dart
│   └── utils/
│       └── status_color_utils.dart
├── features/
│   ├── characters/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   └── models/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── pages/
│   │       ├── viewmodels/
│   │       └── widgets/
│   └── welcome/
│       └── presentation/
│           ├── pages/
│           ├── viewmodels/
│           └── widgets/
├── shared/
│   ├── error_widget.dart
│   ├── loading_widget.dart
│   └── scroll_to_top_button.dart
└── main.dart
```

### 🎯 Camadas da Arquitetura

1. **Presentation Layer**: Widgets, ViewModels e Pages
2. **Domain Layer**: Entities, Use Cases e Repository Interfaces
3. **Data Layer**: Repository Implementations, Data Sources e Models

## 🎨 Design System

### Tema Moderno
- **Dark Theme**: Fundo escuro com cores neon
- **Neon Effects**: Bordas e sombras com efeito neon
- **Material 3**: Interface moderna com Material Design 3
- **Responsive**: Layout responsivo para diferentes tamanhos de tela

### Cores Principais
- `primaryColor`: Azul escuro sutil (#1E293B)
- `secondaryColor`: Azul neon principal (#3B82F6)
- `backgroundColor`: Fundo escuro (#0F172A)
- `textColor`: Texto branco (#FFFFFF)

### 🚧 Compatibilidade
Este aplicativo Flutter é multiplataforma, podendo ser executado tanto em Android quanto em iOS, desde que atendidos os pré-requisitos de ambiente e permissões da plataforma.

💡 Observação: Para executar no iOS, é necessário um dispositivo macOS com Xcode instalado.

## 🧪 Testes

O projeto possui uma cobertura abrangente de testes seguindo as melhores práticas:

### 📊 Cobertura de Testes

```
test/
├── features/
│   ├── characters/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   └── models/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── pages/
│   │       ├── viewmodels/
│   │       └── widgets/
│   └── welcome/
│       └── presentation/
│           ├── pages/
│           ├── viewmodels/
│           └── widgets/
├── helpers/
│   └── test_helper.dart
├── integration/
│   └── app_integration_test.dart
└── widget_test.dart
```

### 🎯 Tipos de Testes

1. **Unit Tests**: Testes unitários para ViewModels, Use Cases e Repositories
2. **Widget Tests**: Testes de widgets individuais
3. **Integration Tests**: Testes de integração da aplicação
4. **Mock Tests**: Testes com mocks para dependências externas

### 📈 Executando Testes

```bash
# Executar todos os testes
flutter test

# Executar testes com cobertura
flutter test --coverage

# Executar testes específicos
flutter test test/features/welcome/presentation/viewmodels/welcome_viewmodel_test.dart
```

## 🚀 Como Executar

### Pré-requisitos
- Flutter SDK 3.8.0 ou superior
- Dart SDK 3.8.0 ou superior
- Android Studio / VS Code

### Instalação

1. **Clone o repositório**
```bash
git clone https://github.com/seu-usuario/list_rickandmorty_app.git
cd list_rickandmorty_app
```

2. **Instale as dependências**
```bash
flutter pub get
```

3. **Execute a aplicação**
```bash
flutter run
```

## 📱 Funcionalidades Detalhadas

### Welcome Screen
- **Carregamento Manual**: Personagens são carregados apenas quando o usuário clica no botão
- **Loading State**: Indicador de carregamento no botão durante o fetch
- **Error Handling**: Tratamento de erros com mensagens específicas
- **Clean UI**: Interface limpa com imagem, título e botão de ação

### Character List
- **Scroll Infinito**: Carregamento automático de mais personagens
- **Loading Centralizado**: Indicador de carregamento centralizado na parte inferior
- **Filter System**: Filtros por nome e status dos personagens
- **Search**: Busca por nome dos personagens

### Character Details
- **Informações Completas**: Dados detalhados de cada personagem
- **Status Indicators**: Indicadores visuais de status (Alive, Dead, Unknown)
- **Navigation**: Navegação fluida entre telas

## 🔧 Tecnologias Utilizadas

- **Flutter**: Framework de desenvolvimento
- **Dio**: Cliente HTTP para requisições
- **GetIt**: Injeção de dependência
- **Mockito**: Framework de mocking para testes
- **Cached Network Image**: Cache de imagens
- **Material Design 3**: Design system moderno

## 📊 API

A aplicação consome a [Rick and Morty API](https://rickandmortyapi.com/) para obter os dados dos personagens.

### Endpoints Utilizados
- `GET /character`: Lista de personagens com paginação
- `GET /character/{id}`: Detalhes de um personagem específico

## 👨‍💻 Autor

**Erik** - Desenvolvedor Flutter

## 🙏 Agradecimentos

- Comunidade Flutter por recursos e documentação
- FTeam pelo desafio técnico 

---

**me aprovem por favor!!** 😄
