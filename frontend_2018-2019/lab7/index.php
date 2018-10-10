<!-- SERVER SIDE -->
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport"
    content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible"
    content="ie=edge">

  <style>
    p {
      margin-top: 0px;
      margin-bottom: 0px; 
    }
    
    .form-container {
      display: flex;
      flex-flow: column nowrap;
      align-items: center;
    }

    /* .form-container > p + * {
      margin: 0px 0px 0px 0px;
    } */
  </style>

  <title>Document</title>
</head>

<body>
  <?php
    $db = new mysqli('localhost', 'kraftwerk28', '271828', 'kpi_frontend');
    $res = $db->query("SELECT * FROM lab7");
    $sitedata = $res->fetch_array();

    function get_title() {
      $v = $GLOBALS['sitedata'][0];
      return $v ? $v : 'none';
    }

    function get_puncts_cnt() {
      $v = $GLOBALS['sitedata'][0];
      return $v ? $v : '4';
    }
  
    $db->close();
    // require './frontend.html';
  ?>
  <form method="post"
    class="form-container"
    action="article_edit.php">
    <p>Заголовок статті:</p>
    <input type="text"
      placeholder="Заголовок"
      size="20"
      value="<?php echo $sitedata[0] ?: 'none'?>"
      name="title_text">
    <p>Кількість пунктів меню:</p>
    <input type="number"
      name="puncts_cnt"
      value="<?php echo $sitedata[1] ?: '3'?>"
      min="1"
      max="10">
    <p>Кількість статей:</p>
    <input type="number"
      name="articles_cnt"
      value="<?php echo $sitedata[2] ?: '4'?>"
      min="1"
      max="10">
    <p>Копірайт:</p>
    <textarea name="copyright_text"
      value="<?php echo $sitedata[3] ?: ''?>"
      cols="30"
      rows="10"></textarea>
    <p>Текст лінка:</p>
    <textarea name="link_text"
      value="<?php echo $sitedata[4] ?: ''?>"
      cols="30"
      rows="10"></textarea>
    <p>Індекс головної статті:</p>
    <input type="number"
      name="main_art_index"
      value="<?php echo $sitedata[5] ?: '0'?>"
      min="1"
      max="10">
    <br>
    <button type="submit">Далі -></button>
  </form>

</body>

</html>
