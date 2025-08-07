# 🚀 CI/CD - Testes Automatizados

Sistema simples de testes automatizados para Flutter.

## 📋 O que faz

1. **Baixa o código** do repositório
2. **Instala o Flutter** na versão correta
3. **Instala dependências** do projeto
4. **Verifica formatação** do código
5. **Analisa qualidade** do código
6. **Executa todos os testes** (40 testes)
7. **Gera relatório** de cobertura
8. **Salva os resultados**

## 🎯 Quando executa

- Push para `main`
- Pull Request para `main`

## 🛠️ Como usar

### **Localmente**
```bash
./scripts/test.sh
```

### **No GitHub**
Executa automaticamente quando você faz push ou PR.

## 📊 Resultados

- ✅ **40 testes passando**
- 📊 **Relatório de cobertura** salvo
- 🎯 **Qualidade garantida**

## 📁 Arquivos

- `.github/workflows/ci.yml` - Pipeline do GitHub
- `scripts/test.sh` - Script local
- `coverage/` - Relatórios

## 🔧 Como funciona

### **GitHub Actions (.github/workflows/ci.yml)**
```yaml
# 1. Baixar código
- uses: actions/checkout@v4

# 2. Instalar Flutter
- uses: subosito/flutter-action@v2

# 3. Instalar dependências
- run: flutter pub get

# 4. Verificar formatação
- run: dart format --output=none --set-exit-if-changed .

# 5. Analisar código
- run: flutter analyze

# 6. Executar testes
- run: flutter test --coverage

# 7. Verificar cobertura
- run: lcov --summary coverage/lcov.info

# 8. Salvar relatório
- uses: actions/upload-artifact@v4
```

### **Script Local (scripts/test.sh)**
```bash
# Mesmos passos, mas executados localmente
flutter pub get
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test --coverage
lcov --summary coverage/lcov.info
```

## 🎯 Vantagens

- ✅ **Automático** - Não precisa lembrar de executar
- ✅ **Consistente** - Sempre executa os mesmos passos
- ✅ **Rápido** - Detecta problemas logo no início
- ✅ **Simples** - Fácil de entender e manter

---

**Simples e eficiente!** 🎉 