# Rick and Morty App

Aplicativo Flutter desenvolvido para teste técnico da FTeam, consumindo a [Rick and Morty API](https://rickandmortyapi.com/) com foco em arquitetura limpa (Clean Architecture), princípios SOLID e organização modular por feature.

---

## 🚀 Funcionalidades

- 📱 Listagem de personagens com imagens e nomes
- 🔍 Tela de detalhes com status e espécie de cada personagem
- 🌐 Consumo de API REST pública
- 🎯 Estrutura baseada em MVVM + Clean Architecture
- 💡 Código limpo, escalável e de fácil manutenção

---

## 📁 Estrutura do Projeto (por Feature)

```plaintext
lib/
├── core/                         # Configurações globais
│   ├── di/                       # Injeção de dependência
│   │   └── injection_container.dart
│   └── theme/                    # AppTheme e estilos
│       └── app_theme.dart
├── features/
│   └── characters/               # Módulo principal
│       ├── data/
│       │   ├── datasources/
│       │   │   └── character_remote_datasource.dart
│       │   ├── models/
│       │   │   └── character_model.dart
│       │   └── repositories_impl/
│       │       └── character_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── character.dart
│       │   ├── repositories/
│       │   │   └── character_repository.dart
│       │   └── usecases/
│       │       ├── get_characters.dart
│       │       └── get_character_by_id.dart
│       └── presentation/
│           ├── pages/
│           │   ├── home_page.dart
│           │   └── character_detail_page.dart
│           ├── viewmodels/       # MVVM - lógica da tela
│           │   └── character_viewmodel.dart
│           └── widgets/
│               └── character_card.dart
├── shared/                       # Widgets reutilizáveis
└── main.dart

```

---

## 🧱 Arquitetura Utilizada

O projeto adota a nova arquitetura recomendada pela equipe Flutter, combinando o padrão MVVM (Model-View-ViewModel) com os princípios da Clean Architecture.

Essa estrutura facilita a testabilidade, manutenção e escalabilidade do código, e segue as boas práticas descritas na documentação oficial do Flutter.

### ✅ Princípios Aplicados:

- **MVVM**: Separação clara entre camada de apresentação (View), lógica da tela (ViewModel) e dados
- **Camadas Clean Architecture**:
  - `domain`: entidades e casos de uso
  - `data`: modelos, datasources e repositórios
  - `presentation`: UI + ViewModels
- **Modularização por feature**: cada módulo possui suas próprias camadas isoladas
- **Injeção de dependência**: feita via GetIt no arquivo `injection_container.dart`
- **Responsabilidade única em cada classe** (S de SOLID)
