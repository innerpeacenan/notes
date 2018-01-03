
模拟 linux 的 whereis 命令

function whereis {
  Get-Command -CommandType Application -ErrorAction SilentlyContinue -Name $args[0] | Select-Object -ExpandProperty Definition
}