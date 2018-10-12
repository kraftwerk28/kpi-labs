<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport"
    content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible"
    content="ie=edge">
  <title>Document</title>
  <style>
    html {
      height: 100%;
    }

    body {
      height: 100%;
      display: flex;
      justify-content: center;
      flex-flow: column nowrap;
      align-items: center;
      background: #333;
      margin: 0px;
    }

    * {
      color: white;
      font-family: monospace;
    }

    button, input {
      color: black;
    }
  </style>
  
</head>

<body>
  <?php
    $db1 = new mysqli('localhost', 'kraftwerk28', '271828', 'kpi_frontend');
    $db1->query("DELETE FROM lab7_articles");
    $info = $db1->query("SELECT * FROM lab7")->fetch_assoc();
    for($i = 0; $i < $info['sections_cnt']; $i++) {
      $title = $_POST["title$i"];
      $text = $_POST["text$i"];
      $date = $_POST["date$i"];
      $db1->query("INSERT INTO lab7_articles
        (title, text)
        VALUES('$title', '$text')");
    }
    $db1->query("DELETE FROM lab7_puncts");
    // $puncts = $db1->query("SELECT * FROM lab7_puncts");
    for($i = 0; $i < $info['punct_num']; $i++) {
      $text = $_POST["menu$i"];
      echo $text;
      $db1->query("INSERT INTO lab7_puncts () VALUE('$text')");
    }

  ?>

  <div>Готово!</div>
  <form action="frontend.php">
    <button type="submit">На сайт</button>
  </form>
  
</body>

</html>
