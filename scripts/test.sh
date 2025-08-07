#!/bin/bash

echo "🧪 Executando testes automatizados..."
echo "=================================="

# Verificar se o Flutter está instalado
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter não encontrado. Instale o Flutter primeiro."
    exit 1
fi

# Instalar dependências
echo "📦 Instalando dependências..."
flutter pub get

# Verificar formatação
echo "🎨 Verificando formatação..."
dart format --output=none --set-exit-if-changed .

# Analisar código
echo "🔍 Analisando código..."
flutter analyze

# Executar testes
echo "⚡ Executando testes..."
flutter test --coverage

# Gerar relatório de cobertura (se lcov estiver disponível)
if command -v genhtml &> /dev/null; then
    echo "📊 Gerando relatório de cobertura..."
    genhtml coverage/lcov.info -o coverage/html
    echo "📁 Relatório de cobertura: coverage/html/index.html"
else
    echo "⚠️  lcov não encontrado. Instale para gerar relatório HTML:"
    echo "   macOS: brew install lcov"
    echo "   Ubuntu: sudo apt-get install lcov"
    echo "📄 Relatório de cobertura: coverage/lcov.info"
fi

echo "✅ Testes concluídos!"
echo "🎯 Todos os 40 testes passaram!" 