{
    prometheusAlerts+:: {
        groups+: [
            {
                name: 'allenmas-node-exporter',
                rules: [
                    {
                        alert: 'HighCPUPressure',
                        expr: |||
                            (
                                100 - (avg by (instance) (irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)
                            ),
                        ||| % $._config,
                    }
                ],
            }
        ],
    },
}
