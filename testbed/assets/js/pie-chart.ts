import { html, css, LitElement } from 'lit';
import { customElement, property, query } from 'lit/decorators.js';
import Chart from 'chart.js/auto';

@customElement('pie-chart')
export class PieChartElement extends LitElement {
  @property({ attribute: 'chart-data', type: Object })
  chartData: {};

  @property()
  label: string;

  chart: Chart<"pie">;

  @query('#chart')
  chartContainer: HTMLCanvasElement;

  render() {
    return html`
      <canvas id="chart"></canvas>
    `;
  }

  firstUpdated() {
    this.chart = new Chart<"pie">(
      this.chartContainer,
      {
        type: 'pie',
        data: {
          labels: Object.keys(this.chartData),
          datasets: [
            {
              label: 'Pies I have eaten',
              data: Object.values(this.chartData)
            }
          ]
        }
      }
    );
  }

  updated() {
    this.chart.data.datasets[0].data = Object.values(this.chartData);
    this.chart.update();
  }

}
