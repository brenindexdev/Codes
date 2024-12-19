<?php
// Conexão com o banco de dados
require_once('conexao.php');

// Inicializa variáveis para mensagens de erro e sucesso
$login_error = "";
$signup_success = "";

// LOGIN
if (isset($_POST['login'])) {
    // Captura dados do formulário de login
    $email = mysqli_real_escape_string($dbc, trim($_POST['email']));
    $senha = mysqli_real_escape_string($dbc, trim($_POST['senha']));

    // Verifica se o usuário existe
    $query = "SELECT id, senha FROM cadcli WHERE email = '$email'";
    $result = mysqli_query($dbc, $query);

    if (mysqli_num_rows($result) > 0) {
        $row = mysqli_fetch_assoc($result);
        $senha_banco = $row['senha'];

        // Verifica a senha
        if (password_verify($senha, $senha_banco)) {
            // Inicia a sessão e armazena o ID do usuário
            session_start();
            $_SESSION['usuario_id'] = $row['id'];
            header("Location: painel.php");
            exit();
        } else {
            $login_error = "Senha incorreta.";
        }
    } else {
        $login_error = "Usuário não encontrado.";
    }
}

// CADASTRO
if (isset($_POST['signup'])) {
    // Captura dados do formulário de cadastro
    $nome = mysqli_real_escape_string($dbc, trim($_POST['nome']));
    $sobrenome = mysqli_real_escape_string($dbc, trim($_POST['sobrenome']));
    $cpf = mysqli_real_escape_string($dbc, trim($_POST['cpf']));
    $rg = mysqli_real_escape_string($dbc, trim($_POST['rg']));
    $sexo = mysqli_real_escape_string($dbc, trim($_POST['sexo']));
    $email = mysqli_real_escape_string($dbc, trim($_POST['email']));
    $senha = mysqli_real_escape_string($dbc, trim($_POST['senha']));
    $end_nome = mysqli_real_escape_string($dbc, trim($_POST['end_nome']));
    $end_num = mysqli_real_escape_string($dbc, trim($_POST['end_num']));
    $end_comp = mysqli_real_escape_string($dbc, trim($_POST['end_comp']));
    $cep = mysqli_real_escape_string($dbc, trim($_POST['cep']));
    $bairro = mysqli_real_escape_string($dbc, trim($_POST['bairro']));
    $cidade = mysqli_real_escape_string($dbc, trim($_POST['cidade']));
    $uf = mysqli_real_escape_string($dbc, trim($_POST['uf']));

    // Criptografa a senha
    $senha_criptografada = password_hash($senha, PASSWORD_DEFAULT);

    // Insere os dados do cliente no banco
    $query = "INSERT INTO cadcli (nome, sobrenome, cpf, rg, sexo, email, senha, end_nome, end_num, end_comp, cep, bairro, cidade, uf)
              VALUES ('$nome', '$sobrenome', '$cpf', '$rg', '$sexo', '$email', '$senha_criptografada', '$end_nome', '$end_num', '$end_comp',
               '$cep', '$bairro', '$cidade', '$uf')";
    
    if (mysqli_query($dbc, $query)) {
        $signup_success = "Cadastro realizado com sucesso. Faça login!";
    } else {
        $login_error = "Erro ao cadastrar: " . mysqli_error($dbc);
    }
}

?>

<!doctype html>
<html lang="pt-br">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login e Cadastro</title>

    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">

    <!-- Bootstrap core CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
      @import //url('https://fonts.googleapis.com/css2?family=Exo&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Lato&family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap');

html,
body {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
  width: 100%;
  background-image: url('../img/background1.png');
  background-size: cover; /* Certifica-se de que a imagem cubra todo o fundo */
  background-repeat: no-repeat;
  background-position: center center;
}

main {
    border-radius: 10px;
    border: #621cd4;
    border-style: solid;
    background-color: #ffffff;
}

main:hover {
    box-shadow: #621cd4 0px 0px 20px;
    transition: box-shadow 0.15s ease;
}

.form-signin {
  width: 400px;
  padding: 1rem;
}

h3 {
    font-weight: 600;
    margin-bottom: 20px;
}

.form-floating {
    font-size: 14px;
}

.form-floating {
}

.form-control {
    border-color: rgb(150, 150, 150);
}

.form-control:enabled {
}

.form-control:focus {
    box-shadow: #621cd4 0px 0px 8px;
    border-color: #621cd4;
}

.form-signin input[type="email"] {
  border-bottom-right-radius: 0;
  border-bottom-left-radius: 0;
}

.form-signin input[type="password"] {
  margin-bottom: 10px;
  border-top-left-radius: 0;
  border-top-right-radius: 0;
}

