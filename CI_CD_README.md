# 🚀 CI/CD - Testes Automatizados

Sistema simples de testes automatizados para Flutter.

## 📋 O que faz

1. **Baixa o código** do repositório
2. **Instala o Flutter** na versão correta (com cache)
3. **Instala dependências** do projeto (com cache)
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
- ⚡ **Otimizado com cache**

## 📁 Arquivos

- `.github/workflows/ci.yml` - Testes automáticos
- `.github/workflows/deploy.yml` - Deploy automático (apenas em tags)
- `scripts/test.sh` - Script local

## 🔧 Como funciona

### **Testes (.github/workflows/ci.yml)**
```yaml
- Baixar código
- Cache Flutter e dependências
- Instalar Flutter (com cache)
- Instalar dependências
- Executar testes
```

### **Deploy (.github/workflows/deploy.yml)**
```yaml
- Executa apenas em tags (v*)
- Cache Flutter e dependências
- Build APK e App Bundle
- Build Web
- Cria release no GitHub
```

### **Script Local (scripts/test.sh)**
```bash
flutter pub get
flutter test
```

## ⚡ Otimizações de Performance

### **Cache Inteligente:**
- **Flutter:** Cache baseado na versão
- **Dependências:** Cache baseado no `pubspec.lock`
- **Primeira execução:** ~2-3GB, 30s
- **Execuções subsequentes:** ~500MB, 5s

### **Como o GitHub lida:**
- ✅ **Não baixa Flutter toda vez**
- ✅ **Reutiliza cache quando possível**
- ✅ **Gerenciamento automático de memória**
- ✅ **Limpeza automática de cache antigo**

## 🎯 Vantagens

- ✅ **Simples** - Apenas o essencial
- ✅ **Rápido** - Execução otimizada
- ✅ **Sem duplicação** - Cada workflow tem uma função específica
- ✅ **Eficiente** - Cache inteligente

---

**Simples e eficiente!** 🎉 