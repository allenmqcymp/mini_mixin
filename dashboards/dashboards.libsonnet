local grafana = import 'grafonnet/grafana.libsonnet';
local dashboard = grafana.dashboard;
local row = grafana.row;
local prometheus = grafana.prometheus;
local template = grafana.template;
local graphPanel = grafana.graphPanel;
local promgrafonnet = import 'promgrafonnet/promgrafonnet.libsonnet';
local gauge = promgrafonnet.gauge;

{
    grafanaDashboards+:: {
    'allenma-nodes.json':
      local CPUUsage =
        graphPanel.new(
          'CPU Usage',
          datasource='$datasource',
          span=6,
          format='percentunit',
          max=1,
          min=0,
          stack=true,
        )
        .addTarget(prometheus.target(
          |||
            (
              (1 - rate(node_cpu_seconds_total{%(nodeExporterSelector)s, mode="idle", instance="$instance"}[$__interval]))
            / ignoring(cpu) group_left
              count without (cpu)( node_cpu_seconds_total{%(nodeExporterSelector)s, mode="idle", instance="$instance"})
            )
          ||| % $._config,
          legendFormat='{{cpu}}',
          intervalFactor=5,
          interval='1m',
        ));
    }
}
