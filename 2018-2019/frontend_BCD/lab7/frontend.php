<!-- CLIENT SIDE -->
<!DOCTYPE html>
<html>

<head>
  <meta http-equiv="content-type"
    content="text/html;charset=utf-8" />
  <title>Зразок оформлення веб-сторінки</title>
  <style>

    body {
      margin: 0px;
      height: 100%;
    }

    body * {
      text-decoration: none;
      font-family: Georgia, 'Times New Roman', Times, serif;
      color: #777;
      transition: all .3s;
    }

    h2 *,
    h3 * {
      color: #333;
    }

    #content {
      display: grid;
      grid-template: auto / repeat(3, 1fr);
      padding: 10px;
    }


    #content>h1 {
      grid-column: 1 / 3;
      font-style: italic;
    }

    #content #menu {
      list-style-type: none;
      align-self: flex-end;
      justify-self: center;
    }

    #content>#menu>li {
      display: inline;
      margin-left: 5px;
      margin-right: 5px;
    }

    .post {
      display: flex;
      flex-flow: row wrap;
      grid-column: 1 / 4;
      border-top: 1px solid #888;
      border-bottom: 1px solid #888;
    }

    .post>.details {
      flex: 1;
      border-right: 1px solid #888;
      margin: 10px 0px 10px 0px;
    }

    .post>.body {
      min-width: 300px;
      flex: 2;
      margin-left: 10px;
    }

    #footer {
      grid-column: 1 / 4;
      border-top: 1px solid #888;
    }

    .det a {
      color: rgb(224, 0, 0);
    }

    .det a:hover {
      color: orangered;
    }

    .info a,
    .info a:visited {
      border-bottom: 1px dashed #888;
    }

    @media screen and (max-width: 780px) {
      body * {
        color: black;
      }

      #content {
        grid-template-columns: 1fr 1fr;
        background: #ccc;
      }

      #content h1 {
        grid-column: 1 / 2;
      }

      #content #menu {
        grid-column: 1 / 2;
      }

      .post {
        grid-column: 1 / 3;
      }

      #footer {
        grid-column: 1 / 3;
      }

      .post .body {
        flex: 1;
      }
    }

    @media screen and (max-width: 500px) {
      body * {
        color: white;
      }

      #content {
        grid-template-columns: 1fr;
        background: #333;
      }

      #content h1 {
        grid-column: 1 / 1;
      }

      #content #menu {
        grid-column: 1 / 1;
      }

      .post {
        grid-column: 1 / 2;
      }

      .post .details {
        border-right: 0px;
      }

      #footer {
        grid-column: 1 / 2;
      }

      .post>.body {
        flex: 1;
      }
    }

  </style>
</head>

<body>
  <?php
    $db1 = new mysqli('localhost', 'kraftwerk28', '271828', 'kpi_frontend');

    // lab7 table
    $info = $db1->query("SELECT * FROM lab7")->fetch_assoc();
    $articles = $db1->query("SELECT * FROM lab7_articles");
    $menu = $db1->query("SELECT * FROM lab7_puncts")->fetch_all();
    
    $db1->close();
  ?>

  <div id="content">
    <h1><?php echo $info['title']?></h1>
    <ul id="menu">
      <?php 
        for ($i = 0; $i < $info['punct_num']; $i++) {
          $text = $menu[$i][0];
          echo "<li><a href='#'>$text</a></li>";
        }
      ?>
    </ul>
    <div class="post">
      <div class="details">
        <?php
          $ind = $info['main_annot_index'];
          $res = NULL;
          while($ind-- >= 0) {
            $res = $articles->fetch_array($resulttype=MYSQLI_ASSOC);
          }
          $articles->data_seek(0);

          $title = $res['title'];
          $text = $res['text'];

          echo "<h2><a href='#'>$text</a></h2>";
        ?>
        <!-- <h2><a href="#">Тут щось незрозуміле</a></h2> -->
        <p class="info">опубліковано 5хв. тому у секції <a href="#">загальне</a></p>
      </div>
      <div class="body">
        <p><?php echo "$text"?></p>
      </div>
      <div class="x"></div>
    </div>
    <?php
      $pass = $info['main_annot_index'];
      for ($i = 0; $i < $info['sections_cnt']; $i++) {
        if ($i == $pass) continue;
        $data = $articles->fetch_assoc();
        $title = $data['title'];
        $text = $data['text'];
        echo "
          <div class='col'>
            <h3><a href='#'>$title</a></h3>
            <p>$text</p>
            
          </div>
        ";
      }
    
    
    ?>
    <div id="footer">
      <p><?php echo $info['copyright']?></p>
    </div>
  </div>
</body>

</html>
