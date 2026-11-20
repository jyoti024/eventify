<?php
// Creates the tables (if missing) and loads sample events when the events
// table is empty. Runs automatically at container start; safe to re-run.

require __DIR__ . '/../db.php';

function run_sql_file(mysqli $conn, string $file): void {
    $conn->multi_query(file_get_contents($file));
    do {
        if ($r = $conn->store_result()) { $r->free(); }
    } while ($conn->more_results() && $conn->next_result());
}

run_sql_file($conn, __DIR__ . '/schema.sql');

$count = (int)$conn->query("SELECT COUNT(*) FROM events")->fetch_row()[0];
if ($count === 0 && getenv('SEED_SAMPLE_DATA') !== 'false') {
    run_sql_file($conn, __DIR__ . '/seed.sql');
    echo "Database initialised with sample events.\n";
} else {
    echo "Database ready.\n";
}
