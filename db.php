<?php
// Database configuration.
// Reads environment variables (used on Render / Docker) and falls back to
// the original local XAMPP/WAMP defaults so it still works on localhost.

$host     = getenv('DB_HOST')     ?: "localhost";
$port     = (int)(getenv('DB_PORT') ?: 3306);
$user     = getenv('DB_USER')     ?: "root";
$password = getenv('DB_PASSWORD') !== false ? getenv('DB_PASSWORD') : "";
$database = getenv('DB_NAME')     ?: "event_booking";
$useSsl   = in_array(strtolower((string)getenv('DB_SSL')), ['1', 'true', 'yes', 'on'], true);

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

try {
    $conn = mysqli_init();
    $flags = 0;

    if ($useSsl) {
        // Managed MySQL providers (Aiven, TiDB Cloud, etc.) require TLS.
        $conn->ssl_set(null, null, null, null, null);
        $flags = MYSQLI_CLIENT_SSL;
    }

    $conn->real_connect($host, $user, $password, $database, $port, null, $flags);
    $conn->set_charset("utf8mb4");
} catch (mysqli_sql_exception $e) {
    error_log("Database connection failed: " . $e->getMessage());
    http_response_code(500);
    die("Database connection failed. Please check the database settings.");
}
