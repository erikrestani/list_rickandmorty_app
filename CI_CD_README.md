# 🚀 CI/CD - Testes Automatizados

Sistema simples de testes automatizados para Flutter.

## 📋 O que faz

1. **Baixa o código** do repositório
2. **Instala o Flutter** na versão correta
3. **Instala dependências** do projeto
4. **Executa todos os testes**

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
- 🎯 **Simples e direto**

## 📁 Arquivos

- `.github/workflows/ci.yml` - Testes automáticos
- `.github/workflows/deploy.yml` - Deploy automático (apenas em tags)
- `scripts/test.sh` - Script local

## 🔧 Como funciona

### **Testes (.github/workflows/ci.yml)**
```yaml
- Baixar código
- Instalar Flutter
- Instalar dependências
- Executar testes
```

### **Deploy (.github/workflows/deploy.yml)**
```yaml
- Executa apenas em tags (v*)
- Build APK e App Bundle
- Build Web
- Cria release no GitHub
```

### **Script Local (scripts/test.sh)**
```bash
flutter pub get
flutter test
```

## 🎯 Vantagens

- ✅ **Simples** - Apenas o essencial
- ✅ **Rápido** - Execução direta
- ✅ **Sem duplicação** - Cada workflow tem uma função específica

---

**Simples e eficiente!** 🎉 