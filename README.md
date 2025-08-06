# Rick and Morty App

Aplicativo Flutter desenvolvido para teste técnico da FTeam, consumindo a [Rick and Morty API](https://rickandmortyapi.com/) com foco em arquitetura limpa (Clean Architecture), princípios SOLID e organização modular por feature.

---

## 🚀 Funcionalidades

- 📱 Listagem de personagens com imagens e nomes
- 🔍 Exibição de status e espécie de cada personagem
- 🌐 Consumo real da Rick and Morty API
- 🎯 Estrutura baseada em MVVM + Clean Architecture
- 💡 Código limpo, escalável e de fácil manutenção
- 🧪 Testes unitários, de widget e integração
- 🎨 Tema centralizado e responsivo
- 🔧 Injeção de dependência com GetIt
- 📱 App icon personalizado

---

## 📁 Estrutura do Projeto (Clean Architecture)

```plaintext
lib/
├── core/                         # Configurações globais
│   ├── di/                       # Injeção de dependência
│   │   └── injection_container.dart
│   ├── theme/                    # Tema centralizado
│   │   └── app_theme.dart
│   └── utils/                    # Utilitários
│       └── status_color_utils.dart
├── features/
│   └── characters/               # Módulo principal
│       ├── data/
│       │   ├── datasources/
│       │   │   ├── character_remote_datasource.dart
│       │   │   └── character_remote_datasource_impl.dart
│       │   ├── models/
│       │   │   └── character_model.dart
│       │   └── repositories/
│       │       └── character_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── character.dart
│       │   ├── repositories/
│       │   │   └── character_repository.dart
│       │   └── usecases/
│       │       └── get_characters.dart
│       └── presentation/
│           ├── pages/
│           │   └── character_list_page.dart
│           ├── viewmodels/       # MVVM - lógica da tela
│           │   └── character_viewmodel.dart
│           └── widgets/
│               └── character_card.dart
├── assets/                       # Recursos do app
│   └── app_icon.png
└── main.dart

test/
├── features/                     # Testes organizados por feature
│   └── characters/
│       ├── domain/               # Testes de entidades
│       │   └── entities/
│       │       └── character_test.dart
│       └── presentation/         # Testes de widgets
├── integration/                  # Testes de integração
│   └── app_integration_test.dart
├── helpers/                      # Helpers para testes
│   └── test_helper.dart
└── widget_test.dart              # Teste principal do widget
```

---

## 🧱 Arquitetura Utilizada

O projeto adota a nova arquitetura recomendada pela equipe Flutter, combinando o padrão MVVM (Model-View-ViewModel) com os princípios da Clean Architecture.

Essa estrutura facilita a testabilidade, manutenção e escalabilidade do código, e segue as boas práticas descritas na documentação oficial do Flutter.

### ✅ Princípios Aplicados:

- **MVVM**: Separação clara entre camada de apresentação (View), lógica da tela (ViewModel) e dados
- **Clean Architecture**:
  - `domain`: entidades, casos de uso e interfaces de repositório
  - `data`: modelos, datasources e implementações de repositório
  - `presentation`: UI, ViewModels e widgets
- **Modularização por feature**: cada módulo possui suas próprias camadas isoladas
- **Injeção de dependência**: feita via GetIt no arquivo `injection_container.dart`
- **Tema centralizado**: cores e estilos organizados em `AppTheme`
- **Testes automatizados**: unitários, widgets e integração
- **Responsabilidade única em cada classe** (S de SOLID)

### 🎯 Tecnologias Utilizadas:

- **Flutter**: Framework principal
- **Dio**: Cliente HTTP para requisições à API
- **GetIt**: Injeção de dependência
- **Provider**: Gerenciamento de estado (MVVM)
- **flutter_launcher_icons**: Geração de ícones do app

---

## 🚀 Como Executar

### Pré-requisitos:
- Flutter SDK 3.8.0 ou superior
- Dart SDK 3.0.0 ou superior

### Passos:
1. **Clone o repositório:**
   ```bash
   git clone https://github.com/erikrestani/test_fteam.git
   cd test_fteam
   ```

2. **Instale as dependências:**
   ```bash
   flutter pub get
   ```

3. **Execute o app:**
   ```bash
   flutter run
   ```

---

## 🧪 Testes

### Executar todos os testes:
```bash
flutter test
```

### Executar testes específicos:
```bash
# Testes de uma feature
flutter test test/features/characters/

# Testes de integração
flutter test test/integration/

# Teste específico
flutter test test/features/characters/domain/entities/character_test.dart
```

### Cobertura de testes:
```bash
flutter test --coverage
```

---

## 📱 Funcionalidades Implementadas

### ✅ **Camada de Apresentação:**
- **CharacterListPage**: Lista de personagens com design responsivo
- **CharacterCard**: Widget reutilizável para exibir personagens
- **CharacterViewModel**: Gerenciamento de estado MVVM

### ✅ **Camada de Domínio:**
- **Character**: Entidade principal do domínio
- **CharacterRepository**: Interface para acesso a dados
- **GetCharacters**: Caso de uso para buscar personagens

### ✅ **Camada de Dados:**
- **CharacterModel**: Modelo de dados com serialização JSON
- **CharacterRemoteDatasource**: Interface para API
- **CharacterRemoteDatasourceImpl**: Implementação com Dio
- **CharacterRepositoryImpl**: Implementação do repositório

### ✅ **Infraestrutura:**
- **Dependency Injection**: Configuração com GetIt
- **AppTheme**: Sistema de tema centralizado
- **Testes**: Cobertura completa de todas as camadas
- **App Icon**: Ícone personalizado gerado automaticamente
