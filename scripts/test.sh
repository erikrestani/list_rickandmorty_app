#!/bin/bash

echo "🧪 Executando testes..."

# Verificar se Flutter está instalado
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter não encontrado"
    exit 1
fi

# Instalar dependências
flutter pub get

# Executar testes
flutter test

echo "✅ Concluído!" 