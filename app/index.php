<?php
  require('includes/base.php');
?>

<?php require('includes/partials/header.php'); ?>

<?php
  if (isset($_GET['id'])) {
    $item = get_by_id('items', $_GET['id']);

    show_item($item);
  } else {
    $items = get_all('items', 'updated_at desc');

    // show_items_table($items);
    foreach ($items as $item) {
      show_item($item);
    }
  }

?>

<?php require('includes/partials/footer.php'); ?>
