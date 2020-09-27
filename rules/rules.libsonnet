{
  prometheusRules+:: {
    groups+: [
      {
        name: 'allenma-node-exporter.rules',
        rules: [
          {
            // CPU utilisation is % CPU is not idle.
            record: 'instance2:node_cpu_utilisation:rate1m',
            expr: |||
              1 - avg without (cpu, mode) (
                rate(node_cpu_seconds_total{%(nodeExporterSelector)s, mode="idle"}[1m])
              )
            ||| % $._config,
          },
        ],
      },
    ],
  },
}
