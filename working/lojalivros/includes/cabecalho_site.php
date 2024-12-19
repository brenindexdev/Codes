<?php
session_start();
?>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="icon" href="../../favicon.ico">

  <title><?php echo $titulo; ?></title>

  <!-- Bootstrap core CSS -->
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap theme -->
  <link href="css/theme.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="css/sticky-footer-navbar.css" rel="stylesheet">
</head>

<style>
  #nav {
    background-color: #621cd4;
  }
</style>

<body>
  <!-- Fixed navbar -->
  <nav id="nav" class="navbar navbar-expand-md fixed-top">
    <a class="navbar-brand col-10" href="index.php"><img src="img/logo4.png" alt="" width="100px"></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="col-3">
      <div class="justify-content-end m-2">
        <a class="m-1" href="cesta.php"> <button class="btn btn-outline-light">Carrinho</button> </a>
        <a class="m-1" href="login/login_cadastro.php"> <button class="btn btn-light">Entrar</button> </a>
      </div>
    </div>
  </nav>

  <!-- Begin page content -->
  <main role="main" class="container">

    <div class="navbar-header navbar-right">
      <!-- ?php include_once ('/menu_superior_inc.php'); ? -->
    </div>

    </div>
    </nav>

    <div class="container theme-showcase" role="main">