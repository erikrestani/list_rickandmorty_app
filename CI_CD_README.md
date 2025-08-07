# 🚀 CI/CD Simples - Testes Automatizados

Pipeline de CI/CD simples e direto para executar testes automatizados, com espaço para expansão futura.

## ✅ O que faz atualmente

- **Executa todos os testes** (40 testes)
- **Verifica formatação** do código
- **Analisa qualidade** do código
- **Gera relatório** de cobertura
- **Verifica cobertura mínima** de 80%

## 🔮 Expansão Futura

### 📱 **Deploy Automatizado (Futuro)**
O pipeline está preparado para incluir:
- **Google Play Store** - Deploy automático de APK/AAB
- **App Store** - Deploy automático via TestFlight
- **Testes de Performance** - Benchmarks automatizados
- **Análise de Segurança** - Scan de vulnerabilidades

### 🚀 **Como expandir**
```yaml
# Adicionar ao .github/workflows/ci.yml
deploy:
  needs: test
  if: github.ref == 'refs/tags/v*'
  # Configurações de deploy aqui
```

## 📋 Regras de Pull Request

### ✅ **Obrigatório antes do merge**
- [ ] **Todos os testes passando** (40/40)
- [ ] **Cobertura mínima de 80%** mantida
- [ ] **Código formatado** (dart format)
- [ ] **Análise limpa** (flutter analyze)
- [ ] **Review de código** aprovado
- [ ] **Descrição clara** do que foi alterado

### 👥 **Processo de Review**
1. **Criar Pull Request** com descrição detalhada
2. **Aguardar CI/CD** executar automaticamente
3. **Solicitar review** de pelo menos 1 desenvolvedor
4. **Aprovar mudanças** após review
5. **Merge apenas após** aprovação

### 🚫 **Bloqueios Automáticos**
- ❌ CI/CD falhando
- ❌ Cobertura abaixo de 80%
- ❌ Código não formatado
- ❌ Warnings de análise
- ❌ Sem review aprovado

## 🎯 Quando executa

- Push para `main` ou `develop`
- Pull Request para `main` ou `develop`

## 🛠️ Como usar

### **Localmente**
```bash
# Executar tudo
./scripts/test.sh

# Ou manualmente
flutter test --coverage
```

### **No GitHub**
Executa automaticamente em pushes e PRs.

## 📊 Resultados

- ✅ **40 testes passando**
- 📊 **Relatório de cobertura** disponível
- 🎯 **Cobertura mínima**: 80%
- 🔒 **Qualidade garantida** antes do merge

## 📁 Arquivos

- `.github/workflows/ci.yml` - Pipeline do GitHub Actions
- `scripts/test.sh` - Script local
- `coverage/` - Relatórios de cobertura

## 🔧 Configuração de Branch Protection

Configure no GitHub:
- ✅ **Require status checks to pass**
- ✅ **Require branches to be up to date**
- ✅ **Require pull request reviews**
- ✅ **Require review from code owners**
- ✅ **Dismiss stale PR approvals**

---

**Simples, seguro e preparado para o futuro!** 🎉 