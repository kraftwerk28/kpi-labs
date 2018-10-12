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
    body {
      background: #333;
    }

    * {
      color: white;
      font-family: monospace;
    }

    button, input, textarea {
      color: black;
    }
    
    p {
      margin-top: 10px;
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
    $sitedata = $db->query("SELECT * FROM lab7")->fetch_assoc();
    
    $db->close();
  ?>
  <form method="post"
    class="form-container"
    action="article_edit.php">
    <p>Заголовок статті:</p>
    <input type="text"
      placeholder="Заголовок"
      size="20"
      value="<?php echo $sitedata['title'] ?: 'none'?>"
      name="title_text">
    <p>Кількість пунктів меню:</p>
    <input type="number"
      name="puncts_cnt"
      value="<?php echo $sitedata['punct_num'] ?: '3'?>"
      min="1"
      max="10">
    <p>Кількість статей:</p>
    <input type="number"
      name="articles_cnt"
      value="<?php echo $sitedata['sections_cnt'] ?: '4'?>"
      min="1"
      max="10">
    <p>Копірайт:</p>
    <textarea name="copyright_text"
      cols="30"
      rows="10"><?php echo $sitedata['copyright'] ?: ''?></textarea>
    <p>Текст лінка:</p>
    <textarea name="link_text"
      cols="30"
      rows="10"><?php echo $sitedata['link_sign'] ?: ''?></textarea>
    <p>Індекс головної статті:</p>
    <input type="number"
      name="main_art_index"
      value="<?php echo $sitedata['main_annot_index'] ?: '0'?>"
      min="0"
      max="10">
    <br>
    <button type="submit">Далі -></button>
  </form>

</body>

</html>
