<!-- SERVER SIDE -->
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">

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

    .form-container > div {
      padding: 5px;
      border-bottom: 1px solid black;
    }

    .articles {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      grid-gap: 10px;
    }

    .articles > div {
      border: 1px solid white;
      padding: 5px;
    }

    .articles > div > p {
      margin-top: 5px;
    }


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
  </style>
  
  <title>Document</title>
</head>
<body>
  <?php
    $db1 = new mysqli('localhost', 'kraftwerk28', '271828', 'kpi_frontend');
    $title_text = $_POST['title_text'];
    $punct_num = (int)$_POST['puncts_cnt'];
    $sections_cnt = (int)$_POST['articles_cnt'];
    $copyright_text = $_POST['copyright_text'];
    $link_text = $_POST['link_text'];
    $main_art_index = $_POST['main_art_index'];
    $db1->query("UPDATE lab7 SET
      title='$title_text',
      punct_num=$punct_num,
      sections_cnt=$sections_cnt,
      copyright='$copyright_text',
      link_sign='$link_text',
      main_annot_index=$main_art_index");

  
    // $db1->close();
    // $db2 = new mysqli('localhost', 'kraftwerk28', '271828', 'kpi_frontend');
    // $
    // $articles = $db2->query("select");
    // function get_title($i) {

    // }
    
  ?>


  <form method="post"
    class="form-container"
    action="confirm.php">
    <?php
      echo "<div class='articles'>";
      for ($i = 0; $i < $sections_cnt; $i++) {
        echo "
          <div>
            <h4>Стаття №".($i + 1)."</h4>
            <p>Заголовок статті:</p>
            <input type='text'
              name='title$i'
              value=''>
            <p>Заголовок тексту статті:</p>
            <textarea type='text'
              name='text$i'
              value=''></textarea>
            <p>Час:</p>
            <input type='datetime-local'
              name='date$i'
              value=''>
          </div>
        ";
      }
      echo "</div>";
      echo "<div class='links'>";
      for ($i = 0; $i < $punct_num; $i++) {
        $num = $i + 1;
        echo "
          <input type='text'
            name='menu$i'
            value=''
            placeholder='Текст лінка №$num'>";
      }
      echo "</div>";
      
    ?>
    
    <button type="submit">Готово</button>
    
  </form>
  <form action="./index.php">
    <button type="submit">&lt;-Назад</button>
  </form>

  
</body>
</html>