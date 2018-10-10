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
    $info1 = $db1->query("SELECT * FROM lab7")->fetch_assoc();
    $sections_cnt = $db1->query("SELECT sections_cnt FROM lab7")->fetch_assoc();
    $articles = $db1->query("SELECT * FROM lab7_articles");
    
    // while($sections_cnt > 0) {
    //   echo $articles->fetch_assoc()[];
    // }
    
    
    
    
    $db1->close();
  ?>

  <div id="content">
    <h1><?php echo $info1['title']?></h1>
    <ul id="menu">
      <li><a href="#">головна</a></li>
      <li><a href="#">архів</a></li>
      <li><a href="#">контакти</a></li>
    </ul>
    <div class="post">
      <div class="details">
        <h2><a href="#">Тут щось незрозуміле</a></h2>
        <p class="info">опубліковано 5хв. тому у секції <a href="#">загальне</a></p>
      </div>
      <div class="body">
        <p>Тут щось незрозуміле написано, треба розбиратись. Отаке тут щось незрозуміле написано, а часу розбиратись
          немає.
          Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore
          magna
          aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
          consequat.
          Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. </p>
      </div>
      <div class="x"></div>
    </div>
    <div class="col">
      <h3><a href="#">І тут не ясно</a></h3>
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore
        magna
        aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
        consequat.
      </p>
      <p class="det">&not; <a href="#">детальніше</a></p>
    </div>
    <div class="col">
      <h3><a href="#">А тут взагалі абзац</a></h3>
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore
        magna
        aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
        consequat.
      </p>
      <p class="det">&not; <a href="#">детальніше</a></p>
    </div>
    <div class="col last">
      <h3><a href="#">Може я піду?</a></h3>
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore
        magna
        aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
        consequat.
      </p>
      <p class="det">&not; <a href="#">детальніше</a></p>
    </div>
    <div id="footer">
      <p>Copyright &copy; 2018 <em>Koвтyнeць O.B. &laquo;Beб-тexнoлoгiї&raquo;</em>
        &middot; Design: ІП-6х, <a href="http://asu.kpi.ua/"
          title="ACOI KПI">ACОIУ KПI</a></p>
    </div>
  </div>
</body>

</html>
