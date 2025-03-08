Food App - Aplicativo de Delivery de Comida


Um aplicativo de delivery de comida desenvolvido em Flutter e Dart, utilizando Firebase como banco de dados. O app oferece uma experiência intuitiva para os usuários explorarem cardápios de diferentes categorias (Hambúrguer, Pizza e Sushi), favoritar produtos, adicionar itens ao carrinho e gerenciar pedidos.

Funcionalidades Principais
Autenticação e Perfil do Usuário
Login e Cadastro: Autenticação segura com Firebase Authentication.

Logout: Botão para sair da conta do usuário.

Interface Intuitiva
Tela Inicial:

Banner de comida destacando promoções ou novidades.

Carrossel de produtos populares.

Categorias Cliqueáveis: Navegação fácil entre categorias (Hambúrguer, Pizza, Sushi) para visualizar produtos disponíveis.

Favoritos e Carrinho
Favoritar Produtos: Botão para adicionar ou remover produtos da lista de favoritos.

Carrinho de Compras:

Adicionar e remover produtos.

Cálculo automático do valor total da compra.

Atualização dinâmica ao excluir itens.

Navegação e Usabilidade
Design Responsivo: Interface adaptada para diferentes tamanhos de tela.

Facilidade de Uso: Navegação simples e intuitiva entre telas.

Tecnologias Utilizadas
Flutter: Framework para desenvolvimento multiplataforma.

Dart: Linguagem de programação principal.

Firebase:

Authentication: Para login e cadastro de usuários.

Firestore: Armazenamento de dados de produtos, favoritos e carrinho.

Storage: Armazenamento de imagens dos produtos.

Bibliotecas:

provider: Para gerenciamento de estado.

cached_network_image: Para carregamento eficiente de imagens.

fluttertoast: Para exibição de mensagens rápidas.

Como Executar o Projeto
Pré-requisitos
Flutter: Instale o Flutter seguindo o guia oficial.

Firebase: Crie um projeto no Firebase Console e adicione os arquivos de configuração (google-services.json para Android e GoogleService-Info.plist para iOS).

Passos para Execução
Clone o repositório:

bash
Copy
git clone https://github.com/seu-usuario/food-app.git
cd food-app
Instale as dependências:

bash
Copy
flutter pub get
Execute o aplicativo:

bash
Copy
flutter run