.form-check-label {
    font-weight: 300;
}

.btn {
    font-weight: 600;
    background: linear-gradient(to right, #621cd4, #7e3ce8);
    border-radius: 10px;
    border: #621cd4 font-size: 20px;
    cursor: pointer;
    box-shadow: 0 0 0 0 black;
    transition: all 0.15s ease-in-out;
}

.btn:hover {
    transform: translateY(-4px) translateX(-2px);
    box-shadow: 2px 5px 0 0  rgb(18, 18, 18);
}

.btn:active {
    transform: translateY(2px) translateX(1px);
    box-shadow: 0 0 0 0 black;
}
    </style>
  </head>
  <body>

    <main class="form-signin animate__animated animate__fadeInUp">
        <div class="">
            <div> <a href=".."> <img class="m-1" href="index.php" src="../img/arrow-left-circle.svg">Voltar</a></div>
        </div>

      <form class="text-center mx-auto px-5 pb-5 pt-4" method="POST" action="login_cadastro.php">
        <img class="mb-3" src="../img/logo3.png" alt="" width="150px">
        <h1 class="h3 mb-3 fw-normal">Entrar</h1>

        <?php if ($login_error): ?>
            <div class="alert alert-danger" role="alert">
                <?= $login_error ?>
            </div>
        <?php endif; ?>
        
        <div class="form-floating">
          <input type="email" class="form-control" id="floatingInput" placeholder="name@example.com" name="email" required>
          <label for="floatingInput">Email</label>
        </div>
        <div class="form-floating">
          <input type="password" class="form-control" id="floatingPassword" placeholder="Password" name="senha" required>
          <label for="floatingPassword">Senha</label>
        </div>

        <button class="w-100 btn btn-lg btn-primary" type="submit" name="login">Login</button>
        
        <p class="mt-5 mb-3 text-muted">Não tem uma conta? <a href="#signupModal" data-bs-toggle="modal">Cadastre-se</a></p>
      </form>
    </main>

    <!-- Modal de Cadastro -->
    <div class="modal fade" id="signupModal" tabindex="-1" aria-labelledby="signupModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="signupModalLabel">Cadastro</h1>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <form method="POST" action="login_cadastro.php">
              <div class="mb-3">
                <label for="nome" class="form-label">Nome</label>
                <input type="text" class="form-control" id="nome" name="nome" required>
              </div>
              <div class="mb-3">
                <label for="sobrenome" class="form-label">Sobrenome</label>
                <input type="text" class="form-control" id="sobrenome" name="sobrenome" required>
              </div>
              <div class="mb-3">
                <label for="cpf" class="form-label">CPF</label>
                <input type="text" class="form-control" id="cpf" name="cpf" required>
              </div>
              <div class="mb-3">
                <label for="rg" class="form-label">RG</label>
                <input type="text" class="form-control" id="rg" name="rg" required>
              </div>
              <div class="mb-3">
                <label for="sexo" class="form-label">Sexo</label>
                <select class="form-control" id="sexo" name="sexo" required>
                  <option value="M">Masculino</option>
                  <option value="F">Feminino</option>
                </select>
              </div>
              <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" required>
              </div>
              <div class="mb-3">
                <label for="senha" class="form-label">Senha</label>
                <input type="password" class="form-control" id="senha" name="senha" required>
              </div>
              <div class="mb-3">
                <label for="end_nome" class="form-label">Endereço</label>
                <input type="text" class="form-control" id="end_nome" name="end_nome" required>
              </div>
              <div class="mb-3">
                <label for="end_num" class="form-label">Número</label>
                <input type="text" class="form-control" id="end_num" name="end_num" required>
              </div>
              <div class="mb-3">
                <label for="end_comp" class="form-label">Complemento</label>
                <input type="text" class="form-control" id="end_comp" name="end_comp">
              </div>
              <div class="mb-3">
                <label for="cep" class="form-label">CEP</label>
                <input type="text" class="form-control" id="cep" name="cep" required>
              </div>
              <div class="mb-3">
                <label for="bairro" class="form-label">Bairro</label>
                <input type="text" class="form-control" id="bairro" name="bairro" required>
              </div>
              <div class="mb-3">
                <label for="cidade" class="form-label">Cidade</label>
                <input type="text" class="form-control" id="cidade" name="cidade" required>
              </div>
              <div class="mb-3">
                <label for="uf" class="form-label">Estado</label>
                <input type="text" class="form-control" id="uf" name="uf" required>
              </div>
              <button type="submit" class="btn btn-primary" name="signup">Cadastrar</button>
            </form>
          </div>
        </div>
      </div>
    </div>

    <!-- Bootstrap core JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>

  </body>
</html>
