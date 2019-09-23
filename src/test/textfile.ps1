$alpha = 42
$beta = @{ left=3.1415; right=2.718281828; }

Set-Content -Path test1.prom -Encoding Ascii -Value ""
Add-Content -Path test1.prom -Encoding Ascii -Value "# HELP test_alpha_total Some random metric."
Add-Content -Path test1.prom -Encoding Ascii -Value "# TYPE test_alpha_total counter"
Add-Content -Path test1.prom -Encoding Ascii -Value "test_alpha_total ${alpha}"
Add-Content -Path test1.prom -Encoding Ascii -Value "# HELP test_beta_bytes Some other metric."
Add-Content -Path test1.prom -Encoding Ascii -Value "# TYPE test_beta_bytes gauge"
foreach ($k in $beta.Keys) {
  Add-Content -Path test1.prom -Encoding Ascii -Value "test_beta_bytes{spin=""${k}""} $( $beta[$k] )"
}
