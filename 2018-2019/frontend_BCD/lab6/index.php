<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <link rel="stylesheet"
    href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"
    crossorigin="anonymous">
  
  <script
    src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
    integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
    crossorigin="anonymous"></script>
  <script
    src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
    integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
    crossorigin="anonymous"></script>
  <script
    src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
    integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
    crossorigin="anonymous"></script>
  
  <style>
    body {
      background: #333;
    }

    body > * {
      color: white;
    }

    table * {
      color: white;
    }

    .center {
      display: flex;
      flex-flow: row wrap;
      justify-content: center;
    }

    .center * {
      margin: 0px 5px 0px 5px;
    }

    table {
      width: 75%;
      border-collapse: collapse;
      table-layout: fixed;
    }

    td {
      border: 1px solid white;
      height: 30px;
      transition: all .2s;
    }

    td:hover {
      background: #ddd;
    }

    .container-fluid {
      flex-flow: column nowrap;
    }

    footer {
      position: fixed;
      bottom: 10px;
      right: 10px;
      text-align: left;
      white-space: pre-line;
      writing-mode: vertical-rl;
      transform: rotate(180deg);
    }

    footer span {
      animation-name: br;
      animation-duration: 5s;
      animation-iteration-count: infinite;
    }

    @keyframes br {
      0% {
        text-shadow: 0px 0px 0px #ccc;
      }
      50% {
        text-shadow: 0px 0px 20px #ccc;
      }
    }

    .err {
      color: red;
      font-size: 200%;
    }

  </style>

  <title>Document</title>
</head>

<body>
  <div class="container-fluid d-flex align-items-center">

    <!--form-->
    <div class="d-flex justify-content-center col-8 mb-5">
      <form method="get" class="d-inline-block input-group">
        
        <div class="input-group">
          <div class="input-group-prepend">
            <span class="input-group-text">Рядки:</span>
          </div>
          <input
            value="<?php echo $_GET['input1'] ? $_GET['input1'] : '4'?>"
            class="form-control"
            placeholder="рядки..."
            name="input1">

          <div class="input-group-prepend">
            <span class="input-group-text">Стовпці:</span>
          </div>
          <input
            value="<?php echo $_GET['input2'] ? $_GET['input2'] : '4'?>"
            class="form-control"
            placeholder="стовпці..."
            name="input2">
          <button class="btn btn-primary ml-2" type="submit">Submit</button>  
          
        </div>
        
      </form>
      <form action="http://127.0.0.1:8080/" class="d-inline-block">
        <button class="btn btn-danger ml-2" type="submit">Reset</button>
      </form>  
      
    </div>
    
  
  <?php
  define('db_host', 'localhost');
  define('db_username', 'kraftwerk28');
  define('db_passwd', '271828');
  define('db_name', 'kpi_frontend');
  $ip = $_SERVER['REMOTE_ADDR'];

  $rows = $_GET['input1'];
  $cols = $_GET['input2'];
  $db = new mysqli(db_host, db_username, db_passwd, db_name);
  
  if (!is_numeric($rows) || !is_numeric($cols)) {
    $query = "INSERT INTO lab6_wrong (ip_addr, rows_value, cols_value) VALUES('$ip', '$rows', '$cols')";
    echo "<p class=\"err\">Неправильні значення!</p>";
    $db->query($query);
  } else {
    $rows = (int)$_GET['input1'];
    $cols = (int)$_GET['input2'];
    $query = "INSERT INTO lab6_correct (ip_addr, rows_value, cols_value) VALUES('$ip', $rows, $cols)";
    $db->query($query);
    build_tables($rows, $cols);
  }
  // $rows = $_GET['input1'] ?: _COLS_;
  // $cols = $_GET['input2'] ?: _ROWS_;

  echo "$rows $cols";

  function build_tables($rows, $cols) {
    # simple table
    // echo '<table class="mb-5">';
    // for($i = 0; $i < $rows; $i++) {
    //   echo '<tr>';
    //   for($j = 0; $j < $cols; $j++) {
    //     $num = $i * $cols + $j;
    //     echo "<td>$num</td>";
    //   }
    //   echo '</tr>';
    // }
    // echo '</table>';
    
    # table1
    echo '<table class="mb-5">';
    echo "<tr><td colspan='$rows'/></tr>";
    for($i = 1; $i < $rows; $i++) {
      $colspan = $rows - $i;
      $rowspan = $rows - $i;
      echo "<tr><td rowspan='$rowspan'/><td colspan='$colspan'/></tr>";
    }
    echo '</table>';

    # table2
    echo '<table class="mb-5">';
    for($i = 1; $i < $rows; $i++) {
      $colspan = $rows - $i;
      $rowspan = $rows - $i + 1;
      echo "<tr><td rowspan='$rowspan'/><td colspan='$colspan'/></tr>";
    }
    echo "<tr><td colspan=''/></tr>";
    echo '</table>';

    # table3
    echo '<table class="mb-5">';
    for($i = 0; $i < $rows; $i++) {
      switch($i % 2) {
        case 0:
          echo "<tr><td colspan='2'/><td colspan='2'/><td colspan='1'/></tr>";
          break;
        case 1:
          echo "<tr><td colspan='1'/><td colspan='2'/><td colspan='2'/></tr>";
          break;
      }
      
    }
    echo '</table>';  

    #table4
    echo '<table class="mb-5">';
    for ($i = 0; $i < $rows; $i++) {
      echo '<tr>';
      for ($j = 0; $j < ($i % 2 == 0 ? $cols : $cols - 1); $j++) {
        echo "<td rowspan='2'/>";
      }

      echo '</tr>';
    }
    echo '</table>';
  }
  
  $db->close();

  ?>

  </div>

  <footer>
    виконав:
    <span>Амброс Всеволод</span>
  </footer>

</body>

</html>
