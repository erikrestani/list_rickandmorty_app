#!/bin/bash

echo "🧪 Executando testes..."
echo "======================"

# 1. Verificar se Flutter está instalado
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter não encontrado"
    exit 1
fi

# 2. Instalar dependências
echo "📦 Instalando dependências..."
flutter pub get

# 3. Verificar formatação
echo "🎨 Verificando formatação..."
dart format --output=none --set-exit-if-changed .

# 4. Analisar código
echo "🔍 Analisando código..."
flutter analyze

# 5. Executar testes
echo "⚡ Executando testes..."
flutter test --coverage

# 6. Mostrar cobertura
echo "📊 Cobertura de testes:"
lcov --summary coverage/lcov.info

echo "✅ Concluído!" 