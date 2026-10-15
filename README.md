# 📚 Biblioteca FIAP — Controle de Lotação 2.0

Aplicativo Flutter para **gerenciar os acessos da Biblioteca FIAP**. Evolução do Checkpoint 01 (contador de lotação): agora cada leitor é cadastrado com nome e identificação, aparece em uma lista com a data/hora de entrada e a situação, e pode ter a saída registrada ou o registro excluído. A lotação é atualizada em tempo real e respeita a capacidade máxima de **50 pessoas**.

## 🎥 Vídeo de demonstração

▶️ **[Assista ao vídeo](COLE_AQUI_O_LINK_DO_VIDEO)**

## 🏛️ Ambiente escolhido

**Biblioteca** — paleta roxa, tipografia serifada (Merriweather) nos títulos, ícones de livros e o mesmo plano de fundo do Checkpoint 01.

## 👥 Integrantes

| Nome | RM |
|------|----|
| Gianluca Kenis de Araujo | 566765 |
| NOME DO INTEGRANTE 2 | RM |

## ✅ Funcionalidades

- **Cadastro** de leitores com `TextField` + `TextEditingController` (nome, identificação/RM e data/hora do cadastro)
- **Lista** com `ListView.builder` mostrando nome, ID, entrada, saída e situação (*No ambiente* / *Saiu*)
- **Lotação** `presentes / 50` com status do CP01: *Pode entrar*, *Quase lotado*, *Biblioteca lotada*
- **Slidable**: deslize um item para a esquerda → **SAÍDA** ou **EXCLUIR**
- **AlertDialog** de confirmação antes de registrar saída, excluir e limpar registros
- **SnackBar** (`ScaffoldMessenger`) em todas as operações
- **Widget personalizado** `PessoaItem(pessoa: ..., onSaida: ..., onExcluir: ...)` — recebe o objeto e as funções do widget pai
- Datas formatadas com **intl**: `30/09/2026 às 19:35`
- **Ícone do app** personalizado (livro) gerado com `flutter_launcher_icons`

### Regras de negócio

1. **Capacidade** — não permite entrada com o ambiente lotado
2. **Saída** — quem já saiu não pode ter a saída registrada de novo
3. **Cadastro** — nome e identificação são obrigatórios
4. **Identificação** — não aceita duas pessoas com a mesma identificação no ambiente ao mesmo tempo
5. **Feedback** — toda operação mostra um SnackBar

## 🗂️ Estrutura

```
lib/
├── main.dart                     # MaterialApp
├── models/
│   └── pessoa.dart               # classe Pessoa
├── screens/
│   ├── home_page.dart            # lotação, lista e regras
│   └── cadastro_page.dart        # formulário de cadastro
├── widgets/
│   ├── pessoa_item.dart          # item da lista com Slidable
│   ├── lotacao_card.dart         # painel de lotação
│   └── confirmacao_dialog.dart   # AlertDialog reutilizável
└── utils/
    ├── app_colors.dart           # cores em hexadecimal
    ├── app_theme.dart            # tema + Google Fonts
    └── formatadores.dart         # DateFormat (intl)
```

## ▶️ Como executar

```bash
git clone <url-do-repositorio>
cd projeto_cont_fiap
flutter pub get
flutter run
```

Para regerar o ícone do app:

```bash
dart run flutter_launcher_icons
```

## 🛠️ Tecnologias e pacotes

- Flutter / Dart
- [intl](https://pub.dev/packages/intl) — formatação de data e hora
- [google_fonts](https://pub.dev/packages/google_fonts) — Merriweather e Lato
- [flutter_slidable](https://pub.dev/packages/flutter_slidable) — ações ao deslizar
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) — ícone do app
